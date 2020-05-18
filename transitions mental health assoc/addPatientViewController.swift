//
//  addPatientViewController.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 4/14/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit

class addPatientViewController: UIViewController {
    
    //MARK: properties
    @IBOutlet var formDatePickers: [UIDatePicker]!
    @IBOutlet var formTextViews: [UITextView]!
    @IBOutlet var formSegCntrls: [UISegmentedControl]!
    @IBOutlet var formTextFields: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height - 150)
            }
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Incomplete Form", message: "Please make sure all required fields are filled out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //check for text fields not being filled out
        for textField in formTextFields {
            if textField.text == "" {
                self.present(alert, animated: true)
                return
            }
        }
        //check for required text views not being filled out
        for textView in formTextViews {
            if textView.text == "" && textView.tag != 1 {
                self.present(alert, animated: true)
                return
            }
        }
        
        let url = URL(string: "https://tmha-backend.herokuapp.com/api/cats/")
        guard let requestURL = url else {
            fatalError()
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        let age = String(format: "%.1f", Float(formTextFields[1].text!)! + Float(formTextFields[2].text!)!/12.0)
        
        let postString = "name=\(formTextFields[0].text!)&gender=\(formSegCntrls[0].titleForSegment(at: formSegCntrls[0].selectedSegmentIndex)!)&age=\(Float(age)!)&description=\(formTextViews[0].text!)&breed=\(formTextFields[3].text ?? "none")&itype=\(formSegCntrls[1].titleForSegment(at: formSegCntrls[1].selectedSegmentIndex)!)&status=\(formSegCntrls[2].titleForSegment(at:formSegCntrls[2].selectedSegmentIndex)!)&arrival_date=\(convertDateFormater(formDatePickers[0].date))&arrival_details=\(formTextViews[1].text!)&medical_history=\(formTextViews[2].text!)&vaccinations=\(formTextViews[3].text!)&is_microchipped=\(formSegCntrls[3].selectedSegmentIndex == 0 ? "T": "F")&flea_control_date=\(convertDateFormater(formDatePickers[1].date))&deworming_date=\(convertDateFormater(formDatePickers[2].date))&fiv_felv_date=\(convertDateFormater(formDatePickers[3].date))&special_needs=\(formTextViews[4].text ?? "No special needs provided.")&more_personality=\(formTextViews[5].text ?? "No additional personality provided.")&comments=\(formTextViews[6].text ?? "No comments provided.")&personal_exp=\(formTextViews[7].text ?? "No personal experience provided.")"
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("Error occured \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }
    
    func convertDateFormater(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date)
    }
}
