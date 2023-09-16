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
                let title = result.string(forColumn: "title")
                let urlToImage = result.string(forColumn: "urlToImage")
                let description = result.string(forColumn: "description")
                let isFavourite = result.bool(forColumn: "isFavourite")
                let urlToNews = result.string(forColumn: "urlToNews")
    
                let new = NewEntity(id: id, title: title, description: description, urlToImage: urlToImage, isFavourite: isFavourite, urlToNews:urlToNews)
                list.append(new)
            }
            newsList.onNext(list)
        }
        catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
 
    func save(new:DetailUIModel) {
        var entityModel = NewEntity(id: new.id, title: new.title, description: new.description, urlToImage: new.urlToImage, isFavourite: new.isFavourite, urlToNews: new.urlToNews)
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO new (title, description,urlToImage, isFavourite, urlToNews) VALUES (?,?,?,?,?)", values: [entityModel.title,entityModel.description, entityModel.urlToImage, entityModel.isFavourite, entityModel.urlToNews])
        }
        catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func delete(title: String){
        
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM new WHERE title = ?", values: [title])
        }
        catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
}
