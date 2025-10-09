import HealthKit
import SwiftUI

struct ContentView: View {
    
    
    
    // MARK: - Properties
    
    @State private var steps = 0
    
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("You walked \(steps) steps today!")
        }
        .task {
            await HealthManager.shared.requestHealthAuthorization()
            await HealthManager.shared.calculateSteps()
            
            //await alone doesn`t work as intended
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                steps = HealthManager.shared.getSteps()
            }
        }
        
    }

}
