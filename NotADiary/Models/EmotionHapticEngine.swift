import CoreHaptics
import SwiftUI

class EmotionHapticEngine {
    private var engine: CHHapticEngine?
    
    init() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine error: \(error.localizedDescription)")
        }
    }
    
    private func playPattern(events: [CHHapticEvent]) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Joy Patterns
    
    func playJoyBouncy() {
        var events = [CHHapticEvent]()
        
        for i in 0..<5 {
            let time = Double(i) * 0.12
            let intensity = Float(0.4 + Double(i) * 0.1)
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: time)
            events.append(event)
        }
        playPattern(events: events)
    }
    
    func playJoyWarm() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 0, duration: 0.4),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.15)
            ], relativeTime: 0.45, duration: 0.4),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 0.9, duration: 0.3)
        ]
        playPattern(events: events)
    }
    
    func playJoyUplifting() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 0, duration: 0.25),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.3, duration: 0.25),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0.6, duration: 0.3),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0.95)
        ]
        playPattern(events: events)
    }
    
    func playJoySparkle() {
        var events = [CHHapticEvent]()
        let timings: [Double] = [0.0, 0.06, 0.12, 0.2, 0.26, 0.35, 0.42]
        
        for timing in timings {
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: timing)
            events.append(event)
        }
        playPattern(events: events)
    }
    
    // MARK: - Sadness Patterns
    
    func playSadnessHeavy() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0, duration: 0.6),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 0.65, duration: 0.5)
        ]
        playPattern(events: events)
    }
    
    func playSadnessMelancholy() {
        var events = [CHHapticEvent]()
        
        for i in 0..<4 {
            let time = Double(i) * 0.3
            let intensity = Float(0.7 - Double(i) * 0.15)
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: time)
            events.append(event)
        }
        playPattern(events: events)
    }
    
    func playSadnessTearful() {
        var events = [CHHapticEvent]()
        let cryTimings: [Double] = [0.0, 0.3, 0.6, 0.85, 1.05, 1.2]
        
        for timing in cryTimings {
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: timing)
            events.append(event)
        }
        playPattern(events: events)
    }
    
    func playSadnessSinking() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0, duration: 0.4),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.45, duration: 0.5),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: 1.0, duration: 0.6)
        ]
        playPattern(events: events)
    }
    
    // MARK: - Fear Patterns
    
    func playFearTightChest() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0, duration: 0.5),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
            ], relativeTime: 0.55, duration: 0.6),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.85),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 1.2, duration: 0.5)
        ]
        playPattern(events: events)
    }
    
    func playFearDread() {
        var events = [CHHapticEvent]()
        
        let dreadTimings: [(time: Double, intensity: Float)] = [
            (0.0, 0.6),
            (0.5, 0.7),
            (0.95, 0.8),
            (1.35, 0.9)
        ]
        
        for (time, intensity) in dreadTimings {
            events.append(CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: time))
            
            events.append(CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity * 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)
            ], relativeTime: time + 0.05, duration: 0.3))
        }
        
        playPattern(events: events)
    }
    
    func playFearJumpScare() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.03, duration: 0.12),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0.2, duration: 0.4)
        ]
        playPattern(events: events)
    }
    
    func playFearTrembling() {
        var events = [CHHapticEvent]()
        let trembleTimes: [Double] = [0.0, 0.08, 0.15, 0.19, 0.28, 0.35, 0.42, 0.47, 0.55, 0.62, 0.7, 0.78]
        
        for time in trembleTimes {
            let intensity: Float = Float.random(in: 0.4...0.7)
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: time)
            events.append(event)
        }
        playPattern(events: events)
    }
    
    // MARK: - Disgust Patterns
    
    func playDisgustRecoil() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.95),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.85)
            ], relativeTime: 0.1)
        ]
        playPattern(events: events)
    }
    
    func playDisgustNausea() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.15)
            ], relativeTime: 0, duration: 0.35),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.2)
            ], relativeTime: 0.4, duration: 0.35),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.15)
            ], relativeTime: 0.8, duration: 0.4)
        ]
        playPattern(events: events)
    }
    
    func playDisgustCrawling() {
        var events = [CHHapticEvent]()
        
        let crawlTimings: [(time: Double, intensity: Float)] = [
            (0.0, 0.3), (0.08, 0.4), (0.12, 0.35),
            (0.22, 0.45), (0.28, 0.3), (0.35, 0.5),
            (0.42, 0.35), (0.5, 0.4), (0.58, 0.45),
            (0.65, 0.3), (0.72, 0.5), (0.8, 0.35)
        ]
        
        for (time, intensity) in crawlTimings {
            events.append(CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: time))
        }
        
        playPattern(events: events)
    }
    
    func playDisgustGross() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.55),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.25)
            ], relativeTime: 0, duration: 0.25),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.4)
            ], relativeTime: 0.3),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
            ], relativeTime: 0.4, duration: 0.35)
        ]
        playPattern(events: events)
    }
    
    // MARK: - Anger Patterns
    
    func playAngerRage() {
        var events = [CHHapticEvent]()
        
        let rageTimings: [Double] = [0.0, 0.12, 0.22, 0.3, 0.36, 0.42, 0.5]
        for (index, timing) in rageTimings.enumerated() {
            let intensity: Float = index < 3 ? 0.95 : 1.0
            events.append(CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: timing))
        }
        
        events.append(CHHapticEvent(eventType: .hapticContinuous, parameters: [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
        ], relativeTime: 0.55, duration: 0.4))
        
        playPattern(events: events)
    }
    
    func playAngerTension() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0, duration: 0.5),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.75),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
            ], relativeTime: 0.55, duration: 0.5),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 1.1, duration: 0.4)
        ]
        playPattern(events: events)
    }
    
    func playAngerStrike() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.95)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0.05, duration: 0.2)
        ]
        playPattern(events: events)
    }
    
    func playAngerExplosive() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.05, duration: 0.15),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.3),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.9),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.35, duration: 0.2)
        ]
        playPattern(events: events)
    }
    
    // MARK: - Surprise Patterns
    
    func playSurpriseGasp() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.85),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.6)
            ], relativeTime: 0.05, duration: 0.2)
        ]
        playPattern(events: events)
    }
    
    func playSurpriseOhMoment() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
            ], relativeTime: 0.15),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            ], relativeTime: 0.25, duration: 0.3)
        ]
        playPattern(events: events)
    }
    
    func playSurpriseDelighted() {
        var events = [CHHapticEvent]()
        let delightTimings: [Double] = [0.0, 0.12, 0.22, 0.35, 0.45]
        
        for (index, timing) in delightTimings.enumerated() {
            let intensity = Float(0.5 + Double(index) * 0.08)
            events.append(CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.75)
            ], relativeTime: timing))
        }
        playPattern(events: events)
    }
    
    func playSurpriseShock() {
        let events: [CHHapticEvent] = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous, parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.7),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            ], relativeTime: 0.05, duration: 0.15)
        ]
        playPattern(events: events)
    }
}
