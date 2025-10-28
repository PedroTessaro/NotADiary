//
//  FuncCardModel.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 27/10/25.
//
import Foundation

class FuncCardModel{
    
    public static let shared = FuncCardModel()
    
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
    
}

