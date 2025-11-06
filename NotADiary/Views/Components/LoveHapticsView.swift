import SwiftUI

struct LoveHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("Heartbeat") {
                hapticEngine.playLoveHeartbeat()
            }
            
            Button("Tender") {
                hapticEngine.playLoveTender()
            }
            
            Button("Butterflies") {
                hapticEngine.playLoveButterflies()
            }
            
            Button("Passionate") {
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
