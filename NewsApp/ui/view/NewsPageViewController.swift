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
    
    var newsList = [New(id: 1,title: "tuba",image: "SliderPictureOne",description: "a"),New(id: 2,title: "başar",image: "SliderPictureTwo",description: "a"),New(id: 3,title: "tubababb",image: "SliderPictureThree",description: "bb")]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    
        
        setStackViewClickable()
        
        
    }
    
    @objc func setStackViewClickable() {
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
           
            return newsList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell {
                cell.cellImage.image = UIImage(named: newsList[indexPath.row].image ?? "a")
                    cell.cellImage.layer.cornerRadius = 10
                cell.cellTitle.text = newsList[indexPath.row].title
                cell.cellDescription.text = newsList[indexPath.row].description
                    return cell
                }
            return UICollectionViewCell()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: newsCollectionView.frame.width, height: newsCollectionView.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let news = newsList[indexPath.row]
            performSegue(withIdentifier: "toNew", sender: news)

        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toNew" {
                if let new = sender as? New{
                    
                    let goToVc = segue.destination as! NewDetailViewController
                    goToVc.new = new
                }
            }
        }
    }

