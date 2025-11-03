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
    @State var searchText: String = ""
        
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    @Environment(\.refresh) private var refresh
        
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Boas Vindas, \(ckViewModel.preference?.name ?? "")!")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                MascotView()
                Button {
                    toggleSheet.toggle()
                } label: {
                    Text("Novo Registro")
                        .frame(width: 321, height: 36)
                        .font(.body)
                        .fontWeight(.medium)
                    
                }
                .buttonStyle(.glassProminent)
                .tint(.accent)
                .padding()
                ForEach(Array(ckViewModel.entries.enumerated()), id: \.offset) { index, entry in
                    NavigationLink {
                        JournalEntryFullView(entry: entry)
                            .onDisappear {
                                Task {
                                    do {
                                        try await ckViewModel.fetchDiaryEntries()
                                    }
                                    catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                    } label: {
                        VStack {
                            JournalView(entry: entry)
                                .task {
                                    do {
                                        try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                                    }
                                    catch {
                                        print(error.localizedDescription)
                                    }
                                }
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
            .background { Color.background.ignoresSafeArea()}
            .task {
                await HealthManager.shared.requestHealthAuthorization()
            }
            .fullScreenCover(isPresented: $toggleSheet){
                JournalCreateEntryView(entryList: $entryList)
                    .onDisappear {
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
//            .task(id: ckViewModel.entries) {
//                do {
//                    try await ckViewModel.fetchDiaryEntries()
//                    print("oi")
//                }
//                catch {
//                    print(error.localizedDescription)
//                }
//            }
        }
    }
}

