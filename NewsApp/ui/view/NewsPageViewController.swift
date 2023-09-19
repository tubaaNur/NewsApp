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
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var loadingView: UIView!{
        didSet {
          loadingView.layer.cornerRadius = 6
        }
      }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var popularNewStack: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var popularHeader: UILabel!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    @IBOutlet weak var popularNewImage: UIImageView!
    @IBOutlet weak var popularNewTitle: UILabel!
    @IBOutlet weak var popularNewDescription: UITextView!
    
    var newsList:[News]? = nil
    var randomItem:News? = nil

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
                 
            print("popular header \(popularHeader.text)")
            randomItem = newsList?.randomElement()
           if let url = URL(string: randomItem?.urlToImage ?? "https://resize.indiatvnews.com/en/resize/newbucket/730_-/2023/06/breaking-news-template-4-1687492027-1688087501.jpg"){
                let data = try? Data(contentsOf: url)
               popularNewImage.image  = UIImage(data: data ?? Data())
             }
            popularNewTitle.text = randomItem?.title
            popularNewDescription.text = randomItem?.description
            self.newsCollectionView.reloadData()
        }
        setStackViewClickable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        popularHeader.text = defaultLocalizer.stringForKey(key: "popularNews")
    }
    
    // Populer haberi tıklanabilir yapmak için varlar
    @objc func setStackViewClickable() {
        // Create a UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(stackViewTapped))
        // Add the gesture recognizer to your UIStackView
        popularNewStack.addGestureRecognizer(tapGesture)
    }
    
    @objc func stackViewTapped() {
        performSegue(withIdentifier: "toNew", sender: randomItem)
    }
    
    func  getNews() async -> NewsResponse? {
        //f56bbdad8be940a88c037582ed7c5ff8
        let response = await   AF.request("https://newsapi.org/v2/top-headlines?country=us&apiKey=f56bbdad8be940a88c037582ed7c5ff8", method:.get)
            .validate()
        .serializingDecodable(NewsResponse.self)
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
        let response = await   AF.request("https://newsapi.org/v2/top-headlines?country=us&q=\(query)&apiKey=f56bbdad8be940a88c037582ed7c5ff8", method:.get)
            .validate()
        .serializingDecodable(NewsResponse.self)
        .response
        
        return response.value
    }
}

    
extension NewsPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           
        return newsList?.count ??  0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell {
        
            let news = newsList?[indexPath.row]
            
            if let url = URL(string: news?.urlToImage ?? "https://resize.indiatvnews.com/en/resize/newbucket/730_-/2023/06/breaking-news-template-4-1687492027-1688087501.jpg"){
               let data = try? Data(contentsOf: url)
               cell.cellImage.image = UIImage(data: data ?? Data())
            }
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
            var newsDetail:DetailUIModel? = nil
            if let news = sender as? News{
               newsDetail = DetailUIModel(id: nil, title: news.title, urlToImage: news.urlToImage, description: news.description, isFavourite: news.isFavourite, urlToNews: news.url)
            }
                let goToVc = segue.destination as! NewDetailViewController
                goToVc.newsDetail = newsDetail
        }
    }
}




