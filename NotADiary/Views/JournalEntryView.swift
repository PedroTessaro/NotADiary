//
//  JournalEntryView.swift
//  NotADiary
//
//  Created by Francisco Losada on 08/10/25.
//
//TODO: BOTOES
//TODO: RAW VALUE NO FOREACH

import SwiftUI
import PhotosUI
import HealthKit

struct JournalEntryView: View {
    @State var text: String = ""
    @State var image1: UIImage?
    @State var day: Date = Date()
    @State var userValence: Double = -0.96
    @State var title: String = ""
    @Binding var entryList: [JournalEntry]
    @State var whereToSave: Bool = false
    @State var userLabel: HKStateOfMind.Label = HKStateOfMind.Label.angry
    @State var userAssociation: HKStateOfMind.Association = HKStateOfMind.Association.community
    @State var userLabelString: String = ""
    @State var userAssociationString: String = ""
    
    //    let associations = [Associations(hktypeAssociations: HKStateOfMind.Association.community, nome: "Community"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.currentEvents, nome: "Current Events"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.dating, nome: "Dating"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.education, nome: "Education"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.family, nome: "Family"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.fitness, nome: "Fitness"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.friends, nome: "Friends"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.health, nome: "Health"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.hobbies, nome: "Hobbies"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.identity, nome: "Identity"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.money, nome: "Money"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.partner, nome: "Partner"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.selfCare, nome: "Self Care"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.spirituality, nome: "Spirituality"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.tasks, nome: "Tasks"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.travel, nome: "Travel"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.weather, nome: "Weather"),
    //                        Associations(hktypeAssociations: HKStateOfMind.Association.work, nome: "Work"),
    //    ]
    
    let associationsStrings = ["Community","Current Events","Dating","Education","Family","Fitness","Friends","Health","Hobbies","Identity","Money","Partner","Self Care","Spirituality","Tasks","Travel","Weather","Work"]
    
    //    let labels = [Labels(hktypeLabels: HKStateOfMind.Label.amazed, nome: "Amazed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.amused, nome: "Amused"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.angry, nome: "Angry"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.annoyed, nome: "Annoyed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.anxious, nome: "Anxious"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.ashamed, nome: "Ashamed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.brave, nome: "Brave"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.calm, nome: "Calm"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.confident, nome: "Confident"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.content, nome: "Content"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.disappointed, nome: "Disappointed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.discouraged, nome: "Discouraged"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.disgusted, nome: "Disgusted"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.drained, nome: "Drained"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.embarrassed, nome: "Embarrassed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.excited, nome: "Excited"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.frustrated, nome: "Frustrated"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.grateful, nome: "Grateful"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.guilty, nome: "Grateful"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.happy, nome: "Guilty"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.hopeful, nome: "Hopeful"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.hopeless, nome: "Hopeless"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.indifferent, nome: "Indifferent"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.irritated, nome: "Irritated"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.jealous, nome: "Jealous"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.joyful, nome: "Joyful"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.lonely, nome: "Lonely"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.overwhelmed, nome: "Overwhelmed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.passionate, nome: "Passionate"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.peaceful, nome: "Peaceful"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.proud, nome: "Proud"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.relieved, nome: "Relieved"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.sad, nome: "Sad"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.satisfied, nome: "Satisfied"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.scared, nome: "Scared"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.stressed, nome: "Stressed"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.surprised, nome: "Surprised"),
    //                  Labels(hktypeLabels: HKStateOfMind.Label.worried, nome: "Worried"),
    //    ]
    
    let labelsStrings = ["Amazed","Amused","Angry","Annoyed","Anxious","Ashamed","Brave","Calm","Confident","Content","Disappointed","Discouraged","Disgusted","Drained","Embarrassed","Excited","Frustrated","Grateful","Guilty","Hopeful","Hopeless","Indifferent","Irritated","Jealous","Joyful","Lonely","Overwhelmed","Passionate","Peaceful","Proud","Relieved","Sad","Satisfied","Scared","Stressed","Surprised","Worried"]
    
    
    @State var wasClicked: Bool = false
    
    @Environment(CloudKitViewModel.self) var ckViewModel: CloudKitViewModel
    
    var moodFace: String {
        switch userValence {
        case -1 ... -0.74:
            return "😢"
            
        case -0.75 ... -0.51:
            return "☹️"
            
        case -0.50 ... -0.26:
            return "🙁"
            
        case -0.25 ... 0.24:
            return "😑"
            
        case 0.25 ... 0.49:
            return "🙂"
            
        case 0.5 ... 0.74:
            return "😊"
            
        case 0.75 ... 1.0:
            return "😃"
        default:
            return "😑"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Title:")
                            .font(.title)
                            .padding(.horizontal)
                            .lineLimit(1)
                        Spacer()
                    }
                    TextField("Write here...", text: $title, axis: .vertical)
                        .padding(.horizontal)
                    HStack {
                        Text("Text:")
                            .font(.title)
                            .padding(.horizontal)
                        Spacer()
                    }
                    TextField("Write here...", text: $text, axis: .vertical)
                        .padding(.horizontal)
                    
                    Text("Como você está se sentindo?")
                        .bold()
                        .font(.title2)
                    HStack {
                        Button {
                            whereToSave.toggle()
                        } label: {
                            if !whereToSave {
                                Label("Salvar pelo app!",systemImage: "theatermasks.fill")
                            }
                            else {
                                Image(systemName:"theatermasks")
                            }
                        }
                        .buttonStyle(.bordered)
                        .background(whereToSave ? .white : .cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                        Spacer()
                        Button{
                            whereToSave.toggle()
                        } label: {
                            if whereToSave {
                                Label("Salvar pelo healthKit",systemImage: "heart.fill")
                            }
                            else {
                                Image(systemName:"heart")
                            }
                        }
                        .buttonStyle(.bordered)
                        .background(whereToSave ? .cyan : .white)
                        .clipShape(RoundedRectangle(cornerRadius: 90))
                    }
                    .font(.title3)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    //valencia por meio de slider
                    Text(moodFace)
                        .font(.largeTitle)
                    Slider(value: $userValence, in: -1...1){}
                        .padding(.horizontal)
                    //label - a emocao propriamente dita
                    HStack{
                        Text("Como você está se sentindo?")
                        Spacer()
                        //Resolver
                        Picker("", selection: $userLabelString){
                            ForEach(labelsStrings, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    HStack{
                        Text("Ao que o sentimento está associado? ")
                        Spacer()
                        //Resolver
                        Picker("", selection: $userAssociationString){
                            ForEach(associationsStrings, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    .padding(.horizontal)
                    //endDate picker
                    DatePicker("", selection: $day, displayedComponents: .init(arrayLiteral: .date))
                        .padding(.horizontal)
                    
                    if image1 != nil{
                        Image(uiImage: image1!)
                            .resizable()
                            .frame(width: 240.0, height: 236)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .scaledToFill()
                    }
                }
                .onChange(of: userLabelString) { oldValue, newValue in
                    userLabel = HKStateOfMindParseFunctions.shared.labelStringToHKStateOfMind(string: userLabelString)
                }
                .onChange(of: userAssociationString) { oldValue, newValue in
                    userAssociation = HKStateOfMindParseFunctions.shared.associationStringToHKStateOfMind(string: userAssociationString)
                }
                
                
                ToolbarEntryView(entryList: $entryList, image1: $image1, text: text, day: day, title: title, userValence: userValence,whereToSave: whereToSave, userLabel: userLabel, userAssociation: userAssociation)
            }
        }
    }
}

//#Preview {
//    JournalEntryView()
//}

//TODO: Fazer dados mocados para preview
