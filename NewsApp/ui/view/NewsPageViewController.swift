//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit
import Alamofire

class NewsPageViewController: UIViewController {
    
    @IBOutlet weak var popularNewStack: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var newsList = [New(id: 1,title: "tuba",image: "SliderPictureOne",description: "a"),New(id: 2,title: "başar",image: "SliderPictureTwo",description: "a"),New(id: 3,title: "tubababb",image: "SliderPictureThree",description: "bb")]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        var response: NewsResponse? = nil
        
        Task {
            response = await getNews()
            print(response?.articles?[0].title)
        }
        setStackViewClickable()
    }
    
    // Populer haberi tıklanabilir yapmak için varlar
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
    }
    
    func  getNews() async -> NewsResponse? {
        //f56bbdad8be940a88c037582ed7c5ff8
        let response = await   AF.request("https://newsapi.org/v2/top-headlines?country=tr&apiKey=f56bbdad8be940a88c037582ed7c5ff8", method:.get)
            .validate()
        // Automatic Decodable support with background parsing.
        .serializingDecodable(NewsResponse.self)
        // Await the full response with metrics and a parsed body.
        .response
        
        return response.value
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


