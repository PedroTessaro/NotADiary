//
//  FuncCardModel.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 27/10/25.
//
import Foundation
import UIKit
import SwiftUI

class FuncsCardModel{
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
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
    
    func entryToCard(entry: JournalEntry) -> Card{
        var card: Card
        card.title = entry.title
        card.date = entry.date
        card.text = entry.text
        card.association = entry.association
        card.label = entry.label
        card.mood = entry.mood
        card.songID = entry.songID
        card.valence = entry.valence
        if(ckViewModel.imagesDictionary[entry.id!]?.first?.image != nil){
            for image in ckViewModel.imagesDictionary[entry.id!]!.enumerated(){
                card.images.append(image.element.image.base64!)
            }
        }
    }
    
}

