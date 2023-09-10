//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 7.09.2023.
//

import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
    @IBAction func loginButtonClick(_ sender: Any) {
        var storyboardName = "NewsStoryboard"

        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)

        let intialVC = storyboard.instantiateInitialViewController()
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = intialVC
        }
    }
    
}
