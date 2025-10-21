//
//  SongRow.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 17/10/25.
//

import SwiftUI
import MusicKit
import MediaAccessibility

struct SongRow: View {
    let song: Song
    let hapticsManager: MusicHapticsManager
    let onTap: () -> Void
    @State private var hasHaptics: Bool = false
    @State private var isChecking: Bool = true
    
    var body: some View {
        Button(action: {
            print("Song ID: \(song.id)")
            onTap()
        }) {
            HStack {
                AsyncImage(url: song.artwork?.url(width: 50, height: 50)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 50)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure(_):
                        ZStack {
                            Color.gray
                            Image(systemName: "music.note")
                                .foregroundColor(.white)
                        }
                    @unknown default:
                        Color.gray
                    }
                }
                .frame(width: 50, height: 50)
                .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text(song.title)
                        .foregroundColor(.white)
                    Text(song.artistName)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Spacer()
                
                if isChecking {
                    ProgressView()
                        .scaleEffect(0.7)
                        .tint(.gray)
                } else if hasHaptics {
                    Image(systemName: "waveform")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .cornerRadius(10)
        }
        .task {
            await checkHaptics()
        }
    }
    
    private func checkHaptics() async {
        guard let isrc = song.isrc else {
            isChecking = false
            return
        }
        
        await withCheckedContinuation { continuation in
            MAMusicHapticsManager.shared.checkHapticTrackAvailabilityForMedia(
                matchingCode: isrc
            ) { available in
                Task { @MainActor in
                    self.hasHaptics = available
                    self.isChecking = false
                    continuation.resume()
                }
            }
        }
    }
}
