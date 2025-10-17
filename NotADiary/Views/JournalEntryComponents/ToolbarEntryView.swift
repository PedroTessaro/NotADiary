//
//  ToolbarEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//

import SwiftUI
import HealthKit

struct ToolbarEntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel

    @Binding var entryList: [JournalEntry]
    @Binding var image1: UIImage?
    
    //let imagePlaceholder: UIImage = UIImage(named: "amiguinho")!
    
    var text: String
    var day: Date
    var mood: Int
    var title: String
    var userValence: Double
    var whereToSave: Bool
    var userLabel: HKStateOfMind.Label
    var userAssociation: HKStateOfMind.Association
    
    //I NEEDS TO HAVE DEFAULT VALUES!!!!!!!!!!
    @State private var relato: HKStateOfMind?
    
    var body: some View {
        NavigationStack {
            Text("")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("1")
                        } label: {
                            Image(systemName: "waveform.path.badge.plus")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("2")
                        } label: {
                            Image(systemName: "music.note")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        PhotoPickerView(image: $image1, isEdit: false)
                        Image(systemName: "photo.badge.plus.fill")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            print("4")
                        } label: {
                            Image(systemName: "waveform")
                        }
                    }
                    ToolbarSpacer(.fixed, placement: .bottomBar)
                    
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            entryList.append(JournalEntry(title: title, text: text, image1: image1 ?? nil, date: day,userValence: userValence))
                            relato = HealthManager.shared.createSample(eventAssociation: userAssociation, userLabel: userLabel, userValence: userValence, endDate: day)
                            Task{
                                if whereToSave{
                                    await HealthManager.shared.save(sample: relato!)
                                }
                            }
                            dismiss()
                        } label: {
                            Image(systemName: "checkmark")
                        }
                    }
                    ToolbarSpacer(.fixed, placement: .bottomBar)
                    ToolbarItem (placement: .bottomBar) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
        }
    }
}

//#Preview {
//    ToolbarEntryView()
//}
