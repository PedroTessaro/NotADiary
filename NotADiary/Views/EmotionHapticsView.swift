import SwiftUI

struct EmotionHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Section("Joy") {
                Button("Bouncy ★") { hapticEngine.playJoyBouncy() }
                Button("Warm Pulse") { hapticEngine.playJoyWarmPulse() }
                Button("Celebration") { hapticEngine.playJoyCelebration() }
                Button("Sparkle ★") { hapticEngine.playJoySparkle() }
            }
            
            Section("Sadness") {
                Button("Heavy ★") { hapticEngine.playSadnessHeavy() }
                Button("Melancholy ★") { hapticEngine.playSadnessMelancholy() }
                Button("Tearful ★") { hapticEngine.playSadnessTearful() }
                Button("Sinking ★") { hapticEngine.playSadnessSinking() }
            }
            
            Section("Fear") {
                Button("Panic") { hapticEngine.playFearPanic() }
                Button("Anxious") { hapticEngine.playFearAnxious() }
                Button("Startled") { hapticEngine.playFearStartled() }
                Button("Trembling ★ (aumentar)") { hapticEngine.playFearTrembling() }
            }
            
            Section("Disgust (com animacao talvez)") {
                Button("Recoil") { hapticEngine.playDisgustRecoil() }
                Button("Uncomfortable") { hapticEngine.playDisgustUncomfortable() }
                Button("Nauseous") { hapticEngine.playDisgustNauseous() }
                Button("Repulsive") { hapticEngine.playDisgustRepulsive() }
            }
            
            Section("Anger") {
                Button("Intense Burst") { hapticEngine.playAngerIntenseBurst() }
                Button("Simmering") { hapticEngine.playAngerSimmering() }
                Button("Pounding") { hapticEngine.playAngerPounding() }
                Button("Explosive ★") { hapticEngine.playAngerExplosive() }
            }
            
            Section("Surprise (morra)") {
                Button("Quick Pop") { hapticEngine.playSurpriseQuickPop() }
                Button("Sparkle") { hapticEngine.playSurpriseSparkle() }
                Button("Gasp") { hapticEngine.playSurpriseGasp() }
                Button("Shock") { hapticEngine.playSurpriseShock() }
            }
        }
        .navigationTitle("Emotion Haptics")
    }
}

#Preview {
    NavigationStack {
        EmotionHapticsView()
    }
}
