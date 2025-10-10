import HealthKit
import SwiftUI

struct ContentView: View {
    
    
    
    // MARK: - Properties
    
    @State private var steps = 0
    @State private var results: [HKStateOfMind] = []
    @State private var relato: HKStateOfMind?
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("You walked \(steps) steps today!")
            ForEach(results, id: \.self) { result in
                Text("Emotions: \(result)")
            }
            Text("\(relato ?? nil)")
            
        }
        .task {
            await HealthManager.shared.requestHealthAuthorization()
            await HealthManager.shared.calculateSteps()
            
            //await alone doesn`t work as intended
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                steps = HealthManager.shared.getSteps()
            }
            results = await HealthManager.shared.fetchMoods()
            relato = HealthManager.shared.createSample(eventAssociation: HKStateOfMind.Association.family, userLabel: HKStateOfMind.Label.amazed, userValence: 1, endDate: Date())
            await HealthManager.shared.save(sample: relato!)
        }
        
    }

}
