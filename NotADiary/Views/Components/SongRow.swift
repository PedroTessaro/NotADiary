import SwiftUI
import MusicKit

struct SongRow: View {
    let song: Song
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
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
            .cornerRadius(10)
        }
    }
}
