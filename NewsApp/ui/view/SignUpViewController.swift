//
//  SignUpViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 7.09.2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var eMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func signUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: eMail.text ?? " ", password: password.text ?? " ") { authResult, error in
            if let error = error {
                print("User registration failed")
            }
            else {
                print("User created successfully")
            }
        }
    }
    
}
