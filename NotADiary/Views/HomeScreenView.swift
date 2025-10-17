//
//  HomeScreenView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct HomeScreenView: View {
    @State var toggleSheet: Bool = false
    @State var entryList: [JournalEntry] = []
    @State var teste: String = ""
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Boas Vindas, \(ckViewModel.preference?.name ?? "")!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    Spacer()
                }
                
                ScrollView {
                    ForEach(Array(ckViewModel.entries.enumerated()), id: \.offset) { index, entry in
                        NavigationLink {
                            JournalEntryFullView(entry: entry)
                        } label: {
                            VStack {
                                JournalView(entry: entry)
                                Divider()
                            }
                        }
                    }
                }
                .refreshable {
                    Task {
                        do {
                            try await ckViewModel.fetchDiaryEntries()
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .task {
                await HealthManager.shared.requestHealthAuthorization()
            }
            .fullScreenCover(isPresented: $toggleSheet){
                JournalEntryView(entryList: $entryList)
            }
            
            ToolbarHomeScreenView(toggleSheet: $toggleSheet, teste: $teste)
        }
    }
}

