import Foundation
import MusicKit
import SwiftUI
import MediaPlayer
import AVFoundation
import Observation

@Observable
@MainActor
class MusicPlayerViewModel {
    var songs = [Song]()
    var isPlaying: Bool = false
    var currentSong: Song?
    var isAuthorized: Bool = false
    
    private let musicPlayer = ApplicationMusicPlayer.shared
    let hapticsManager = MusicHapticsManager()
    private nonisolated(unsafe) var playbackUpdateTimer: Timer?
    
    init() {
        setupAudioSession()
        setupRemoteCommands()
        observePlayerState()
        startPlaybackTimeUpdates()
    }
    
    private func startPlaybackTimeUpdates() {
        playbackUpdateTimer?.invalidate()
        playbackUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.updatePlaybackTime()
            }
        }
    }
    
    private func updatePlaybackTime() {
        guard isPlaying, let currentSong = currentSong else { return }
        
        let currentTime = musicPlayer.playbackTime
        
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [:]
        nowPlayingInfo[MPMediaItemPropertyTitle] = currentSong.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = currentSong.artistName
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = currentTime
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        
        if let duration = currentSong.duration {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        }
        
        if let isrc = currentSong.isrc {
            nowPlayingInfo[MPNowPlayingInfoPropertyInternationalStandardRecordingCode] = isrc
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    deinit {
        playbackUpdateTimer?.invalidate()
    }
    
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    private func setupRemoteCommands() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] _ in
            Task { @MainActor in
                await self?.togglePlayPause()
            }
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            Task { @MainActor in
                await self?.togglePlayPause()
            }
            return .success
        }
    }
    
    private nonisolated func observePlayerState() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task { @MainActor in
                self.isPlaying = self.musicPlayer.state.playbackStatus == .playing
            }
        }
    }
    
    func requestMusicAuthorization() async {
        let status = await MusicAuthorization.request()
        isAuthorized = status == .authorized
    }
    
    func searchMusic(term: String) async {
        guard isAuthorized else { return }
        
        var request = MusicCatalogSearchRequest(term: term, types: [Song.self])
        request.limit = 25
        
        let results = try? await request.response()
        songs = results?.songs.compactMap({ $0 }) ?? []
    }
    
    func playSong(_ song: Song) async {
        currentSong = song
        musicPlayer.queue = [song]
        try? await musicPlayer.play()
        isPlaying = true
        
        updateNowPlayingInfo(for: song)
        
        if let isrc = song.isrc {
            await hapticsManager.checkHapticAvailability(for: isrc)
        } else {
            hapticsManager.isHapticsAvailable = false
        }
    }
    
    private func updateNowPlayingInfo(for song: Song) {
        var nowPlayingInfo = [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = song.title
        nowPlayingInfo[MPMediaItemPropertyArtist] = song.artistName
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = song.albumTitle ?? ""
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
        
        if let duration = song.duration {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        }
        
        if let isrc = song.isrc {
            nowPlayingInfo[MPNowPlayingInfoPropertyInternationalStandardRecordingCode] = isrc
            print("✅ ISRC set: \(isrc)")
        } else {
            print("⚠️ No ISRC available for: \(song.title)")
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        
        if let artwork = song.artwork {
            Task.detached {
                if let url = artwork.url(width: 600, height: 600) {
                    let request = URLRequest(url: url)
                    if let (data, _) = try? await URLSession.shared.data(for: request),
                       let image = UIImage(data: data) {
                        let mediaArtwork = MPMediaItemArtwork(boundsSize: image.size) { _ in image }
                        
                        await MainActor.run {
                            var updatedInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? nowPlayingInfo
                            updatedInfo[MPMediaItemPropertyArtwork] = mediaArtwork
                            updatedInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 0.0
                            updatedInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
                            
                            if let isrc = song.isrc {
                                updatedInfo[MPNowPlayingInfoPropertyInternationalStandardRecordingCode] = isrc
                            }
                            
                            MPNowPlayingInfoCenter.default().nowPlayingInfo = updatedInfo
                        }
                    }
                }
            }
        }
    }
    
    func togglePlayPause() async {
        if isPlaying {
            musicPlayer.pause()
            isPlaying = false
        } else {
            try? await musicPlayer.play()
            isPlaying = true
        }
    }
    
    func playNext() async {
        try? await musicPlayer.skipToNextEntry()
    }
    
    func playPrevious() async {
        try? await musicPlayer.skipToPreviousEntry()
    }
}
