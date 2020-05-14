//
//  CatDetails.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/12/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import SwiftUI
import URLImage
let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"
struct CatDetails : View {
    var cat: Cat
    var body: some View {
//        Text(cat.name)
        ScrollView {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            VStack(alignment: .center) {
                Group {
                    Spacer()
                    HStack(alignment: .top) {
//                        Group {
//                                URLImage(URL(string:  "\(BASE_IMAGE_URL)\(cat.image_path)")!, delay: 0.25) {proxy in
//                                    proxy.image.resizable()
//
//                                        .frame(width: UIScreen.main.bounds.height/8*3, height: UIScreen.main.bounds.height/2)
//                                }
                        Text(cat.name).font(.largeTitle)
//                        }
                    }
                    HStack(alignment: .top) {
                        Text("Age:").font(.subheadline).bold()
                        Text(String(cat.age))
                            .font(.subheadline)
                        Spacer()

                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Gender:").font(.subheadline).bold()
                        Text(String(cat.gender))
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Description:").font(.subheadline).bold()
                        Text(cat.welcomeDescription)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(10).background(Color.white)
                    //.padding(7)
                    HStack(alignment: .top) {
                        Text("Breed:").font(.subheadline).bold()
                        Text(cat.breed)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(10).background(Color.white)
                    //.padding(7)
                    HStack(alignment: .top) {
                        Text("Type:").font(.subheadline).bold()
                        Text(String(cat.itype))
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(10).background(Color.white)
                    //.padding(7)
                    HStack(alignment: .top) {
                        Text("status:").font(.subheadline).bold()
                        Text(String(cat.status))
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(10).background(Color.white)
                   // .padding(7)
                    HStack(alignment: .top) {
                        Text("Arrival Date:").font(.subheadline).bold()
                        Text(String(cat.arrivalDate))
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Arrival Details:").font(.subheadline).bold()
                        Text(cat.arrivalDetails)
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                }
            }
            VStack(alignment: .center) {
                Group {
                    HStack(alignment: .top) {
                        Text("Medical History:").font(.subheadline).bold()
                        Text(cat.medicalHistory)
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Vaccinations:").font(.subheadline).bold()
                        Text(cat.vaccinations)
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Is Microchipped:").font(.subheadline).bold()
                        Text(String(cat.isMicrochipped))
                            .font(.subheadline)
                        Spacer()

                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Flea Control Date:").font(.subheadline).bold()
                        Text(String(cat.fleaControlDate))
                            .font(.subheadline)
                        Spacer()

                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Deworming Date:").font(.subheadline).bold()
                        Text(String(cat.dewormingDate))
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                }
            }
            VStack(alignment: .center) {
                Group {
                    HStack(alignment: .top) {
                        Text("FIV-FELV Date Tested:").font(.subheadline).bold()
                        Text(cat.fivFelvDate)
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                        //.padding(7)
                    HStack(alignment: .top) {
                        Text("Special Needs:").font(.subheadline).bold()
                        if cat.specialNeeds != nil {
                            Text(cat.specialNeeds!)
                            .font(.subheadline)
                        }
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Personality:").font(.subheadline).bold()
                            //    Text((cat.personality).joined(separator: " "))
                            .font(.subheadline)
                        Spacer()
                    }.padding(10).background(Color.white)
                      //  .padding(7)
                    HStack(alignment: .top) {
                        Text("More Personality:").font(.subheadline).bold()
                        if cat.specialNeeds != nil {
                            Text(cat.morePersonality!)
                            .font(.subheadline)
                        }
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Comments:").font(.subheadline).bold()
                        if cat.specialNeeds != nil {
                            Text(cat.comments!)
                            .font(.subheadline)
                        }
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    HStack(alignment: .top) {
                        Text("Personal Experiences:").font(.subheadline).bold()
                        if cat.specialNeeds != nil {
                            Text(cat.personalExp!)
                            .font(.subheadline)
                        }
                        Spacer()
                    }.padding(10).background(Color.white)
                       // .padding(7)
                    Spacer()
                }
            }
        }
        }
        .padding()
        .navigationBarTitle(Text(cat.name), displayMode: .inline)
        .background(Color.blue.opacity(0.3))
        .edgesIgnoringSafeArea(.all)
        
    }
    
}
