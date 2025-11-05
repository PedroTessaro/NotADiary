//
//  JournalEntryFullView.swift
//  NotADiary
//
//  Created by Francisco Losada on 09/10/25.
//

import SwiftUI
import MusicKit

struct JournalEntryFullView: View {
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    @State var entry: JournalEntry
    @State var isEdit: Bool = false
    @State var fullImage: Bool = false
    @State var moodImage: String?
    @State var moodValue: MascotMood?
    @State var buttonState: Int = 0
    @State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    
    var mViewModel = MascotViewModel()
    
    var body: some View {
        NavigationStack {
            if isEdit {
                JournalEntryEdit(isEdit: $isEdit, entry: entry)
            }
            else {
                ScrollView {
                    VStack {
                        HStack {
                            Text(entry.title)
                                .foregroundStyle(.black)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Text("\(entry.date, format: .dateTime.day().month().year())")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.subheadline)
                            Spacer()
                        }
                        Image(moodImage ?? "")
                            .resizable()
                            .frame(width: 193, height: 193)
                        HStack {
                            Text(entry.text)
                                .foregroundStyle(.black)
                            Spacer()
                        }
                        
                        HStack {
                            Button{
                                buttonState = 0
                                print(buttonState)
                            } label: {
                                if buttonState == 0 {
                                    Label("Música",systemImage: "music.note")
                                    
                                }else{
                                    Image(systemName: "music.note")
                                }
                            }
                            .buttonStyle(.bordered)
                            
                            
                            
                            Button {
                                buttonState = 1
                                print(buttonState)
                            } label: {
                                if buttonState == 1 {
                                    Label("Música",systemImage: "music.note")
                                }else{
                                    Image(systemName: "music.note")
                                }
                            }
                            .buttonStyle(.bordered)
                            
                            
                            Button {
                                buttonState = 2
                                print(buttonState)
                            } label: {
                                if buttonState == 2 {
                                    Label("Música",systemImage: "music.note")
                                }else{
                                    Image(systemName: "music.note")
                                }
                            }
                            .buttonStyle(.bordered)
                            
                            
                        }
                        
                        ImagesGridView(entry: entry)
                        
                    }
                    .padding(.horizontal)
                    
                    ToolbarJournalEntryFullView(isEdit: $isEdit, entry: entry)
                }
                .onAppear() {
                    Task {
                        do {
                            try await ckViewModel.fetchImageByDiaryEntry(entry: entry)
                            song = await mpViewModel.fetchSongById(entry.songID)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                    moodValue = mViewModel.moodToMascot(value: entry.mood)
                    moodImage = mViewModel.mascotMoodImage(mood: moodValue!)
                }
            }
        }
        .background { Color.background.ignoresSafeArea()}
    }
}
