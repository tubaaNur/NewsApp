//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileViewLanguage: UIView!
    @IBOutlet weak var profileview: UIView!
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
         
            let email = user.email

            let defaultProfileImage = UIImage(named: "SliderPictureOne")
            profileImage?.image = defaultProfileImage
            userEmail.text = email
            profileview.layer.borderWidth = 0.4
            profileview.layer.borderColor = UIColor.lightGray.cgColor
            profileview.layer.cornerRadius = 15
            
            profileViewLanguage.layer.borderWidth = 0.4
            profileViewLanguage.layer.borderColor = UIColor.lightGray.cgColor
            profileViewLanguage.layer.cornerRadius = 15
        }
    }
    
    @IBAction func logOutAction(_ sender: Any) {
               do {
                   print("Before: \(Auth.auth().currentUser)")
                   try Auth.auth().signOut()
                   print("After: \(Auth.auth().currentUser)")
                   
                   var storyboardName = "Main"
                   let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                   let intialVC = storyboard.instantiateInitialViewController()
                   if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                       sceneDelegate.window?.rootViewController = intialVC
                   }
               }
               catch { print("User already logged out") }
    }
}
