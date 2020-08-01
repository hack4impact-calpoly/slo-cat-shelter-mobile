//
//  dashboardViewController.swift
//  Cal Poly Cat Program App
//
//  Created by Finlay Piroth on 4/7/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import Alamofire
import UIKit
import SwiftUI

class dashboardViewController: UIViewController {
    
    @IBSegueAction func ConnectEventList(_ coder: NSCoder) -> UIViewController? {
        let hostingController = UIHostingController(coder: coder, rootView: EventList())
        hostingController!.view.backgroundColor = UIColor.clear;
        return hostingController
    }
    //MARK: properties
    @IBOutlet weak var catIDTextField: UITextField!
    @IBOutlet weak var aptTypeSegCntrl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var addbutton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //the following nasty code is to bump everything up so that the keyboard doesn't block input fields, and bump it back down when keyboard is gone
        addbutton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
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
        if catIDTextField.hasText && titleTextField.hasText && notesTextView.hasText{
            print(datePicker.date)
            let headers : HTTPHeaders = [
                "Authorization": "token \(User.current.token)"
            ]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date_str = dateFormatter.string(from: datePicker.date)
            
            dateFormatter.dateFormat = "hh:mm"
            let time_str = dateFormatter.string(from: timePicker.date)
            
            var event_str = ""
            if ("\(aptTypeSegCntrl.titleForSegment(at: aptTypeSegCntrl.selectedSegmentIndex) ?? "")" == "Vet Apt")
            {
                event_str = "vet"
            }
            if ("\(aptTypeSegCntrl.titleForSegment(at: aptTypeSegCntrl.selectedSegmentIndex) ?? "")") == "Adoption Apt"
            {
                event_str = "adoption"
            }
            if ("\(aptTypeSegCntrl.titleForSegment(at: aptTypeSegCntrl.selectedSegmentIndex) ?? "")") == "Foster Apt"
            {
                event_str = "foster"
            }
            
            let body = [
                "cat_id": catIDTextField.text!,
//                "event_type": "\(String(describing: aptTypeSegCntrl.titleForSegment(at: aptTypeSegCntrl.selectedSegmentIndex)))",
                "event_type": event_str,
                "title": titleTextField.text!,
                "date": "\(date_str)",
                "time": "\(time_str)",
                "notes": notesTextView.text!
                ] as [String : Any]
            
            AF.request("https://cpcp-cats.herokuapp.com/api/events/",method: .post, parameters: body, headers: headers).responseData {
                response in switch response.result {
                case .success(let data):
                    let datastring = String(data: data, encoding: .utf8)
                    print("success with response string: \(datastring ?? "Oops! No data :(")")
                    let alert = UIAlertController(title: "Event submitted!", message: "event submitted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: false)
                    self.catIDTextField.text = ""
                    self.titleTextField.text = ""
                    self.notesTextView.text = ""
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
