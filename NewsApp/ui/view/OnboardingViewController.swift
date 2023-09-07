//
//  OnboardingViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 5.09.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    var sliderImageList = ["SliderPictureOne","SliderPictureTwo","SliderPictureThree"]
    var sliderTitleList = ["slider","slider2","slider3","slider4","slider5","slider6"]
    var sliderDescriptionList = ["slider","slider2","slider3","slider4","slider5","slider6"]

    var currentCellIndex = 0
    var timer = Timer()
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext),userInfo: nil,repeats: true)
        pageControl.numberOfPages = sliderImageList.count
    }
    
    @objc func slideToNext()
    {
        if currentCellIndex < sliderImageList.count-1
        {
            currentCellIndex = currentCellIndex+1
        }
        else{
            currentCellIndex = 0
        }
        pageControl.currentPage = currentCellIndex
        sliderCollectionView.isPagingEnabled = false
        self.sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
        sliderCollectionView.isPagingEnabled = true
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? OnboardingCollectionViewCell {
                cell.sliderImage.image = UIImage(named: sliderImageList[indexPath.row])
                cell.sliderImage.layer.cornerRadius = 10
            cell.sliderTitle.text = sliderTitleList[indexPath.row]
            cell.sliderDescription.text = sliderDescriptionList[indexPath.row]
                return cell
            }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollectionView.frame.width, height: sliderCollectionView.frame.height)
    }
}


