import Foundation
import CoreHaptics

// MARK: - Emotion Haptic Engine

class EmotionHapticEngine {
    private var engine: CHHapticEngine?
    
    init() {
        prepareHaptics()
    }
    
    private func prepareHaptics() {  
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine creation error: \(error)")
        }
    }
    
    // MARK: - Joy Patterns
    
    func playJoyBouncy() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0.15),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.28),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.38)
        ]
        playPattern(events: events)
    }
    
    func playJoyWarmPulse() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0, duration: 0.5),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0.6)
        ]
        playPattern(events: events)
    }
    
    func playJoyCelebration() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.1),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.2),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.3),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.4)
        ]
        playPattern(events: events)
    }
    
    func playJoySparkle() {
        // Multiple quick light taps like magical sparkles (researched pattern)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        // Create sparkle effect with 8 quick light taps at random-feeling intervals
        let sparkleTimings: [Double] = [0.0, 0.08, 0.15, 0.20, 0.28, 0.35, 0.40, 0.48]
        for timing in sparkleTimings {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float.random(in: 0.3...0.5))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: timing)
            events.append(event)
        }
        
        playPattern(events: events)
    }
    
    // MARK: - Sadness Patterns
    
    func playSadnessHeavy() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 0, duration: 0.4),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 0.5, duration: 0.4)
        ]
        playPattern(events: events)
    }
    
    func playSadnessMelancholy() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.3),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.6),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.9)
        ]
        playPattern(events: events)
    }
    
    func playSadnessTearful() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0.5),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 1.0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 1.5)
        ]
        playPattern(events: events)
    }
    
    func playSadnessSinking() {
        // Slow descending continuous vibration like sinking feeling (researched pattern)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0, duration: 0.6),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.65, duration: 0.6),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 1.3, duration: 0.5)
        ]
        
        playPattern(events: events)
    }
    
    // MARK: - Fear Patterns
    
    func playFearPanic() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.2),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.35),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.45),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.52)
        ]
        playPattern(events: events)
    }
    
    func playFearAnxious() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.15),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0.35),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.5),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0.7)
        ]
        playPattern(events: events)
    }
    
    func playFearStartled() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0.05, duration: 0.2)
        ]
        playPattern(events: events)
    }
    
    func playFearTrembling() {
        // Irregular trembling vibration like shaking from fear (researched pattern)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        // Create irregular trembling pattern with varying intensity
        for i in 0..<15 {
            let timing = Double(i) * 0.08
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float.random(in: 0.6...0.9))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float.random(in: 0.7...1.0))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: timing)
            events.append(event)
        }
        
        playPattern(events: events)
    }
    
    // MARK: - Disgust Patterns
    
    func playDisgustRecoil() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.08)
        ]
        playPattern(events: events)
    }
    
    func playDisgustUncomfortable() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.12),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.3),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.45)
        ]
        playPattern(events: events)
    }
    
    func playDisgustNauseous() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0, duration: 0.3),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0.35, duration: 0.3),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.7, duration: 0.3)
        ]
        playPattern(events: events)
    }
    
    func playDisgustRepulsive() {
        // Sharp rejection with continuous uncomfortable buzz (researched pattern)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        // Initial sharp recoil
        let recoilIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9)
        let recoilSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let recoil = CHHapticEvent(eventType: .hapticTransient, parameters: [recoilIntensity, recoilSharpness], relativeTime: 0)
        events.append(recoil)
        
        // Followed by uncomfortable buzz
        let buzzIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
        let buzzSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
        let buzz = CHHapticEvent(eventType: .hapticContinuous, parameters: [buzzIntensity, buzzSharpness], relativeTime: 0.15, duration: 0.4)
        events.append(buzz)
        
        playPattern(events: events)
    }
    
    // MARK: - Anger Patterns
    
    func playAngerIntenseBurst() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.05, duration: 0.2)
        ]
        playPattern(events: events)
    }
    
    func playAngerSimmering() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0, duration: 0.3),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.35, duration: 0.3),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.7, duration: 0.3)
        ]
        playPattern(events: events)
    }
    
    func playAngerPounding() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.4),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.8)
        ]
        playPattern(events: events)
    }
    
    func playAngerExplosive() {
        // Sudden explosive burst followed by intense rumble (researched pattern)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        // Massive initial explosion
        let explosionIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let explosionSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let explosion = CHHapticEvent(eventType: .hapticTransient, parameters: [explosionIntensity, explosionSharpness], relativeTime: 0)
        events.append(explosion)
        
        // Intense rumbling aftermath
        let rumbleIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)
        let rumbleSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
        let rumble = CHHapticEvent(eventType: .hapticContinuous, parameters: [rumbleIntensity, rumbleSharpness], relativeTime: 0.1, duration: 0.6)
        events.append(rumble)
        
        // Secondary explosion
        let secondExplosion = CHHapticEvent(eventType: .hapticTransient, parameters: [explosionIntensity, explosionSharpness], relativeTime: 0.4)
        events.append(secondExplosion)
        
        playPattern(events: events)
    }
    
    // MARK: - Surprise Patterns
    
    func playSurpriseQuickPop() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0)
        ]
        playPattern(events: events)
    }
    
    func playSurpriseSparkle() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.08),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.15),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0.23),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.3)
        ]
        playPattern(events: events)
    }
    
    func playSurpriseGasp() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0.05, duration: 0.15)
        ]
        playPattern(events: events)
    }
    
    func playSurpriseShock() {
        // Electric shock-like sudden burst (researched pattern)
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        // Sudden sharp shock
        let shockIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let shockSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let shock = CHHapticEvent(eventType: .hapticTransient, parameters: [shockIntensity, shockSharpness], relativeTime: 0)
        events.append(shock)
        
        // Brief high-frequency buzz
        let buzzIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7)
        let buzzSharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let buzz = CHHapticEvent(eventType: .hapticContinuous, parameters: [buzzIntensity, buzzSharpness], relativeTime: 0.05, duration: 0.15)
        events.append(buzz)
        
        // Secondary smaller shock
        let secondShockIntensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6)
        let secondShock = CHHapticEvent(eventType: .hapticTransient, parameters: [secondShockIntensity, shockSharpness], relativeTime: 0.25)
        events.append(secondShock)
        
        playPattern(events: events)
    }
    
    // MARK: - Helper Method
    
    private func playPattern(events: [CHHapticEvent]) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error)")
        }
    }
}
