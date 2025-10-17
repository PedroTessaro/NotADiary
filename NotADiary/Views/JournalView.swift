//
//  JournalView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI

struct JournalView: View {
    var entry: JournalEntry
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    var body: some View {
        VStack {
            HStack {
                Text(entry.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Spacer()
            }
            HStack {
                Text("\(entry.date, format: .dateTime.day().month().year())")
                    .font(.title3)
                Spacer()
            }
            HStack {
                Text(entry.text)
                    .lineLimit(7)
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
            if entry.image != nil {
                Image(uiImage: entry.image!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240.0, height: 236)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    JournalView(entry: JournalEntry(title: "Titulo", text: "asdjssdajfiosajdfiojsdafiojsdif", date: Date(), mood: "😃"))
//}
