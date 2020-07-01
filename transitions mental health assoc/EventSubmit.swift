//
//  EventSubmit.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 6/25/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import SwiftUI

struct EventSubmit: View {
    @State var catID: Int
    var body: some View {
        ScrollView {
            Text("Add Event")
            HStack{
                Text("Cat ID:")
                TextField("", text: $catID)
            }
            
        }
    }
}

struct EventSubmit_Previews: PreviewProvider {
    static var previews: some View {
        EventSubmit()
    }
}
