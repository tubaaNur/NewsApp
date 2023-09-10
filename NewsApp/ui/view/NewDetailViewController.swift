//
//  NewDetailViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit

class NewDetailViewController: UIViewController {

    @IBOutlet weak var detailDescription: UITextView!

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    
    var new: New?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        if let n = new{
            detailTitle.text = n.title
            detailImage.image = UIImage(named: n.image!)
            detailDescription.text = n.description
         
        }
    }
}
