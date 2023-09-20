//
//  ForgatPasswordViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 8.09.2023.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var resetPassword: UIButton!
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
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeLabel.text = defaultLocalizer.stringForKey(key: "welcomeLabel")
        
        let localizedReset = defaultLocalizer.stringForKey(key:  "resetPassword")
        resetPassword.setTitle(localizedReset, for: .normal)
        
        email.placeholder = defaultLocalizer.stringForKey(key: "emailText")
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
}
