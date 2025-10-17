//
//  JournalEntryEdit.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI

struct JournalEntryEdit: View {
    @Binding var entry: JournalEntry
    @Binding var isEdit: Bool
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Title:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    TextField("Write here...", text: $entry.title, axis: .vertical)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Text:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    TextField("Write here...", text: $entry.text, axis: .vertical)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Photo:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    PhotoPickerView(image: $entry.image, isEdit: true)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        isEdit.toggle()
                        Task {
                            do {
                                try await ckViewModel.editDiaryEntry(entry: entry)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}
