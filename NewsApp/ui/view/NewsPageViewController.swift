//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit

class NewsPageViewController: UIViewController {

    @IBOutlet weak var popularNewStack: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStackViewClickable()

    }
    
    func setStackViewClickable() {
        // Create a UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        // Add the gesture recognizer to your UIStackView
        popularNewStack.addGestureRecognizer(tapGesture)
    }
    
    @objc func stackViewTapped() {
          // Handle the tap action here
          // You can perform your navigation to another screen here
          // For example, pushing a new view controller onto the navigation stack
//          let nextViewController = NextViewController()
//          navigationController?.pushViewController(nextViewController, animated: true)
        
        print("stacktıklandı")
      }
}
