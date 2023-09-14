//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Tuba Nur  on 14.09.2023.
//

import Foundation
import RxSwift

class NewsRepository{
    
    var newsList = BehaviorSubject<[New]>(value: [New]())
    
    let db:FMDatabase?
    
    init(){
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbUrl = URL(fileURLWithPath: filePath).appendingPathComponent("newsApp.sqlite")
        db = FMDatabase(path: dbUrl.path)
    }
    
    func getFavourites(){
        
        db?.open()
        
        var list = [New]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM news WHERE isFavourite = 'true'", values: nil)
            
            while result.next(){
                
                let id = Int(result.string(forColumn: "id"))!
                let title = result.string(forColumn: "title")!
                let urlToImage = result.string(forColumn: "urlToImage")!
                let description = result.string(forColumn: "description")!
                let isFavourite = result.bool(forColumn: "isFavourite")
                let urlToNews = result.string(forColumn: "urlToNews")!
            
                
                let new = New(id: id, title: title, urlToImage: urlToImage, description: description, isFavourite: isFavourite, urlToNews:urlToNews)
                list.append(new)
                
            }
            
            newsList.onNext(list)//Tetikleme
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }

}
