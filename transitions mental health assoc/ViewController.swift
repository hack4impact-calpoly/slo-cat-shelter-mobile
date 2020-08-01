//
//  ViewController.swift
//  Cal Poly Cat Program App
//
//  Created by Finlay Piroth on 1/7/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    //please forgive me for the terrible code in this file. This was one of if not the first thing I programmed in swift and I don't want to change it and ruin any functionality bc it works. I know how bad it is

    //must scrape data from website to input into the table cells
    //CELLS -> text info, image
    //give buttons functionality
    
    //MARK: properties
    @IBOutlet weak var dashboardButton: UIButton!
    @IBOutlet weak var messagesButton: UIButton!
    @IBOutlet weak var patientDataButton: UIButton!
    
    @IBOutlet weak var dashboardContainerView: UIView!
    @IBOutlet weak var messagesContainerView: UIView!
    @IBOutlet weak var patientDataContainerView: UIView!
    
    var currentButton = 1
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up buttons
        setButton(button: dashboardButton)
        dashboardButton.isSelected = true
        dashboardButton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
        messagesButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)
        patientDataButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)
        setButton(button: messagesButton)
        messagesButton.isSelected = false
        setButton(button: patientDataButton)
        patientDataButton.isSelected = false
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        
//        view.addGestureRecognizer(tap)
        
        //init which view shown
        dashboardContainerView.alpha = 1
        messagesContainerView.alpha = 0
        patientDataContainerView.alpha = 0
        
    }
    
    
    //MARK: functions
    //switch between child container views with button presses
    @IBAction func navButtonPressed(_ sender: UIButton) {
        if sender.tag == 1 {
            if currentButton == 1 {
                return
            } else {
                UIView.animate(withDuration: 0.3, animations: {self.dashboardContainerView.alpha = 1; self.messagesContainerView.alpha = 0; self.patientDataContainerView.alpha = 0})
                dashboardButton.isSelected = true
                UIButton.animate(withDuration: 0.3, animations: {self.dashboardButton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)})
                UIButton.animate(withDuration: 0.3, animations:{ self.messagesButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)})
                UIButton.animate(withDuration: 0.3, animations:{ self.patientDataButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)})
                currentButton = 1
            }
        } else if sender.tag == 2 {
            if currentButton == 2 {
                return
            } else {
                UIView.animate(withDuration: 0.3, animations: {self.dashboardContainerView.alpha = 0; self.messagesContainerView.alpha = 1; self.patientDataContainerView.alpha = 0})
                messagesButton.isSelected = true
                UIButton.animate(withDuration: 0.3, animations: {self.messagesButton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)})
                UIButton.animate(withDuration: 0.3, animations:{ self.dashboardButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)})
                UIButton.animate(withDuration: 0.3, animations:{ self.patientDataButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)})
                currentButton = 2
            }
        } else if sender.tag == 3 {
            if currentButton == 3 {
                return
            } else {
                UIView.animate(withDuration: 0.3, animations: {self.dashboardContainerView.alpha = 0; self.messagesContainerView.alpha = 0; self.patientDataContainerView.alpha = 1})
                patientDataButton.isSelected = true
                UIButton.animate(withDuration: 0.3, animations: {self.patientDataButton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)})
                UIButton.animate(withDuration: 0.3, animations:{ self.messagesButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)})
                UIButton.animate(withDuration: 0.3, animations:{ self.dashboardButton.backgroundColor = UIColor(red: 0.7215686, green: 0.917647, blue: 0.6888888, alpha: 1)})
                currentButton = 3
            }
        } else {
            print("error on button press")
            return
        }
    }
    
    @objc func dismissKeyboard (){
        view.endEditing(true)
    }
    
    func setButton(button: UIButton){
        let imgsize = button.imageView!.frame.size
        let titlesize = button.titleLabel!.frame.size
        let totalHeight = imgsize.height + titlesize.height

        button.imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imgsize.height), left: 42.5 - (imgsize.width/2), bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imgsize.width, bottom: -(totalHeight - titlesize.height), right: 0)
    }
}

