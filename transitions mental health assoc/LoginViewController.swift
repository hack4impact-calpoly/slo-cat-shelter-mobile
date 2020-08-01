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
                             
class LoginViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var usernameTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
                                 
    @IBOutlet weak var loginbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Check if we are logged in on load
        loginbutton.backgroundColor = UIColor(red: 0.53725, green: 0.7725490, blue: 0.46666666666, alpha: 1)
        if let data = UserDefaults.standard.data(forKey: "user") {
            didLogin(userData: data)
        }
    }
    
    //function for login button press, checks if textfields are filled out
    @IBAction func loginButtonPress(_ sender: Any) {
        if usernameTextField.hasText && passwordTextField.hasText{
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
            login(username: self.usernameTextField.text!, password: self.passwordTextField.text!)
        }
        return true
    }
    
    
    /*Login with username and password*/
//    func login(username:String,password:String) {
//        let credentials = "f53bc11b9583f18ac20898c2e931efcc648339a3"
//
//        var semaphore = DispatchSemaphore (value: 0)
//
//        var request = URLRequest(url: URL(string: "https://cpcp-cats.herokuapp.com/api/users/")!,timeoutInterval: Double.infinity)
//        request.addValue(username, forHTTPHeaderField: "username")
//        request.addValue(password, forHTTPHeaderField: "password")
//        request.addValue("Token f53bc11b9583f18ac20898c2e931efcc648339a3", forHTTPHeaderField: "Authorization")
//
//        request.httpMethod = "GET"
//
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//
//          guard let data = data else {
//            Helper.showAlert(viewController: self, title: "Oops", message: "Username or Password Incorrect")
//            print(String(describing: error))
//            semaphore.signal()
//            return
//          }
//
//          self.didLogin(userData: data)
//          semaphore.signal()
//        }
//        task.resume()
//        semaphore.wait()
//
//
//    }
        
    
    
    
    
    func login(username:String,password:String) {
        let params = ["username":username,"password":password] as [String:Any]
        AF.request("https://cpcp-cats.herokuapp.com/api-token-auth/",method:.post,parameters:params).responseData
        { response in switch response.result {
            case .success(let data):
                switch response.response?.statusCode ?? -1 {
                    case 200:
                        self.didLogin(userData: data)
                    case 401:
                        Helper.showAlert(viewController: self, title: "Oops", message: "Username or Password Incorrect")
                    default:
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
            usernameTextField.text = ""
            passwordTextField.text = ""
            self.view.endEditing(false)
            self.performSegue(withIdentifier: "loginToDashboard", sender: nil)
        } catch {
            Helper.showAlert(viewController: self,title: "Oops!",message: error.localizedDescription)
        }
    }
    
    
}
