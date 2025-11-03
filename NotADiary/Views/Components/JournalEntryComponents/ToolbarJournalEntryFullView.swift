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
    
    @State var alert: Bool = false
    
    var entry: JournalEntry
    
    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Menu {
                        Button {
                            isEdit.toggle()
                        } label: {
                            Label("Editar", systemImage: "slider.horizontal.3")
                        }
                        
//                        Button {
//                            print("share")
//                        } label: {
//                            Label("Compartilhar", systemImage: "square.and.arrow.up")
//                        }
                        
                        Button(role: .destructive) {
                            alert.toggle()
                        } label: {
                            Label("Deletar", systemImage: "trash")
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .alert("Deletar Relato", isPresented: $alert, actions: {
                            Button(role: .destructive){
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
                                Text("Deletar")
                            }
                        
                            Button(role: .cancel) {
                                
                            } label: {
                                Text("Cancelar")
                            }
                        
                    }, message: {
                        Text("Você está prestes a deletar este relato, não haverá maneira de recuperá-lo.")
                    })
                }
            }
    }
}


