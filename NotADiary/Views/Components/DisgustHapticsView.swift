import SwiftUI

struct DisgustHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Button("1") {
                hapticEngine.playDisgustRecoil()
            }
            
            Button("2") {
                hapticEngine.playDisgustNausea()
            }
            
            Button("3") {
                hapticEngine.playDisgustCrawling()
            }
            
            Button("4") {
                hapticEngine.playDisgustGross()
            }
        }
        .navigationTitle("Nojo")
    }
}

#Preview {
    NavigationStack {
        DisgustHapticsView()
    }
}
