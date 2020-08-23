//
//  LoginViewController.swift
//  Cal Poly Cat Program App
//
//  Created by Jillian Quinn on 6/7/20.
//  Copyright © 2020 Hack4Impact. All rights reserved.
//

// ViewControllers/LoginViewController.swift
         
import UIKit
import Alamofire
import SwiftUI
import Foundation
import Combine
import SwiftUI
import CoreData
import Alamofire
import UIKit
                             
class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var usernameTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    
    @ObservedObject var viewmodel = CatViewModel()
                                 
    @IBOutlet weak var loginbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if we are logged in on load
        loginbutton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
        loginbutton.layer.cornerRadius = 5.0
        enable()
        if let data = UserDefaults.standard.data(forKey: "user") {
            didLogin(userData: data)
        }
    }
    
    //function for login button press, checks if textfields are filled out
    @IBAction func loginButtonPress(_ sender: Any) {
        if usernameTextField.hasText && passwordTextField.hasText{
            disable()
            login(username: usernameTextField.text!, password: passwordTextField.text!)
        } else {
            let alert = UIAlertController(title: "Login Failed", message: "Please make sure both fields are filled out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert,animated: true)
            return
        }
    }
    
    /*Perform actions when the return key is pressed*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            //change cursor from username to password textfield
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            //attempt to login when we press enter on password field
            disable()
            login(username: self.usernameTextField.text!, password: self.passwordTextField.text!)
        }
        return true
    }
    
    
    func disable() -> Void {
        passwordTextField.isEnabled = false
        usernameTextField.isEnabled = false
        loginbutton.isEnabled = false
        usernameTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        passwordTextField.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        loginbutton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func enable() -> Void {
        passwordTextField.isEnabled = true
        usernameTextField.isEnabled = true
        loginbutton.isEnabled = true
        usernameTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        loginbutton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
    }
    
    func login(username:String,password:String) {
        let params = ["username":username,"password":password] as [String:Any]
        AF.request("https://cpcp-cats.herokuapp.com/api-token-auth/",method:.post,parameters:params).responseData
        { response in switch response.result {
            case .success(let data):
                switch response.response?.statusCode ?? -1 {
                    case 200:
                        self.didLogin(userData: data)
                    case 401:
                        self.enable()
                        Helper.showAlert(viewController: self, title: "Oops", message: "Username or Password Incorrect")
                    default:
                        self.enable()
                        Helper.showAlert(viewController: self, title: "Oops", message: "Incorrect Username or Password")
                }
            case .failure(let error):
                Helper.showAlert(viewController: self,title: "Oops!",message: error.localizedDescription)
            }
        }
    }
    
    /*User login was successful
     - we segue to inbox and initialize User.current*/
    func didLogin(userData:Data) {
        do {
            //decode data into user object
            User.current = try JSONDecoder().decode(User.self, from: userData)
            viewmodel.loadData()
            usernameTextField.text = ""
            passwordTextField.text = ""
            self.view.endEditing(false)
            self.performSegue(withIdentifier: "loginToDashboard", sender: nil)
        } catch {
            Helper.showAlert(viewController: self,title: "Oops!",message: error.localizedDescription)
        }
    }
    
    
}
