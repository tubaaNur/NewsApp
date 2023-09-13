//
//  FavouritesViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var favouritesCollectionView: UICollectionView!
    
    var newsList = [New(id: 1,title: "tuba",image: "SliderPictureOne",description: "a"),New(id: 2,title: "başar",image: "SliderPictureTwo",description: "a"),New(id: 3,title: "tubababb",image: "SliderPictureThree",description: "bb")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self

    }
}

extension FavouritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        return CGSize(width: favouritesCollectionView.frame.width, height: favouritesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: news)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toDetail" {
//            if let new = sender as? New{
//                let goToVc = segue.destination as! NewDetailViewController
//                goToVc.new = new
//            }
//        }
    }
}
