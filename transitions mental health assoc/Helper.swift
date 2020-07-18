//
//  Helper.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 6/7/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

// Helper.swift
         
import UIKit
                             
class Helper {
    static func showAlert(viewController:UIViewController,title:String?,message:String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alert.addAction(dismiss)
        viewController.present(alert, animated: true, completion: nil)
    }
}
