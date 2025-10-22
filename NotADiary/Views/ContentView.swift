//
//  ContentView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI

struct ContentView: View {
    
    var card = Card(name:"balba", id:"asda")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                    .padding()
            ShareLink(item: card, preview: .init(card.name))        }
        .padding()
    }
}

#Preview {
    ContentView()
}
