//
//  CloudKitViewModel.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import Foundation
import CloudKit
import SwiftUI
import Observation

@Observable
@MainActor
class CloudKitViewModel {
    private var userID: String = ""
    var name: String? = ""
    
    var isLogged: Bool = false
    
    var container = CKContainer.default()
    
    var preference: Preference? = nil
    
    var entriesDictionary: [CKRecord.ID : JournalEntry] = [:]
    var entries: [JournalEntry] = []
    
    var lastThirtyEntries: [JournalEntry] = []
    
    var imagesDictionary: [CKRecord.ID : [ImageModel]] = [:]

    
    func loginButtonPressed() {
        guard name != nil, !name!.isEmpty else { return }
        
        createPreference(name: name!)
    }
    
    init() {
        Task {
            do {
                try await fetchDiaryEntries()
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        getPreferenceRecordID { recordID, error in
            if let returnedPreferenceID = recordID?.recordName {
                self.isLogged(idUser: returnedPreferenceID)
            }
        }
    }
    
    func createPreference(name: String) {
        let newPreference = CKRecord(recordType: "preferences")
        
        getPreferenceRecordID { recordID, error in
            if let userID = recordID?.recordName {
                newPreference["name"] = name
                newPreference["ID"] = userID
                
                self.sendPreferenceToDB(record: newPreference)
            }
            else {
                print("Fetched iCloudID returned nil")
            }
        }
    }
    
    func removePreference(preference: Preference) async throws {
        let record = preference.record
        do {
            try await container.publicCloudDatabase.deleteRecord(withID: record.recordID)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func createDiaryEntry(entry: JournalEntry) throws -> JournalEntry {
        let newEntry = CKRecord(recordType: "entries")
                
        newEntry["ID"] = newEntry.recordID.recordName
        newEntry["title"] = entry.title
        newEntry["text"] = entry.text
        newEntry["date"] = entry.date
        newEntry["mood"] = entry.mood
        newEntry["songID"] = entry.songID
        newEntry["label"] = entry.label
        newEntry["association"] = entry.association
        newEntry["valence"] = entry.valence
        
        let entrySet = JournalEntry(id: newEntry.recordID, title: entry.title, text: entry.text, date: entry.date, mood: entry.mood, songID: entry.songID, label: entry.label, association: entry.association, valence: entry.valence)
        
        entriesDictionary[newEntry.recordID] = entrySet
        sendEntryToDB(record: newEntry)
        
        return entrySet
    }
    
    func editDiaryEntry(entry: JournalEntry) async throws {
        do {
            let record = try await container.privateCloudDatabase.record(for: entry.id!)

            record["title"] = entry.title
            record["text"] = entry.text
            record["date"] = entry.date
            record["mood"] = entry.mood
            record["songID"] = entry.songID
            record["label"] = entry.label
            record["association"] = entry.association
            record["valence"] = entry.valence
            
            sendEntryToDB(record: record)
        }
    }
    
    func fetchDiaryEntries() async throws {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "entries", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let result = try await container.privateCloudDatabase.records(matching: query)
        entries = []
        
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        records.forEach { record in
            guard let title = record["title"] as? String else { return }
            guard let text = record["text"] as? String else { return }
            guard let date = record["date"] as? Date else { return }
            guard let mood = record["mood"] as? Int else { return }
            guard let songID = record["songID"] as? String else { return }
            guard let label = record["label"] as? String else { return }
            guard let association = record["association"] as? String else { return }
            guard let valence = record["valence"] as? Double else { return }
            
            let entry = JournalEntry(id: record.recordID, title: title, text: text, date: date, mood: mood, songID: songID, label: label, association: association, valence: valence)
            
            if entriesDictionary[record.recordID] == nil {
                entriesDictionary[record.recordID] = entry
            }
            entries.append(entry)
        }
    }
    
    func fetchLastThirtyEntries() async throws {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "entries", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let result = try await container.privateCloudDatabase.records(matching: query)
        lastThirtyEntries = []
        
        let records = result.matchResults.compactMap { try? $0.1.get() }
                
        let results = records.prefix(30)
        
        results.forEach { record in
            guard let title = record["title"] as? String else { return }
            guard let text = record["text"] as? String else { return }
            guard let date = record["date"] as? Date else { return }
            guard let mood = record["mood"] as? Int else { return }
            guard let songID = record["songID"] as? String else { return }
            guard let label = record["label"] as? String else { return }
            guard let association = record["association"] as? String else { return }
            guard let valence = record["valence"] as? Double else { return }
            
            let entry = JournalEntry(id: record.recordID, title: title, text: text, date: date, mood: mood, songID: songID, label: label, association: association, valence: valence)
            
            lastThirtyEntries.append(entry)
        }
    }

    
    func removeDiaryEntry(entry: JournalEntry) async throws {
        do {
            if let recordID = entry.id {
                try await container.privateCloudDatabase.deleteRecord(withID: recordID)
            }
        }
        catch {
            if let recordID = entry.id {
                entriesDictionary.removeValue(forKey: recordID)
            }
        }
    }
    
    func createImageEntry(entry: JournalEntry, images: [UIImage]) {
        let reference = CKRecord.Reference(recordID: entry.id!, action: .deleteSelf)
        
        for image in images {
            let newImage = CKRecord(recordType: "images")
            let imageAsset = try? CKAsset(image: image)
            
            newImage["ID"] = newImage.recordID.recordName
            newImage["entry"] = reference
            newImage["image"] = imageAsset
            
            sendEntryToDB(record: newImage)
        }
    }
    
    func editImageEntry(image: ImageModel) async {
        do {
            let record = try await container.privateCloudDatabase.record(for: image.id!)
            let reference = CKRecord.Reference(recordID: image.entry, action: .deleteSelf)
            let imageAsset = try? CKAsset(image: image.image)
            
            record["entry"] = reference
            record["image"] = imageAsset
            
            sendEntryToDB(record: record)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImageByDiaryEntry(entry: JournalEntry) async throws {
        let reference = CKRecord.Reference(recordID: entry.id!, action: .deleteSelf)
        let predicate = NSPredicate(format: "entry == %@", reference)
        let query = CKQuery(recordType: "images", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let result = try await container.privateCloudDatabase.records(matching: query)
        
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        if let entryID = entry.id {
            imagesDictionary[entryID] = nil
        }
        
        records.forEach { record in
            guard let entry = record["entry"] as? CKRecord.Reference else { return }
            guard let asset = record["image"] as? CKAsset else { return }
            
            if let data = try? Data(contentsOf: (asset.fileURL!)), let image = UIImage(data: data) {
                let imageModel = ImageModel(id: record.recordID, entry: entry.recordID, image: image)
                
                if imagesDictionary[entry.recordID] != nil {
                    imagesDictionary[entry.recordID]!.append(imageModel)
                }
                else {
                    imagesDictionary[entry.recordID] = [imageModel]
                }
            }
        }
    }
    
    
    func removeImageEntry(image: ImageModel) async {
        do {
            if let recordID = image.id {
                try await container.privateCloudDatabase.deleteRecord(withID: recordID)
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getPreferenceRecordID(complete: @escaping (_ instance: CKRecord.ID?, _ error: NSError?) -> ()) {
        let container = CKContainer.default()
        container.fetchUserRecordID() {
            recordID, error in
            if error != nil {
                print(error!.localizedDescription)
                complete(nil, error as NSError?)
            } else {
                complete(recordID, nil)
            }
        }
    }
    
    func isLogged(idUser: String) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "preferences", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedMatchingPreference: [Preference] = []
        
        queryOperation.recordMatchedBlock = { [weak self] returnedRecordID, returnedResult in
            switch returnedResult {
            case .success(let record):
                guard let id = record["ID"] as? String else { return }
                guard let name = record["name"] as? String else { return }
                
                if id == idUser {
                    returnedMatchingPreference.append(Preference(name: name, userID: idUser, record: record))
                    DispatchQueue.main.async {
                        self?.preference = Preference(name: name, userID: idUser, record: record)
                    }
                }
            case .failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned result: \(returnedResult)")
            DispatchQueue.main.async {
                if !returnedMatchingPreference.isEmpty {
                    self?.isLogged = true
                    print("There's a user with that ID")
                }
            }
        }
        
        addOperationToPrivateDB(operation: queryOperation)
    }
    
    func fetchAndDeletePreference() {
        getPreferenceRecordID { recordID, error in
            if let returnedPreferenceID = recordID?.recordName {
                self.isLogged(idUser: returnedPreferenceID)
                
                Task {
                    if let _preference = self.preference {
                        try await self.removePreference(preference: _preference)
                        
                        for entry in self.entries {
                            try await self.removeDiaryEntry(entry: entry)
                        }
                        self.isLogged = false
                    }
                }
            }
        }
    }
    
    func sendPreferenceToDB(record: CKRecord) {
        container.privateCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print(returnedError ?? "")
            print(returnedRecord ?? "")

            DispatchQueue.main.async {
                self?.name = ""
            }
        }
    }
    
    func sendEntryToDB(record: CKRecord) {
        container.privateCloudDatabase.save(record) { returnedRecord, returnedError in
            print(returnedError ?? "")
            print(returnedRecord ?? "")
        }
    }
    
    func addOperationToPrivateDB(operation: CKDatabaseOperation) {
        container.privateCloudDatabase.add(operation)
    }
}
