//
//  dashboardViewController.swift
//  Cal Poly Cat Program App
//
//  Created by Finlay Piroth on 4/7/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import Combine
import Alamofire
import UIKit
import SwiftUI

import Foundation
import CoreData


class dashboardViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBSegueAction func ConnectEventList(_ coder: NSCoder) -> UIViewController? {
        let hostingController = UIHostingController(coder: coder, rootView: EventList())
        hostingController!.view.backgroundColor = UIColor.clear;
        return hostingController
    }
    @ObservedObject var viewmodel = CatViewModel()
    
    //MARK: properties
    @IBOutlet weak var aptTypeSegCntrl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var addbutton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var catIDPickerView: UIPickerView!
    var data: [String] = [String]()
    var catnames: [String] = [String]()
    var selectedCatName = ""
    var selectedCatid = 1
    
    override func viewDidLoad() {
        viewmodel.loadData()
        super.viewDidLoad()
        self.catIDPickerView.delegate = self
        self.catIDPickerView.dataSource = self
        
        
        //the following nasty code is to bump everything up so that the keyboard doesn't block input fields, and bump it back down when keyboard is gone
        aptTypeSegCntrl.selectedSegmentTintColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
        aptTypeSegCntrl.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)
        addbutton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    //MARK: functions
    //UIPicker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (viewmodel.cats.count == 0) {
            return 2
        }
        else
        {
            return self.catnames.count
        }
    }
    
    //This function is what puts the data in each row, presuming data will have the cats in it
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (viewmodel.cats.count == 0) {
            self.catnames = ["Scroll to Select Cat", ""]
        }
        else
        {
            self.catnames=[]
                for cat in (viewmodel.cats).sorted(by: {$0.name < $1.name}) {
                self.catnames.append(cat.name)
            }
        }
        return self.catnames[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCatName = self.catnames[row]
        let selectedcat = viewmodel.cats.filter( { return $0.name == selectedCatName } )
        self.selectedCatid = selectedcat[0].id ?? 1
        catIDPickerView.reloadAllComponents()
    }
    
    @objc func dismissKeyboard (){
        view.endEditing(true)
    }
    
    //keyboard hide/show functions
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
    
    //http post triggered by event submission
    @IBAction func addEvent(_ sender: Any) {
        //http POST to event api endpoint here
        if titleTextField.hasText && notesTextView.hasText{
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
                "cat_id": self.selectedCatid,
                "name": self.selectedCatName,
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
