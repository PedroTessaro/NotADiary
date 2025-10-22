//
//  SongDetailView.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 22/10/25.
//

import SwiftUI
import MusicKit

struct SongDetailView: View {
    @State private var viewModel = MusicPlayerViewModel()
    @State private var loadedSong: Song?
    let songId: String
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Loaded Song")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                
                if let song = loadedSong {
                    SongRow(song: song, hapticsManager: viewModel.hapticsManager) {
                        Task {
                            await viewModel.playSong(song)
                        }
                    }
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                } else {
                    ProgressView()
                        .tint(.white)
                }
                
                Spacer()
            }
        }
        .task {
            loadedSong = await viewModel.fetchSongById(songId)
        }
    }
}
