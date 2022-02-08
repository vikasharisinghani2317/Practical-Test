//
//  LoginVC.swift
//  Practical_Test_Theta
//
//  Created by hyperlink on 08/02/22.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: Variable Declaration
    
    /* Button */
    @IBOutlet weak var btnLogin: UIButton!
    
    /* Textfield */
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    /* Local Varibale */
    var userName = "abc@yopmail.com"
    var password = "Qwerty@123"
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.hidesBackButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationItem.hidesBackButton = true
    }
}

//MARK: Private Helper Methods
extension LoginVC{
    
    func validateInfo(){
        let strEmail = self.txtEmail.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let strPassword = self.txtPassword.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        if strEmail.isEmpty{
            self.showAlert(message: "Please Enter Email")
            return
        }
        
        if !strEmail.isValidEmail(){
            self.showAlert(message: "Please Enter Valid Email")
            return
        }
        
        if strPassword.isEmpty {
            self.showAlert(message: "Please Enter Password")
            return
        }
        
        if !strPassword.isValidPassword(){
            self.showAlert(message: "Please must include ateast 1 capital letter, 1 small letter, 1 special character and 1 number and should be least 8 characters long.")
            return
        }
        
        UserDefaults.standard.set("true", forKey: "isLoggedIn")
        UserDefaults.standard.set(strEmail, forKey: "email")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "TabBarvc") as! TabBarvc
        VC.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
   
    
    func showAlert(message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: Button Click Event
extension LoginVC{
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        self.view.endEditing(true)
        
        validateInfo()
    }
}

extension String {
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
