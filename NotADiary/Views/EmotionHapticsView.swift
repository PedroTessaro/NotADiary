import SwiftUI

struct EmotionHapticsView: View {
    private let hapticEngine = EmotionHapticEngine()
    
    var body: some View {
        List {
            Section("Joy") {
                Button("Bouncy ★") { hapticEngine.playJoyBouncy() }
                Button("Warm") { hapticEngine.playJoyWarm() }
                Button("Uplifting ★") { hapticEngine.playJoyUplifting() }
                Button("Sparkle ★") { hapticEngine.playJoySparkle() }
            }
            
            Section("Sadness") {
                Button("Heavy ★") { hapticEngine.playSadnessHeavy() }
                Button("Melancholy ★") { hapticEngine.playSadnessMelancholy() }
                Button("Tearful ★") { hapticEngine.playSadnessTearful() }
                Button("Sinking ★") { hapticEngine.playSadnessSinking() }
            }

            Section("Fear") {
                Button("Tight Chest") { hapticEngine.playFearTightChest() }
                Button("Dread ★") { hapticEngine.playFearDread() }
                Button("Jump Scare") { hapticEngine.playFearJumpScare() }
                Button("Trembling ★") { hapticEngine.playFearTrembling() }
            }
            
            Section("Disgust") {
                Button("Recoil") { hapticEngine.playDisgustRecoil() }
                Button("Nausea") { hapticEngine.playDisgustNausea() }
                Button("Crawling ★") { hapticEngine.playDisgustCrawling() }
                Button("Gross") { hapticEngine.playDisgustGross() }
            }
            
            Section("Anger") {
                Button("Rage ★") { hapticEngine.playAngerRage() }
                Button("Tension") { hapticEngine.playAngerTension() }
                Button("Strike") { hapticEngine.playAngerStrike() }
                Button("Explosive ★") { hapticEngine.playAngerExplosive() }
            }
            
            Section("Surprise") {
                Button("Gasp") { hapticEngine.playSurpriseGasp() }
                Button("Oh Moment") { hapticEngine.playSurpriseOhMoment() }
                Button("Delighted") { hapticEngine.playSurpriseDelighted() }
                Button("Shock") { hapticEngine.playSurpriseShock() }
            }
            
            Section("Others") {
                Button("Jump Scare") { hapticEngine.playFearJumpScare() }
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
