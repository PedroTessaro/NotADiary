//
//  Card.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 23/10/25.
//


//
//  structcardalizadaModel.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 22/10/25.
//

import SwiftUI
import UniformTypeIdentifiers


//TODO: Change what is shared by the card.

nonisolated
struct Card: Decodable, Encodable {
    //review
    var images: [String]
    var title: String
    var text: String
    var date: Date
    var mood: Int
    var songID: String
    var label: String
    var association: String
    var valence: Double
}

extension UTType {
    static var card: UTType = .init(exportedAs: "com.NotADiary.card")
}

// @preconcurrency can be a problem..

extension Card: @preconcurrency Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .card)
        DataRepresentation(importedContentType: .card) { data in
            let card = try JSONDecoder().decode(Card.self, from: data)
            return card
        }
        DataRepresentation(exportedContentType: .card) { card in
            let data = try JSONEncoder().encode(card)
            return data
        }
        FileRepresentation(contentType: .card) { card in
            let docsURL = URL.temporaryDirectory.appendingPathComponent("\(card.title)\(UUID().uuidString)", conformingTo: await .card)
            let data = try JSONEncoder().encode(card)
            try data.write(to: docsURL)
            return SentTransferredFile(docsURL)
        } importing: { received in
            let data = try Data(contentsOf: received.file)
            let card = try JSONDecoder().decode(Card.self, from: data)
            return card
        }
    }
}
