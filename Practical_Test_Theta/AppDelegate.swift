//
//  AppDelegate.swift
//  Practical_Test_Theta
//
//  Created by hyperlink on 08/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let isLoggedIn = UserDefaults.standard.string(forKey: "isLoggedIn")  ?? ""
        
        if isLoggedIn == "true"{
            
            let initialViewControlleripad : UIViewController = storyboard.instantiateViewController(withIdentifier: "TabBarvc") as! TabBarvc
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }else{
            let initialViewControlleripad : UIViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewControlleripad
            self.window?.makeKeyAndVisible()
        }
        return true
    }
}

