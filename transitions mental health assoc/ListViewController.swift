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
    //var catd : Cat

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.advanceToNextInputMode))
//
//        view.addGestureRecognizer(tap)
        
    }
    
    
    
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        //return UIHostingController(coder: coder, rootView: ContentView())
//        if (switchpage)
//        {
//            return UIHostingController(coder: coder, rootView: CatDetails(cat: catd))
//        }
        return UIHostingController(coder: coder, rootView: ContentView())
        
       // return UIHostingController(rootView: ContentView())
        }
    
}
