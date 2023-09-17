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
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var window: UIWindow?
    weak var themeDelegate: ThemeChangeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        var darkModeSelected = UserDefaults.standard.bool(forKey: "isDarkModeSelected")
        darkModeSwitch.setOn(darkModeSelected, animated: false)
       
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
    @IBAction func darkModeSwitch(_ sender: Any) {
        if darkModeSwitch.isOn {
            changeThemeTo("Light")
        }
        else{
            changeThemeTo("Dark")
        }
    }
    
    func changeThemeTo(_ theme: String) {
        themeDelegate?.didChangeTheme(theme: theme)
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
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
