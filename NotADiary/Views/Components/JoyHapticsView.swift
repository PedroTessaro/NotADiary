import SwiftUI

struct JoyHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playJoyBouncy()
            }
            
            Button("2") {
                hapticEngine.playJoyWarm()
            }
            
            Button("3") {
                hapticEngine.playJoyUplifting()
            }
            
            Button("4") {
                hapticEngine.playJoySparkle()
            }
        }
        .navigationTitle("Feliz")
    }
}

#Preview {
    NavigationStack {
        JoyHapticsView()
    }
}
