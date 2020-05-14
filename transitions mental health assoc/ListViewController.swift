//
//  addPatientViewController.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 4/14/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import SwiftUI

class ListViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        //return UIHostingController(coder: coder, rootView: ContentView())
        return UIHostingController(coder: coder, rootView: ContentView())
        
       // return UIHostingController(rootView: ContentView())
        }
    
}
