//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit
import RxSwift

class FavouritesViewController: UIViewController {

    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    @IBOutlet weak var loadingView: UIView!{
        didSet {
          loadingView.layer.cornerRadius = 6
        }
      }
    @IBOutlet weak var favouritesTitle: UINavigationItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsList = [NewEntity]()
    var newsRepository = NewsRepository()
    
    override func viewDidLoad() {
        
       
        super.viewDidLoad()
        
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        
        newsRepository.getFavourites()
        newsRepository.newsList.subscribe(onNext: { list in
            self.newsList = list
            self.favouritesCollectionView.reloadData()
        })
        
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
        
        favouritesTitle.title = defaultLocalizer.stringForKey(key: "favouritesLabel")
    }
       
}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell {
            
            if let url = URL(string:newsList[indexPath.row].urlToImage ?? "https://resize.indiatvnews.com/en/resize/newbucket/730_-/2023/06/breaking-news-template-4-1687492027-1688087501.jpg"){
                let data = try? Data(contentsOf: url)
                cell.cellImage.image = UIImage(data: data ?? Data())
             }
            
            cell.cellImage.layer.cornerRadius = 10
            cell.cellTitle.text = newsList[indexPath.row].title ?? "tubaaa"
            cell.cellDescription.text = newsList[indexPath.row].description ?? "başarım"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: favouritesCollectionView.frame.width, height: favouritesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: news)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let newsEntity = sender as? NewEntity{
                let newsDetail = DetailUIModel(id: newsEntity.id, title: newsEntity.title, urlToImage: newsEntity.urlToImage, description: newsEntity.description, isFavourite: newsEntity.isFavourite, urlToNews: newsEntity.urlToNews )
                let goToVc = segue.destination as! NewDetailViewController
                goToVc.newsDetail = newsDetail
            }
        }
    }
    

}
