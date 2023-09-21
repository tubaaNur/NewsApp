//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Tuba Nur  on 5.09.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate,ThemeChangeDelegate {
    
    
    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    var window: UIWindow?
    var theme: String = "Light"
    
    func didChangeTheme(theme: String) {
        if (theme == "Dark") {
            window?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.set(false, forKey: "isDarkModeSelected")
          }
          else{
          window?.overrideUserInterfaceStyle = .dark
         UserDefaults.standard.set(true, forKey: "isDarkModeSelected")
          }
    }
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        defaultLocalizer.setSelectedLanguage(lang: UserDefaults.standard.string(forKey: "SelectedLanguage") ?? "en")
        var darkModeSelected = UserDefaults.standard.bool(forKey: "isDarkModeSelected")
        if(darkModeSelected == true){
            window?.overrideUserInterfaceStyle = .dark
        } else{
            window?.overrideUserInterfaceStyle = .light
            }
        var storyboardName = "Main"
        if Auth.auth().currentUser != nil {
            storyboardName = "NewsStoryboard"
        }
        else {
            storyboardName = "Main"
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let intialVC = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = intialVC
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

