//
//  CatDetails.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import SwiftUI
import URLImage
let BASE_IMAGE_URL = "https://cpcp-cats.herokuapp.com/api/files/?format=json"
//https://cpcp-cats.herokuapp.com/api/files/?cat_id=0
struct CatDetails : View {
    var cat: Cat
    var photos: PhotoElement
    var personalityData = [0:"Indoors only", 1:"Indoors and outdoor", 2:"Lap cat", 3:"Mellow", 4:"Active", 5:"Independent", 6:"Shy",7:"Playful",8:"Friendly",9:"Curious",10:"Feisty",11:"Affectionate",12:"Loves attention",13:"Aloof",14:"Swats when over stimulated",15:"Needs quiet home", 16:"Likes to be held/picked up", 17:"Doesn't like to be held/picked up", 18:"Comfortable with other cats", 19:"Not comfortable with other cats", 20:"Comfortable with dogs", 21:"Not comfortable with dogs", 22:"Good with younger kids",23:"Good with older kids", 24: "Needs a home with adults only", 25: "Needs time to know and trust you"]
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Spacer()
                VStack(alignment: .center) {
                    Group {
                        Spacer()
                        HStack(alignment: .top) {
                            Group {
                                VStack {
//                                Text(cat.name).font(.custom("Euphemia UCAS", size: 20.0))
                                    URLImage(URL(string:  "\(photos.photourl)")!, delay: 0.25) {proxy in proxy.image.resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150) }
//                                    .resizable().frame(width: UIScreen.main.bounds.height/8, height: UIScreen.main.bounds.height/8) }
                                
                                }
                            }
                        }.padding(8)
                        HStack(alignment: .top) {
                            Text("Age:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(String(cat.age))
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Birthday:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(String(cat.birthday))
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Gender:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text("\(cat.gender.rawValue)").font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Description:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(cat.catDescription).font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }
                        .padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Breed:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(cat.breed).font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }
                        .padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Type:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                             Text("\(cat.itype.rawValue)").font(.custom("Euphemia UCAS", size: 14.0))
                               
                            Spacer()
                        }
                        .padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("status:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                             Text("\(cat.status.rawValue)").font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }
                        .padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Arrival Date:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(String(cat.arrivalDate))
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                    }
                }
                VStack(alignment: .center) {
                    HStack(alignment: .top) {
                        Text("Arrival Details:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                        Text(cat.arrivalDetails)
                           .font(.custom("Euphemia UCAS", size: 14.0))
                        Spacer()
                    }.padding(10).background(Color.white)
                }
                VStack(alignment: .center) {
                    Group {
                        HStack(alignment: .top) {
                            Text("Medical History:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(cat.medicalHistory)
                            .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Vaccinations:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(cat.vaccinations)
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Is Microchipped:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(String(cat.isMicrochipped))
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Flea Control Date:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(String(cat.fleaControlDate))
                               .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Deworming Date:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(String(cat.dewormingDate))
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                    }
                }
                VStack(alignment: .center) {
                    Group {
                        HStack(alignment: .top) {
                            Text("FIV-FELV Date Tested:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            Text(cat.fivFelvDate)
                                .font(.custom("Euphemia UCAS", size: 14.0))
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Text("Special Needs:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            if cat.specialNeeds != nil {
                                Text(cat.specialNeeds!)
                                   .font(.custom("Euphemia UCAS", size: 14.0))
                            }
                            Spacer()
                        }.padding(10).background(Color.white)
                        HStack(alignment: .top) {
                            Group{
                                Text("Personality:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                                VStack (alignment: .leading){
                                    ForEach(cat.personality, id: \.self) { p in
                                        VStack (alignment: .trailing){
                                            Text(String(self.personalityData[Int(p)] ?? "")).font(.custom("Euphemia UCAS", size: 14.0))
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }.padding(10).background(Color.white)
                        //  .padding(7)
                        HStack(alignment: .top) {
                            Text("More Personality:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            if cat.specialNeeds != nil {
                                Text(cat.morePersonality!)
                                  .font(.custom("Euphemia UCAS", size: 14.0))
                            }
                            Spacer()
                        }.padding(10).background(Color.white)
                        // .padding(7)
                        HStack(alignment: .top) {
                            Text("Comments:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            if cat.specialNeeds != nil {
                                Text(cat.comments!)
                                    .font(.custom("Euphemia UCAS", size: 14.0))
                            }
                            Spacer()
                        }.padding(10).background(Color.white)
                        // .padding(7)
                        HStack(alignment: .top) {
                            Text("Personal Experiences:").font(.custom("Euphemia UCAS", size: 14.0)).bold()
                            if cat.specialNeeds != nil {
                                Text(cat.personalExp!)
                                    .font(.custom("Euphemia UCAS", size: 14.0))
                            }
                            Spacer()
                        }.padding(10).background(Color.white)
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .navigationBarTitle(Text(cat.name).font(.custom("Euphemia UCAS", size: 20.0)), displayMode: .inline)
            // .background(Color.bluecat.opacity(0.3)) 95,169,218
            .background(Color(red: 0.7215686, green: 0.917647, blue: 0.6888888))
            .edgesIgnoringSafeArea(.all)
    }
    
}

