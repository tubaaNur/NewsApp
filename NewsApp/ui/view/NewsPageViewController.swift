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
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var sliderImageList = ["SliderPictureOne","slider2","slider3","slider4","slider5","slider6"]
    var sliderTitleList = ["title1","slider2","slider3","slider4","slider5","slider6"]
    var sliderDescriptionList = ["description1","slider2","slider3","slider4","slider5","slider6"]
    
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
    
    extension NewsPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return sliderImageList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell {
                    cell.cellImage.image = UIImage(named: sliderImageList[indexPath.row])
                    cell.cellImage.layer.cornerRadius = 10
                cell.cellTitle.text = sliderTitleList[indexPath.row]
                cell.cellDescription.text = sliderDescriptionList[indexPath.row]
                    return cell
                }
            return UICollectionViewCell()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: newsCollectionView.frame.width, height: newsCollectionView.frame.height)
        }
    }

