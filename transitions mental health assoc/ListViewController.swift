//
//  addPatientViewController.swift
//  Cal Poly Cat Program App
//
//  Created by Finlay Piroth on 4/14/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import SwiftUI

class ListViewController: UIViewController {
    
    @State var switchpage = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentView())
        }
    
}
