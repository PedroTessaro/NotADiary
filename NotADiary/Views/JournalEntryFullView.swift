//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI

struct JournalEntryFullView: View {
    @State var entry: JournalEntry
    @State var isEdit: Bool = false
    var body: some View {
        NavigationStack {
            if isEdit {
                JournalEntryEdit(entry: $entry, isEdit: $isEdit)
            }
            else {
                ScrollView {
                    VStack {
                        Text(entry.title)
                        Divider()
                        Text("\(entry.date, format: .dateTime.day().month().year())")
                        Divider()
                        Text(entry.text)
                        Divider()
                        Text("\(entry.valence)")
                        Divider()
                        HStack {
                            if entry.image != nil {
                                Image(uiImage: entry.image!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 240.0, height: 236)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem (placement: .confirmationAction) {
                        Button {
                            isEdit.toggle()
                        } label: {
                            Text("Edit")
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
        }
    }
}

//#Preview {
//    JournalEntryFullView()
//}
