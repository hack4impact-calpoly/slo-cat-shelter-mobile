//
//  ServiceProtocol.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 5/13/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func fetchCats(completion: @escaping ([Cat]?) -> Void)
    func fetchPhotos(completion: @escaping ([PhotoElement]?) -> Void)
}
