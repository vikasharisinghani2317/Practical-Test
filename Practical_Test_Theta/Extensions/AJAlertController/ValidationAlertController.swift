//
//  ValidationAlertController.Swift
//  ValidationAlertController
//
//  Created by on 13/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import Foundation

class ValidationAlertController: UIViewController {
    
    // MARK:- Private Properties
    // MARK:-

    private var strAlertText = String()
    private var btnOkTitle:String?
    
    private let btnOkColor  = UIColor.red
    
    // MARK:- Public Properties
    // MARK:-

    @IBOutlet var viewAlert: UIView!
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var imgAlert: UIImageView?
    @IBOutlet var btnOK: UIButton!
    @IBOutlet var viewAlertBtns: UIView!
    @IBOutlet var alertWidthConstraint: NSLayoutConstraint!
    
    /// AlertController Completion handler
    typealias alertCompletionBlock = ((Int, String) -> Void)?
    private var block : alertCompletionBlock?
    
    // MARK:- ValidationAlertController Initialization
    // MARK:-
    
    /**
     Creates a instance for using ValidationAlertController
     - returns: ValidationAlertController
     */
    static func initialization() -> ValidationAlertController
    {
        let alertController = ValidationAlertController(nibName: "ValidationAlertController", bundle: nil)
        return alertController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidationAlertController()
    }
    
    // MARK:- ValidationAlertController Private Functions
    // MARK:-
    
    /// Inital View Setup
    private func setupValidationAlertController(){
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.8
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped)))
        self.view.insertSubview(visualEffectView, at: 0)
        
        preferredAlertWidth()
        
        viewAlert.layer.cornerRadius  = 10.0
        viewAlert.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        viewAlert.layer.shadowColor   = UIColor(white: 0.0, alpha: 1.0).cgColor
        viewAlert.layer.shadowOpacity = 0.3
        viewAlert.layer.shadowRadius  = 10.0
        
        lblAlertText?.text   = strAlertText
        btnOK.setTitleColor(btnOkColor, for: .normal)
    }
    
    /// Setup different widths for iPad and iPhone
    private func preferredAlertWidth()
    {
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                alertWidthConstraint.constant = 280.0
            case .pad:
                alertWidthConstraint.constant = 340.0
            case .unspecified: break
            case .tv: break
            case .carPlay: break
        default: break
        }
    }
    
    /// Create and Configure Alert Controller
    private func configure(message:String, btnOkTitle:String?)
    {
        self.strAlertText  = message
        self.btnOkTitle    = btnOkTitle
//        self.imgAlert?.image = UIImage.init(named: "validationError")
    }
    
    /// Show Alert Controller
    private func show()
    {
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {
            
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            
            topViewController.addChild(self)
            topViewController.view.addSubview(view)
            viewWillAppear(true)
            didMove(toParent: topViewController)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.alpha = 0.0
            view.frame = topViewController.view.bounds
            
            viewAlert.alpha     = 0.0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.view.alpha = 1.0
            }, completion: nil)
            
            viewAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-10)
            UIView.animate(withDuration: 0.2 , delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                self.viewAlert.alpha = 1.0
                self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0))
            }, completion: nil)
        }
    }
    
    /// Hide Alert Controller
    private func hide()
    {
        self.view.endEditing(true)
        self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.viewAlert.alpha = 0.0
            self.viewAlert.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-5)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseIn, animations: { () -> Void in
            self.view.alpha = 0.0
            
        }) { (completed) -> Void in
            
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }
    
    // MARK:- UIButton Clicks
    // MARK:-
    
    @IBAction func btnOkTapped(sender: UIButton) {
        hide()
        block!!(0,"OK")
    }
    
    /// Hide Alert Controller on background tap
    @objc func backgroundViewTapped(sender:AnyObject)
    {
        hide()
    }

    // MARK:- AJAlert Functions
    // MARK:-

    /**
     Display an Alert
     
     - parameter aStrMessage:    Message to display in Alert
     - parameter aCancelBtnTitle: Cancel button title
     - parameter aOtherBtnTitle: Other button title
     - parameter otherButtonArr: Array of other button title
     - parameter completion:     Completion block. Other Button Index - 1 and Cancel Button Index - 0
     */
    
    public func showAlert( aStrMessage:String,
                    aOkBtnTitle:String?,
                    completion : alertCompletionBlock){
        configure( message: aStrMessage, btnOkTitle: aOkBtnTitle)
        show()
        block = completion
    }
    
    /**
     Display an Alert With "OK" Button
     
     - parameter aStrMessage: Message to display in Alert
     - parameter completion:  Completion block. OK Button Index - 0
     */
    
    public func showAlertWithOkButton( aStrMessage:String,
                                completion : alertCompletionBlock){
        configure(message: aStrMessage, btnOkTitle: nil)
        show()
        block = completion
    }
 }

