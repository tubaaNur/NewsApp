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
    
    @IBOutlet weak var loadingView: UIView!{
        didSet {
          loadingView.layer.cornerRadius = 6
        }
      }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var favourite: UIBarButtonItem!
    
    var newsDetail: DetailUIModel?
    var newsRepository = NewsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (newsDetail?.isFavourite == true){
            favourite.tintColor = .red
        }
        
        if let n = newsDetail{
            detailTitle.text = n.title
            if let url = URL(string: n.urlToImage ?? "https://resize.indiatvnews.com/en/resize/newbucket/730_-/2023/06/breaking-news-template-4-1687492027-1688087501.jpg"){
                let data = try? Data(contentsOf: url)
                detailImage.image = UIImage(data: data ?? Data())
             }
            
            detailDescription.text = n.description ?? "description nil"
        }
    }
    @IBAction func favouriteIconAct(_ sender: Any) {
        
        activityIndicator.startAnimating()
        loadingView.isHidden = false
       
        
        if (newsDetail?.isFavourite == true){
            newsRepository.delete(title: newsDetail?.title ?? "bbb")
            favourite.tintColor = .red
        }
        else{
            newsRepository.save(new: newsDetail ?? DetailUIModel())
            favourite.tintColor = .black
        }
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
    

    //
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        tabBarController?.tabBar.isHidden = false
//
//    }
}
