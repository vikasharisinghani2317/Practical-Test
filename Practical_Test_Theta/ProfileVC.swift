//
//  ProfileVC.swift
//  Practical_Test_Theta
//
//  Created by hyperlink on 08/02/22.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: Variable Declaration
    
    /* Textfield */
    @IBOutlet weak var lblEmail : UILabel!
    
    /* Button */
    @IBOutlet weak var btnLogout : UIButton!
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.navigationItem.hidesBackButton = true
//    }
}

//MARK: Private Helper Methods
extension ProfileVC{
    
    func setupView(){
        
        let email = UserDefaults.standard.string(forKey: "email")  ?? ""
        self.lblEmail.text = email
    }
    
    func setLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let obj = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        guard let window = UIApplication.shared.windows.first else { return }
        let navi = UINavigationController(rootViewController: obj)
        window.rootViewController = navi
        window.makeKeyAndVisible()
    }
}

//MARK: Button Click Event
extension ProfileVC{
    
    @IBAction func didTapLogout(_ sender : UIButton){
        self.view.endEditing(true)
    
        UserDefaults.resetDefaults()
        setLogin()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        self.navigationController?.popToRootViewController(animated: true)
//        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
