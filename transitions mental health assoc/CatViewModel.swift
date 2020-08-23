//
//  CatViewModel.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 5/13/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Combine
import Foundation

class CatViewModel: ObservableObject {
    @Published var cats : CatList2 = []
    @Published var photos : Photos = []
    @Published var photoDict: [Int:PhotoElement] = [Int: PhotoElement]()
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
            var catlist: CatList2 = []
            var count = 0
            for var cat in cats {
                cat.id = count
                catlist.append(cat)
                count += 1
            }
            self.cats = catlist
        }
        service.fetchPhotos { photos in
            self.loading = false
            guard let photos = photos else { return }
            self.photos = photos
            var catpic = photos
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date_str = dateFormatter.string(from: Date())
            for cat in self.cats {
                catpic = photos.filter { $0.catID == cat.id}
                if (catpic.count == 0) {
                    catpic = [PhotoElement(catID: 100, photourl: "https://img.icons8.com/carbon-copy/100/000000/cat.png", photoDescription: "default", uploadedAt: date_str, hidden: false)]
                }
                self.photoDict[cat.id ?? 2] = catpic[0]
            }
        }
    }
}

