//
//  CatViewModel.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/13/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Combine

class CatViewModel: ObservableObject {
    //@Published var cats = CatList(results: [])
    //@Published var cats = CatList(results: [])
    @Published var cats : CatList2 = []
    @Published var loading = false

    let service: ServiceProtocol
    init(service: ServiceProtocol = NetworkManager()) {
        self.service = service
    }
    
    func loadData() {
        self.loading = true
        service.fetchCats { cats in
            self.loading = false
            guard let cats = cats else { return }
            //self.cats.results = cats
            self.cats = cats
        }
    }
}
