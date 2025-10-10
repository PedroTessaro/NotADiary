//
//  ContentView.swift
//  musicaa
//
//  Created by Enzo Ferroni on 10/10/25.
//

import SwiftUI
import MusicKit

struct Item: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let artist: String
    let imageURL: URL?
}

struct ContentView: View {
    @State private var songs = [Item]()
    
    var body: some View {
        NavigationView {
            List(songs) { song in
                HStack {
                    AsyncImage(url: song.imageURL)
                        .frame(width: 75, height: 75, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(song.name)
                            .font(.title3)
                        Text(song.artist)
                            .font(.footnote)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            fetchMusic()
        }
        
    }
    
    private let request: MusicCatalogSearchRequest = {
        var request = MusicCatalogSearchRequest(term: "Imagine Dragons", types: [Song.self])
        request.limit = 25
        return request
    }()
    
    private func fetchMusic() {
        Task{
            let status = await MusicAuthorization.request()
            switch status {
            case .authorized:
                do {
                    let results = try await request.response()
                    self.songs = results.songs.compactMap({
                        return .init(name: $0.title, artist: $0.artistName, imageURL: $0.artwork?.url(width: 75, height: 75))
                    })
                    print(String(describing: songs[0]))
                }catch {
                    print(String(describing: error))
                }
            default:
                break
            }
        }
    }
}

#Preview {
    ContentView()
}
