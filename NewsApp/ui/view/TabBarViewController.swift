//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 17.09.2023.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // tell our UITabBarController subclass to handle its own delegate methods
        self.delegate = self
    }

    // called whenever a tab button is tapped
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//if let firstVC = viewController as? FirstViewController {
//            firstVC.doSomeAction()
//        }
//
//        if viewController is FirstViewController {
//            print("First tab")
//        } else if viewController is SecondViewController {
//            print("Second tab")
//        }
//    }

    // alternate method if you need the tab bar item
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        // ...
//    }
}
