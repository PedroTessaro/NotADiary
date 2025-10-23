//
//  structcardalizadaModel.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 22/10/25.
//

import SwiftUI
import UniformTypeIdentifiers

nonisolated
struct Card: Identifiable, Codable {
    let name: String
    let id: String
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
            let docsURL = URL.temporaryDirectory.appendingPathComponent("\(card.name)\(UUID().uuidString)", conformingTo: await .card)
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
