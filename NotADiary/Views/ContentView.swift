//
//  ContentView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    var body: some View {
        HomeScreenView()
            .environment(ckViewModel)
    }
}

#Preview {
    ContentView()
}
