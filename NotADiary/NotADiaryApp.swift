//
//  NotADiaryApp.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI

@main
struct NotADiaryApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView()
            //check where to use it
                .onOpenURL { URL in
                    struct ResponseData: Decodable {
                        var card: Card
                    }
                    
                    func loadJson() -> Card? {
                        do {
                            let data = try Data(contentsOf: URL)
                            let jsonData = try JSONDecoder().decode(ResponseData.self, from: data)
                            return jsonData.card
                        } catch {
                            print("error:\(error.localizedDescription)")
                        }
                        return nil
                    }
                    
                }
        }
    }
}
