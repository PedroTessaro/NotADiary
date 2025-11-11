//
//  MusicCardFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 06/11/25.
//

import SwiftUI
import MusicKit

struct MusicCardFullView: View {
    @State var isMusic: Bool = true
    @State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    @State var entry: JournalEntry
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    isMusic.toggle()
                } label: {
                    if isMusic {
                        HStack (alignment: .center) {
                            AsyncImage(url: song?.artwork?.url(width: 36, height: 36)) { phase in
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
                            .frame(width: 48, height: 48)
                            .cornerRadius(8)
                            VStack (alignment: .leading){
                                Text(song?.title ?? "")
                                    .foregroundStyle(.black)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                Text(song?.artistName ?? "")
                                    .foregroundStyle(.black)
                                    .font(.footnote)
                            }
                        }
                        .frame(width: 220, height: 48)
                    }
                    else {
                        AsyncImage(url: song?.artwork?.url(width: 36, height: 36)) { phase in
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
                        .frame(width: 48, height: 48)
                        .cornerRadius(8)
                    }
                }
                
                
                Button {
                    isMusic.toggle()
                } label: {
                    if !isMusic {
                        Label("Hepatic", systemImage: "microphone")
                            .frame(width: 220, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .font(.title3)
                        
                        
                        
                    }
                    else {
                        Image(systemName: "microphone")
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .font(.title3)
                        
                        
                    }
                }
                
            }
            .buttonStyle(.glass)
        }
        .padding(.horizontal)
        .onAppear() {
            Task {
                song = await mpViewModel.fetchSongById(entry.songID)
                
            }
        }
    }
}

