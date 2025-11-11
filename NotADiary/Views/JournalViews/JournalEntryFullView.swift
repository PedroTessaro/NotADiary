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
    @State var card: Card = Card(images: [], title: "", text: "", date: Date.now, mood: 0, songID: "", label: "", association: "", valence: 0)
    @State var moodImage: String?
    @State var moodValue: MascotMood?
    
    @State var mpViewModel = MusicPlayerViewModel()
    @State var song: Song?
    
    var mViewModel = MascotViewModel()
    
    var body: some View {
        NavigationStack {
            if isEdit {
                JournalEntryEdit(isEdit: $isEdit, entry: entry)
            }
            else {
                ZStack {
                    ScrollView {
                        VStack {
                            HStack {
                                Text(entry.title)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)

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
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 365, height: 71)
                                    .foregroundStyle(.white)
                                if song != nil {
                                    SongRow(isEdit: true, song: song!, hapticsManager: mpViewModel.hapticsManager, viewModel: $mpViewModel) {
                                        Task {
                                            await mpViewModel.togglePlayPause()
                                        }
                                    }
                                    .background(.white.opacity(0.7))
                                    .frame(width: 365, height: 71)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                            
                            ImagesGridView(entry: entry)
                            
                        }
                        .padding(.horizontal)
                        
                        ToolbarJournalEntryFullView(isEdit: $isEdit, card: card, entry: entry)
                    }
                    MusicCardFullView(entry: entry)
                }
                
                .onAppear() {
                    card = FuncsCardModel.shared.entryToCard(entry: entry, imagesDictionary: ckViewModel.imagesDictionary)
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
