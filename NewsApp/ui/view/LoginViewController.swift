//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 7.09.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (result, error) in
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
    
}
