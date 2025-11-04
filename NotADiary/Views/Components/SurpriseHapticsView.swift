import SwiftUI

struct SurpriseHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playSurpriseGasp()
            }
            
            Button("2") {
                hapticEngine.playSurpriseOhMoment()
            }
            
            Button("3") {
                hapticEngine.playSurpriseDelighted()
            }
            
            Button("4") {
                hapticEngine.playSurpriseShock()
            }
        }
        .navigationTitle("Surpresa")
    }
}

#Preview {
    NavigationStack {
        SurpriseHapticsView()
    }
}
