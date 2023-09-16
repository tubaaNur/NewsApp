//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit
import Alamofire
import RxSwift

class NewsPageViewController: UIViewController,UISearchBarDelegate {
    
    
    @IBOutlet weak var loadingView: UIView!{
        didSet {
          loadingView.layer.cornerRadius = 6
        }
      }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var popularNewStack: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var newsList:[News]? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
        self.tabBarController?.tabBar.isHidden = false
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        searchBar.delegate = self
        
        var response: NewsResponse? = nil
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        Task {
            response = await getNews()
            activityIndicator.stopAnimating()
            loadingView.isHidden = true
            newsList = response?.articles
            self.newsCollectionView.reloadData()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            Task {
                let response = await getSearchNews(query: query)
                newsList = response?.articles
                self.newsCollectionView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func  getSearchNews(query:String) async -> NewsResponse? {
        //f56bbdad8be940a88c037582ed7c5ff8
        let response = await   AF.request("https://newsapi.org/v2/top-headlines?country=tr&q=\(query)&apiKey=f56bbdad8be940a88c037582ed7c5ff8", method:.get)
            .validate()
        // Automatic Decodable support with background parsing.
        .serializingDecodable(NewsResponse.self)
        // Await the full response with metrics and a parsed body.
        .response
        
        return response.value
    }
//    
//    func copyDB(){
//        let bundlePath = Bundle.main.path(forResource: "news", ofType: ".sqlite")
//        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        let dbUrl = URL(fileURLWithPath: filePath).appendingPathComponent("news.sqlite")
//        let fm = FileManager.default
//        
//        if fm.fileExists(atPath: dbUrl.path()){
//            print("Veritabanı zaten var")
//        }
//        else{
//            do {
//                try fm.copyItem(atPath: bundlePath!, toPath: dbUrl.path)
//            }
//            catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
}

    
extension NewsPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        return newsList?.count ??  0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell {
            
            let news = newsList?[indexPath.row]

            cell.cellImage.image = UIImage(named: news?.urlToImage ?? "SliderPictureOne")
            cell.cellImage.layer.cornerRadius = 10
            cell.cellTitle.text = news?.title ?? "title nil"
            cell.cellDescription.text = news?.description ?? "description nil"
            
            return cell
        }
        return UICollectionViewCell()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: newsCollectionView.frame.width, height: newsCollectionView.frame.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = newsList?[indexPath.row]
        performSegue(withIdentifier: "toNew", sender: news)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNew" {
            if let news = sender as? News{
                let goToVc = segue.destination as! NewDetailViewController
                goToVc.news = news
            }
        }
    }
}




