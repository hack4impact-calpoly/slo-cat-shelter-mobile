//
//  dashboardViewController.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 4/7/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import Alamofire
import UIKit
import SwiftUI

class dashboardViewController: UIViewController {
    
    //MARK: properties
    @IBOutlet weak var catidTextField: UITextField!
    @IBOutlet weak var aptTypeSegCntrl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //the following nasty code is to bump everything up so that the keyboard doesn't block input fields, and bump it back down when keyboard is gone
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //add GET requests
        // Do any additional setup after loading the view.
    }
    //MARK: functions
    
    @objc func dismissKeyboard (){
        view.endEditing(true)
    }
    
//    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
//    return UIHostingController(coder: coder, rootView: EventList())
//    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
//    private func loadDataByAlamofire(_ completion: @escaping ([Cat]?) -> Void) {
//        let headers : HTTPHeaders = [
//            "Authorization": User.current.token
//        ]
//        AF.request("https://cpcp-cats.herokuapp.com/api/cats/", method: .get, headers: headers).responseJSON{ response in
//                guard let data = response.data else {
//                    completion(nil)
//                    return
//                }
//               // var datadict = ["results": data]
//                guard let cats = try? JSONDecoder().decode(CatList2.self, from: data) else {
//                    completion(nil)
//                    return
//                }
//                DispatchQueue.main.async {
//                    completion(cats)
//                }
//        }
//    }
    
    
    @IBAction func addEvent(_ sender: Any) {
        //http POST to event api endpoint here
        if catidTextField.hasText && titleTextField.hasText && notesTextView.hasText{
            print(datePicker.date)
            let headers : HTTPHeaders = [
                "Authorization": "token \(User.current.token)"
            ]
            
            let body = [
                "cat_id": catidTextField.text!,
                "event_type": "\(String(describing: aptTypeSegCntrl.titleForSegment(at: aptTypeSegCntrl.selectedSegmentIndex)))",
                "title": titleTextField.text!,
                "date": "\(datePicker.date)",
                "time": "\(timePicker.date)",
                "notes": notesTextView.text!
                ] as [String : Any]
            
            AF.request("https://cpcp-cats.herokuapp.com/api/events/",method: .post, parameters: body, headers: headers).responseData {
                response in switch response.result {
                case .success(let data):
                    let datastring = String(data: data, encoding: .utf8)
                    print("success with response string: \(datastring ?? "Oops! No data :(")")
                case .failure(let error):
                    print("failure with response error: \(error)")
                }
            }
        } else {
            //alert not all fields filled out
            let alert = UIAlertController(title: "Incomplete", message: "please make sure all fields are filled out before adding the event", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: false)
        }
    }
}
