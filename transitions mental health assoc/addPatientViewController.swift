//
//  addPatientViewController.swift
//  Cal Poly Cat Program App
//
//  Created by Finlay Piroth on 4/14/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import Alamofire

var globalkeys: [Int] = []

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
        for datePicker in formDatePickers {
            print(convertDateFormater(datePicker.date))
        }
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
        
        let url = URL(string: "https://cpcp-cats.herokuapp.com/api/cats/")
        guard let requestURL = url else {
            fatalError()
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        //request.setValue("basic auth", forHTTPHeaderField: "Authorization")
            
        var postString = "name=\(formTextFields[0].text!)&gender=\(formSegCntrls[0].titleForSegment(at: formSegCntrls[0].selectedSegmentIndex)!)&birthday=\(convertDateFormater(formDatePickers[4].date))&description=\(formTextViews[0].text!)&breed=\(formTextFields[1].text ?? "none")&itype=\(formSegCntrls[1].titleForSegment(at: formSegCntrls[1].selectedSegmentIndex)!)&status=\(formSegCntrls[2].titleForSegment(at:formSegCntrls[2].selectedSegmentIndex)!)&arrival_date=\(convertDateFormater(formDatePickers[0].date))&arrival_details=\(formTextViews[1].text!)&medical_history=\(formTextViews[2].text!)&vaccinations=\(formTextViews[3].text!)&is_microchipped=\(formSegCntrls[3].selectedSegmentIndex == 0 ? "T": "F")&flea_control_date=\(convertDateFormater(formDatePickers[1].date))&deworming_date=\(convertDateFormater(formDatePickers[2].date))&fiv_felv_date=\(convertDateFormater(formDatePickers[3].date))&special_needs=\(formTextViews[4].text ?? "No special needs provided.")&more_personality=\(formTextViews[5].text ?? "No additional personality provided.")&comments=\(formTextViews[6].text ?? "No comments provided.")&personal_exp=\(formTextViews[7].text ?? "No personal experience provided.")"
        
        for num in globalkeys {
            postString += "&personality=\(num+1)"
        }
        request.httpBody = postString.data(using: String.Encoding.utf8)
        request.setValue("Token \(User.current.token)", forHTTPHeaderField: "Authorization") //dont know if this works yet
        
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: request) {(data, response, error) in
            if let error = error {
                print("Error occured \(error)")
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                //self.clearFields()
            }
        }
        task.resume()
    }
    
//    func clearFields() {
//        for textField in formTextFields {
//            textField.text = ""
//        }
//        for textView in formTextViews {
//            textView.text = ""
//        }
//    }
    
    func convertDateFormater(_ date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date)
    }
}

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var collectionData = [0:"Indoors only", 1:"Indoors and outdoor", 2:"Lap cat", 3:"Mellow", 4:"Active", 5:"Independent", 6:"Shy",7:"Playful",8:"Friendly",9:"Curious",10:"Feisty",11:"Affectionate",12:"Loves attention",13:"Aloof",14:"Swats when over stimulated",15:"Needs quiet home", 16:"Likes to be held/picked up", 17:"Doesn't like to be held/picked up", 18:"Comfortable with other cats", 19:"Not comfortable with other cats", 20:"Comfortable with dogs", 21:"Not comfortable with dogs", 22:"Good with younger kids",23:"Good with older kids", 24: "Needs a home with adults only", 25: "Needs time to know and trust you"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkboxClick(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "uncheckedbox"), for: .normal)
            //remove tag here
            globalkeys = globalkeys.filter { $0 != sender.tag}
        } else {
            sender.setImage(UIImage(named: "checkedbox"), for: .selected)
            globalkeys.append(sender.tag)
        }
        print(globalkeys)
        sender.isSelected = !sender.isSelected
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if let label = cell.viewWithTag(100) as? UILabel {
            label.text = collectionData[indexPath.row]
        }
        if let button = cell.viewWithTag(200) as? UIButton {
            button.tag = indexPath.row
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
