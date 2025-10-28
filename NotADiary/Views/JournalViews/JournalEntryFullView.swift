//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI

struct JournalEntryFullView: View  {
    @State var entry: JournalEntry
    @State var isEdit: Bool = false
    
    var imageList: [String] = ["teste2", "teste2", "teste", "amiguinho", "amiguinho", "amiguinho", "teste"]
    
    var body: some View {
        NavigationStack {
            if isEdit {
                JournalEntryEdit(entry: $entry, isEdit: $isEdit)
            }
            else {
                ScrollView {
                    VStack {
                        HStack {
                            Text(entry.title)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text("\(entry.date, format: .dateTime.day().month().year())")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        Divider()
                        HStack {
                            Text(entry.text)
                            Spacer()
                        }
                        //Placeholder for Music Card -
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 365, height: 71)
                            .foregroundStyle(.gray)
                        HStack {
                            VStack {
                                ForEach(Array(imageList.enumerated()), id: \.offset) { index, image in
                                    if index % 5 == 0 || index % 5 == 3 {
                                        Image(image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 200, height: 246)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .clipped()
                                    }
                                }
                                Spacer()
                            }
                            
                            VStack {
                                ForEach(Array(imageList.enumerated()), id: \.offset) { index, image in
                                    if index % 5 == 1 || index % 5 == 2 || index % 5 == 4 {
                                        Image(image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 153, height: 160)
                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                            .clipped()
                                    }
                                }
                                Spacer()
                            }
                        }
//NAO APAGAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                        if entry.image != nil {
//                            Image(uiImage: entry.image!)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 240.0, height: 236)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                        }
                    }
                    .padding(.horizontal)
                    ToolbarJournalEntryFullView(isEdit: $isEdit, entry: $entry)
                }
            }
        }
    }
}

//#Preview {
//    JournalEntryFullView()
//}
