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
    
    var news: News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tabBarController?.tabBar.isHidden = true
        
        if let n = news{
            detailTitle.text = n.title
            detailImage.image = UIImage(named: n.urlToImage ?? "SliderPictureOne")
            detailDescription.text = n.description ?? "description nil"
         
        }
    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = false
//
//    }
}
