//
//  TabBarvc.swift
//  Practical_Test_Theta
//
//  Created by hyperlink on 08/02/22.
//

import UIKit

class TabBarvc: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setVC()
        // Do any additional setup after loading the view.
    }
    

    private func setVC() {
        let homeVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC"))
        let profileVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC"))
        viewControllers = [homeVC, profileVC]
    }
}
