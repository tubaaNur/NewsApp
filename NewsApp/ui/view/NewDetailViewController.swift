//
//  NewDetailViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import UIKit

class NewDetailViewController: UIViewController {
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    
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
    var isFavourited:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = true
        
        if let n = newsDetail{
            detailTitle?.text = n.title
            if let url = URL(string: n.urlToImage ?? "https://resize.indiatvnews.com/en/resize/newbucket/730_-/2023/06/breaking-news-template-4-1687492027-1688087501.jpg"){
                let data = try? Data(contentsOf: url)
                detailImage?.image = UIImage(data: data ?? Data())
            }
            detailDescription?.text = n.description ?? "description nil"
            isFavourited = n.isFavourite ?? false
            setButtonImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
    }
    func setButtonImage() {
        let imageName = isFavourited == true ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        favourite?.image = image
    }
    
    @IBAction func favouriteIconAct(_ sender: Any) {
        
        activityIndicator.startAnimating()
        loadingView.isHidden = false
        
        if (isFavourited == true){
            newsRepository.delete(title: newsDetail?.title ?? "bbb")
            isFavourited = false
            setButtonImage()
        }
        else{
            newsRepository.save(new: newsDetail ?? DetailUIModel())
            isFavourited = true
            setButtonImage()
        }
        activityIndicator.stopAnimating()
        loadingView.isHidden = true
    }
}
