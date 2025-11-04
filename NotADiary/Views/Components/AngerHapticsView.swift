import SwiftUI

struct AngerHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playAngerRage()
            }
            
            Button("2") {
                hapticEngine.playAngerTension()
            }
            
            Button("3") {
                hapticEngine.playAngerStrike()
            }
            
            Button("4") {
                hapticEngine.playAngerExplosive()
            }
        }
        .navigationTitle("Raiva")
    }
}

#Preview {
    NavigationStack {
        AngerHapticsView()
    }
}
