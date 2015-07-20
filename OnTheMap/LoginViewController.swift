//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Samuel Doherty on 7/12/15.
//  Copyright (c) 2015 ColombiaIOS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet var viewController: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lightOrange = UIColor(red:253/255, green: 150/255, blue: 41/255, alpha: 1).CGColor
        let darkOrange = UIColor(red:252/255, green: 111/255, blue: 33/255, alpha: 1).CGColor
        
//        email.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        configureGradientBackground(lightOrange,darkOrange)
    
    }

    @IBAction func login(sender: UIButton) {
        
     
        StudentClient.sharedInstance().loginWithUsernameAndPassword(email.text!, password: password.text!) { (result, error) in
            if result != "" {
                if let ses = StudentClient.sharedInstance().sessionID {
                    dispatch_async(dispatch_get_main_queue(), {
                        var nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarC") as! UITabBarController
                        self.presentViewController(nextVC, animated: true, completion: nil)
                    })
                  
                }
            } else {
                println(error)
            }
            
        }
    }
    
    func configureGradientBackground(colors:CGColorRef...){
        
        let gradient: CAGradientLayer = CAGradientLayer()
        let maxWidth = max(self.view.bounds.size.height,self.view.bounds.size.width)
        let squareFrame = CGRect(origin: self.view.bounds.origin, size: CGSizeMake(maxWidth, maxWidth))
        gradient.frame = squareFrame
        
        gradient.colors = colors
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    
    

}
