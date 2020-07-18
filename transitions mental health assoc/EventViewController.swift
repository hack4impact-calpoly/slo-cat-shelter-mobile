//
//  EventViewController.swift
//  transitions mental health assoc
//
//  Created by Jillian Quinn on 7/13/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class EventViewController: UIViewController {
    
    @State var switchpage = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: EventList())
        }
    
}
