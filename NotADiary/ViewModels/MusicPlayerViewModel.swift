//
//  MusicPlayerViewModel.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 17/10/25.
//

import Foundation
import MusicKit
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
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    func requestMusicAuthorization() async {
        let status = await MusicAuthorization.request()
        isAuthorized = status == .authorized
    }
    
    func searchMusic(term: String) async {
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
        }
    }
    
    private func updateNowPlayingInfo(for song: Song) {
        var info: [String: Any] = [
            MPMediaItemPropertyTitle: song.title,
            MPMediaItemPropertyArtist: song.artistName,
            MPNowPlayingInfoPropertyPlaybackRate: 1.0
        ]
        
        if let duration = song.duration {
            info[MPMediaItemPropertyPlaybackDuration] = duration
        }
        
        if let isrc = song.isrc {
            info[MPNowPlayingInfoPropertyInternationalStandardRecordingCode] = isrc
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = info
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
}
