//
//  catIDPickerClass.swift
//  transitions mental health assoc
//
//  Created by Finlay Piroth on 8/22/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
//contains methods and stuff for the cat ID pickerview
class catIDPickerClass: UIPickerView, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var data: [String] = ["first","second","volunteer"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
