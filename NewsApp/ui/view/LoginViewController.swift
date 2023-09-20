//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 7.09.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController{
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        do {
            try Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (result, error) in
                if let error = error{
                    print("Sign in failed: \(error.localizedDescription)")
                    
                } else {
                    print("User signed in successfully")
                    
                    var storyboardName = "NewsStoryboard"
                    
                    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                    
                    let intialVC = storyboard.instantiateInitialViewController()
                    
                    if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = intialVC
                    }
                    self.performSegue(withIdentifier: "toNewStoryboard", sender: nil)
                }
            }
        }
            catch { print("User already logged out") }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeLabel.text = defaultLocalizer.stringForKey(key: "welcomeLabel")
        
        let localizedForgat = defaultLocalizer.stringForKey(key: "forgatButton")
        forgatButton.setTitle(localizedForgat, for: .normal)
        
        let localizedLogin = defaultLocalizer.stringForKey(key: "loginButton")
        loginButton.setTitle(localizedLogin, for: .normal)
        emailTextField.placeholder = defaultLocalizer.stringForKey(key: "emailText")
        passwordTextField.placeholder = defaultLocalizer.stringForKey(key: "passwordText")
        let localizedRegister = defaultLocalizer.stringForKey(key:  "registerButton")
        registerButton.setTitle(localizedRegister, for: .normal)
    }
      
        
    }

