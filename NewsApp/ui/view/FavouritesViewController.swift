//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit
import RxSwift

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    @IBOutlet weak var loadingView: UIView!{
        didSet {
          loadingView.layer.cornerRadius = 6
        }
      }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var newsList = [NewEntity]()
    var newsRepository = NewsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
        
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        
        newsRepository.getFavourites()
        newsRepository.newsList.subscribe(onNext: { list in
            self.newsList = list
            self.favouritesCollectionView.reloadData()
        })
        
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? NewsCollectionViewCell {
            cell.cellImage.image = UIImage(named: newsList[indexPath.row].urlToImage ?? "SliderPictureOne")
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
