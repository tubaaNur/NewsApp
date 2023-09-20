//
//  SignUpViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 7.09.2023.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var eMail: UITextField!
    
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var signLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        signLabel.text = defaultLocalizer.stringForKey(key: "signLabel")
        
        let localizedSign = defaultLocalizer.stringForKey(key: "signButton")
        signButton.setTitle(localizedSign, for: .normal)
        
        eMail.placeholder = defaultLocalizer.stringForKey(key: "emailText")
        password.placeholder = defaultLocalizer.stringForKey(key: "passwordText")
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
}
