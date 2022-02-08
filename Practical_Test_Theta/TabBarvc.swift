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
        tabBar.items?.forEach { tabBarItem in
            if #available(iOS 13.0, *) {

            } else {
                tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            }
        }

        let homeVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC"))
        let profileVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC"))
        viewControllers = [homeVC, profileVC]
    }
}
