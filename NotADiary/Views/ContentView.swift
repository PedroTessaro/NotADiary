import SwiftUI
import MusicKit

struct ContentView: View {
    @State private var viewModel = MusicPlayerViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if viewModel.isAuthorized {
                VStack(spacing: 20) {
                    Text("Musickit")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.top, 60)
                    
                    HStack {
                        TextField("Search music", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                        
                        Button("Search") {
                            Task {
                                await viewModel.searchMusic(term: searchText)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(viewModel.songs) { song in
                                Button {
                                    Task {
                                        await viewModel.playSong(song)
                                    }
                                } label: {
                                    HStack {
                                        AsyncImage(url: song.artwork?.url(width: 50, height: 50)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.gray
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
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                        .padding(.bottom, 100)
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
