import SwiftUI

struct FearHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playFearTightChest()
            }
            
            Button("2") {
                hapticEngine.playFearDread()
            }
            
            Button("3") {
                hapticEngine.playFearJumpScare()
            }
            
            Button("4") {
                hapticEngine.playFearTrembling()
            }
        }
        .navigationTitle("Medo")
    }
}

#Preview {
    NavigationStack {
        FearHapticsView()
    }
}
