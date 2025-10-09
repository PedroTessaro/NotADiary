import SwiftUI
import HealthKit


class HealthManager{
    
    public static let shared = HealthManager()
    
    private var steps = 0
    
    // MARK: - Methods
    
    func requestHealthAuthorization() async {
        
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        // Request authorization to read the user's step count from HealthKit
        try? await HKHealthStore().requestAuthorization(toShare: [], read: [HKQuantityType(.stepCount)])
        
    }
    
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
    
    func getSteps() -> Int {
        print(steps)
        return steps
    }
    
    func getEmotions() -> Int {
        print(steps)
        return steps
    }
    
}

