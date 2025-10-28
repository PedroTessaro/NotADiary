//
//  JournalEntryFullToolbarView.swift
//  NotADiary
//
//  Created by Francisco Losada on 20/10/25.
//

import SwiftUI

struct ToolbarJournalEntryFullView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @Binding var isEdit: Bool
    @State var card: Card
    
    var entry: JournalEntry
    
    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem (placement: .confirmationAction) {
                    Button {
                        isEdit.toggle()
                    } label: {
                        Text("Edit")
                    }
                    //.buttonStyle(.bordered)
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("waveform")
                    } label: {
                        Image(systemName: "waveform")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("headphones")
                    } label: {
                        Image(systemName: "headphones")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        card = FuncsCardModel.shared.entryToCard(entry: entry)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .shareSheet(items: [card], excludedActivityTypes: [UIActivity.ActivityType.addToHomeScreen,UIActivity.ActivityType.addToReadingList,UIActivity.ActivityType.assignToContact,UIActivity.ActivityType.collaborationCopyLink,UIActivity.ActivityType.collaborationInviteWithLink,UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.mail,UIActivity.ActivityType.markupAsPDF,UIActivity.ActivityType.message,UIActivity.ActivityType.openInIBooks,UIActivity.ActivityType.postToFacebook,UIActivity.ActivityType.postToFlickr,UIActivity.ActivityType.postToTencentWeibo,UIActivity.ActivityType.print,UIActivity.ActivityType.saveToCameraRoll,UIActivity.ActivityType.sharePlay])
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem (placement: .bottomBar) {
                    Button {
                        Task {
                            do {
                                try await ckViewModel.removeDiaryEntry(entry: entry)
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                        }
                        dismiss()
                    } label: {
                        Image(systemName: "trash.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
    }
}


