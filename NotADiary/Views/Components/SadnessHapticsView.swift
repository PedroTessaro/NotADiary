import SwiftUI

struct SadnessHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playSadnessHeavy()
            }
            
            Button("2") {
                hapticEngine.playSadnessMelancholy()
            }
            
            Button("3") {
                hapticEngine.playSadnessTearful()
            }
            
            Button("4") {
                hapticEngine.playSadnessSinking()
            }
        }
        .navigationTitle("Triste")
    }
}

#Preview {
    NavigationStack {
        SadnessHapticsView()
    }
}
