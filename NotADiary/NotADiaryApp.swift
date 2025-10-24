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
                .onOpenURL { URL in
                    print(URL)
                }
        }
    }
}
