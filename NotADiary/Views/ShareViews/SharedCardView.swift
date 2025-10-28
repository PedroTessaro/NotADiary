//
//  SharedCardView.swift
//  NotADiary
//
//  Created by Vinicius Alves Marques on 27/10/25.
//

import SwiftUI

struct SharedCardView: View  {
    @State var imageList: [UIImage] = []
    @State var entry: Card?
    var sharedURL: URL
    
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(entry?.title ?? "Dados não disponíveis")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    HStack {
                        Text("\(entry?.date ?? Date(), format: .dateTime.day().month().year())")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text(entry?.text ?? "Dados não disponíveis")
                        Spacer()
                    }
                    //Placeholder for Music Card -
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 365, height: 71)
                        .foregroundStyle(.gray)
                    HStack {
                        VStack {
                            ForEach(Array(imageList.enumerated()), id: \.offset) { index, image in
                                if index % 5 == 0 || index % 5 == 3 {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height: 246)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .clipped()
                                }
                            }
                            Spacer()
                        }
                        
                        VStack {
                            ForEach(Array(imageList.enumerated()), id: \.offset) { index, image in
                                if index % 5 == 1 || index % 5 == 2 || index % 5 == 4 {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 153, height: 160)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .clipped()
                                }
                            }
                            Spacer()
                        }
                    }
                    //NAO APAGAR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    //                        if entry.image != nil {
                    //                            Image(uiImage: entry.image!)
                    //                                .resizable()
                    //                                .scaledToFit()
                    //                                .frame(width: 240.0, height: 236)
                    //                                .clipShape(RoundedRectangle(cornerRadius: 15))
                    //                        }
                }
            }
        }
        .onAppear(){
            entry = FuncsCardModel.shared.loadJson(url: sharedURL)
            if(entry?.images != nil){
                for imagex64 in entry!.images{
                    guard let rebornImg = imagex64.imageFromBase64 else {
                        return
                    }
                    imageList.append(rebornImg)
                }
                
            }
        }
    }
}


