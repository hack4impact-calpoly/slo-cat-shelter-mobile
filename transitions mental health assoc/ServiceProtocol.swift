//
//  ServiceProtocol.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 5/13/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    func fetchCats(completion: @escaping ([Cat]?) -> Void)
}
