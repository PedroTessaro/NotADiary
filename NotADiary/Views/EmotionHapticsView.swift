import SwiftUI

struct EmotionHapticsView: View {
    var body: some View {
        TabView {
            NavigationStack {
                JoyHapticsView()
            }
            .tabItem {
                Label("Feliz", systemImage: "face.smiling")
            }
            
            NavigationStack {
                SadnessHapticsView()
            }
            .tabItem {
                Label("Triste", systemImage: "cloud.rain")
            }
            
            NavigationStack {
                FearHapticsView()
            }
            .tabItem {
                Label("Medo", systemImage: "exclamationmark.triangle")
            }
            
            NavigationStack {
                DisgustHapticsView()
            }
            .tabItem {
                Label("Nojo", systemImage: "hand.raised")
            }
            
            NavigationStack {
                AngerHapticsView()
            }
            .tabItem {
                Label("Raiva", systemImage: "flame")
            }
            
            NavigationStack {
                SurpriseHapticsView()
            }
            .tabItem {
                Label("Surpresa", systemImage: "sparkles")
            }
        }
    }
}

#Preview {
    NavigationStack {
        EmotionHapticsView()
    }
}
