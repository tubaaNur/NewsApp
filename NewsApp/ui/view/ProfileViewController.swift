//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileViewLanguage: UIView!
    @IBOutlet weak var profileview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileview.layer.borderWidth = 0.4
        profileview.layer.borderColor = UIColor.lightGray.cgColor
        profileview.layer.cornerRadius = 15
        
        
        profileViewLanguage.layer.borderWidth = 0.4
        profileViewLanguage.layer.borderColor = UIColor.lightGray.cgColor
        profileViewLanguage.layer.cornerRadius = 15
        
    }
    

    @IBAction func logOutAction(_ sender: Any) {
    }
    

}
