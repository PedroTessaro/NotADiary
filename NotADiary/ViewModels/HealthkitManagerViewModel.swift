import SwiftUI
import HealthKit


class HealthManager{
    
    public static let shared = HealthManager()
    
    private var steps = 0
    private var results: [HKStateOfMind] = []
    
    // MARK: - Types
    
    private let moodType = HKObjectType.stateOfMindType()
    private let stepsType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
    // MARK: - Authorization
    
    func requestHealthAuthorization() async {
        
        //tratar a falta de disponiblidade do healthkit
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        // Request authorization to read the user's step count from HealthKit
        //tratar a falta de autorizacao do usuario
        try? await HKHealthStore().requestAuthorization(toShare: [moodType], read: [stepsType,moodType])
    }
    
    // MARK: - GettingSteps
    
    func calculateSteps() async {
        
        // To get the day's steps, start from midnight and end now
        let dateEnd = Date.now
        let dateStart = Calendar.current.startOfDay(for: .now)
        
        // To get daily steps data
        let dayComponent = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: dateStart, end: dateEnd, options: .strictStartDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: predicate)
        
        let descriptor = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate, options: .cumulativeSum, anchorDate: dateStart, intervalComponents: dayComponent
        )
        
        let result = try? await descriptor.result(for: HKHealthStore())
        
        // From the daily steps data, get today's step count samples
        result?.enumerateStatistics(from: dateStart, to: dateEnd) { [weak self] statistics, stop in
            // Sum up all step samples for the day
            let steps = Int(statistics.sumQuantity()?.doubleValue(for: .count()) ?? 0)
            print("A quantidade de passsos é: \(steps)")
            
            //Can crash the app, review if necessary
            
            DispatchQueue.main.async {
                self?.steps = steps
                print(steps)
            }
        }
        
    }
    
    // MARK: - Writing Mood
    
    /// Create State of Mind sample for an event and emoji selection
    
    func createSample(eventAssociation: HKStateOfMind.Association, userLabel: HKStateOfMind.Label, userValence: Double, endDate: Date) -> HKStateOfMind {
        let kind: HKStateOfMind.Kind = .momentaryEmotion
        let valence: Double = userValence
        let label = userLabel
        let association = eventAssociation
        return HKStateOfMind(date: endDate,
                             kind: kind,
                             valence: valence,
                             labels: [label],
                             associations: [association])
    }
    
    func save(sample: HKSample) async {
        do {
            try await HKHealthStore().save(sample)
        }
        catch {
            // Handle error here.
        }
    }
    
    // MARK: - Reading Mood
    
    // Busca os moods registrados num intervalo (ex: últimos 7 dias)
    
    func fetchMoods() async -> [HKStateOfMind] {
        
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        let stateOfMindPredicate = HKSamplePredicate.stateOfMind(datePredicate)
        
        let descriptor = HKSampleQueryDescriptor(predicates: [stateOfMindPredicate],
                                                 sortDescriptors: [])
        do {
            // Launch the query and wait for the results.
            results = try await descriptor.result(for: HKHealthStore())
        } catch {
            // Handle error here.
        }
        return results
    }
        func getSteps() -> Int {
            print(steps)
            return steps
        }
}
