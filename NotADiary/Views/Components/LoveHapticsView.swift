import SwiftUI

struct LoveHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playLoveHeartbeat()
            }
            
            Button("2") {
                hapticEngine.playLoveTender()
            }
            
            Button("3") {
                hapticEngine.playLoveButterflies()
            }
            
            Button("4") {
                hapticEngine.playLovePassionate()
            }
        }
        .navigationTitle("Love")
    }
}

#Preview {
    NavigationStack {
        LoveHapticsView()
    }
}
