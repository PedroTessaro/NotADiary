//
//  MusicView.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 17/10/25.
//

import SwiftUI
import MusicKit

struct MusicView: View {
    @State private var viewModel = MusicPlayerViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if viewModel.isAuthorized {
                    VStack(spacing: 0) {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.songs) { song in
                                    SongRow(song: song, hapticsManager: viewModel.hapticsManager) {
                                        Task {
                                            await viewModel.playSong(song)
                                        }
                                    }
                                    .background(Color.white.opacity(0.1))
                                }
                            }
                            .padding()
                            .padding(.bottom, 100)
                        }
                        .searchable(text: $searchText, prompt: "Search music")
                        .onSubmit(of: .search) {
                            Task {
                                await viewModel.searchMusic(term: searchText)
                            }
                        }
                        .onChange(of: searchText) { oldValue, newValue in
                            if !newValue.isEmpty && newValue.count > 2 {
                                Task {
                                    await viewModel.searchMusic(term: newValue)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                    if let currentSong = viewModel.currentSong {
                        VStack {
                            Spacer()
                            
                            VStack(spacing: 10) {
                                Text(currentSong.title)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                if viewModel.hapticsManager.isHapticsActive {
                                    if viewModel.hapticsManager.isHapticsAvailable {
                                        HStack {
                                            Image(systemName: "waveform")
                                                .foregroundColor(.green)
                                            Text("Haptics ON")
                                                .foregroundColor(.green)
                                                .font(.caption)
                                        }
                                    } else {
                                        Text("No haptic track")
                                            .foregroundColor(.orange)
                                            .font(.caption)
                                    }
                                }
                                
                                Button {
                                    Task {
                                        await viewModel.togglePlayPause()
                                    }
                                } label: {
                                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(20)
                            .padding()
                        }
                    }
                } else {
                    VStack {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                        
                        Text("Loading...")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            .task {
                await viewModel.requestMusicAuthorization()
                if viewModel.isAuthorized {
                    await viewModel.searchMusic(term: "Bangrang")
                }
            }
        }
    }
}
