//
//  SongStorage.swift
//  NotADiary
//
//  Created by Enzo Ferroni on 22/10/25.
//

import Foundation

class SongStorage {
    static let shared = SongStorage()
    
    private let userDefaults = UserDefaults.standard
    private let savedSongIdKey = "savedSongId"
    
    private init() {}
    
    func saveSongId(_ id: String) {
        userDefaults.set(id, forKey: savedSongIdKey)
    }
    
    func getSavedSongId() -> String? {
        return userDefaults.string(forKey: savedSongIdKey)
    }
}
