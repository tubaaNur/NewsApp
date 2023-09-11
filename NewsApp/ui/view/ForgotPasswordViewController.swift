//
//  ForgatPasswordViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 8.09.2023.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: email.text ?? "" ) { (error) in
                  if let error = error {
                     print("Mail couldn't send")
                  } else {
                      print("Mail send")
                    
                  }
              }
    }
    
}
