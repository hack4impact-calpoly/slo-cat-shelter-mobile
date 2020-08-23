//
//  catSelectDropdown.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 8/11/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import SwiftUI

struct catSelectDropdown: View {
    @State var showCats = false
    @State var catsList: [Int: String] = [:]
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = NetworkManager()) {
        self.service = service
    }
    var body: some View {
        VStack {
            HStack {
                Button ("Click to show cats", action: {
                    self.showCats = !(self.showCats)
                })
            }
            if showCats {
                List {
                    ForEach(createCatList().sorted(by: >), id: \.key) { key, value in
                        Section(header: Text("blabh")) {
                            Text(value)
                        }
                    }
                }
            }
        }
    }
    
    func createCatList() -> Dictionary<Int, String> {
        var catDict: [Int:String] = [:]
        service.fetchCats { cats in
            guard let cats = cats else {return}
            for cat in cats {
                catDict[cat.id!] = cat.name
                print(cat.id)
                print(cat.name)
            }
        }
        return catDict
    }
}

struct catSelectDropdown_Previews: PreviewProvider {
    static var previews: some View {
        catSelectDropdown()
    }
}
