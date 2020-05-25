//
//  CatDetails.swift
//  transitions mental health assoc
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
    var personalityData = [0:"Indoors only", 1:"Indoors and outdoor", 2:"Lap cat", 3:"Mellow", 4:"Active", 5:"Independent", 6:"Shy",7:"Playful",8:"Friendly",9:"Curious",10:"Feisty",11:"Affectionate",12:"Loves attention",13:"Aloof",14:"Swats when over stimulated",15:"Needs quiet home", 16:"Likes to be held/picked up", 17:"Doesn't like to be held/picked up", 18:"Comfortable with other cats", 19:"Not comfortable with other cats", 20:"Comfortable with dogs", 21:"Not comfortable with dogs", 22:"Good with younger kids",23:"Good with older kids", 24: "Needs a home with adults only", 25: "Needs time to know and trust you"]
    
    var body: some View {
        //        Text(cat.name)
        ScrollView {
            VStack {
                Spacer()
                Spacer()
                //  Spacer()
                //  Spacer()
                //  Spacer()
                // Spacer()
                // Spacer()
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
                        }.padding(8)
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
                            Group{
                                Text("Personality:").font(.subheadline).bold()
                                VStack (alignment: .leading){
                                    ForEach(cat.personality, id: \.self) { p in
                                        // (cat.personality).forEach { p in
                                        VStack (alignment: .trailing){
                                            Text(String(self.personalityData[Int(p)] ?? "")).font(.subheadline)
                                            //Text(", \n").font(.subheadline)
                                        }
                                    }
                                }
                            }
                            
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
            // .background(Color.bluecat.opacity(0.3)) 95,169,218
            .background(Color(red: 0.37, green: 0.66, blue: 0.85))
            .edgesIgnoringSafeArea(.all)
        
    }
    
}

struct CatDetails_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
