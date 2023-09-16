//
//  NewsRepository.swift
//  NewsApp
//
//  Created by Tuba Nur  on 14.09.2023.
//

import Foundation
import RxSwift

class NewsRepository{
    
    var newsList = BehaviorSubject<[NewEntity]>(value: [NewEntity]())
    let db:FMDatabase?
    
    init(){
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbUrl = URL(fileURLWithPath: filePath).appendingPathComponent("news.sqlite")
        db = FMDatabase(path: dbUrl.path)
    }
    
    func getFavourites() {
//        save(new:New(id: nil, title: "bbb", urlToImage: "tydfg", description: "dffgfd", isFavourite: true, urlToNews: "dfgdsfgefds"))
        db?.open()
        
        var list = [NewEntity]()
        
        do{
            let result = try db!.executeQuery("SELECT * FROM new ", values: nil)
            
            while result.next(){
                let id = Int(result.string(forColumn: "id"))!
                let title = result.string(forColumn: "title")!
                let urlToImage = result.string(forColumn: "urlToImage")!
                let description = result.string(forColumn: "description")!
                let isFavourite = result.bool(forColumn: "isFavourite")
                let urlToNews = result.string(forColumn: "urlToNews")!
    
                let new = NewEntity(id: id, title: title, urlToImage: urlToImage, description: description, isFavourite: isFavourite, urlToNews:urlToNews)
                list.append(new)
            }
            newsList.onNext(list)
        }
        catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
 
    func save(new:NewEntity) {
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO new (title, urlToImage, description, isFavourite, urlToNews) VALUES (?,?,?,?,?)", values: [new.title, new.urlToImage, new.description, new.isFavourite, new.urlToNews])
        }
        catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}
