//
//  FuncCardModel.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 27/10/25.
//
import Foundation
import UIKit
import SwiftUI
import CloudKit

class FuncsCardModel{
    public static let shared = FuncsCardModel()
    
    func loadJson(url: URL) -> Card? {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Card.self, from: data)
            return jsonData
        } catch {
            print("error:\(error.localizedDescription)")
        }
        return nil
    }
    
    func entryToCard(entry: JournalEntry, imagesDictionary: [CKRecord.ID : [ImageModel]]) -> Card {
        var card = Card(images: [], title: entry.title, text: entry.text, date: entry.date, mood: entry.mood, songID: entry.songID, label: entry.label, association: entry.association, valence: entry.valence)
        
        if(imagesDictionary[entry.id!]?.first?.image != nil){
            for image in imagesDictionary[entry.id!]!.enumerated(){
                card.images.append(image.element.image.base64!)
            }
        }
        return card
    }
    
}

