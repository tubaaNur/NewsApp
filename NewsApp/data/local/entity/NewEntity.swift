//
//  New.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import Foundation

class NewEntity{
    var id: Int?
    var title:String?
    var description:String?
    var urlToImage:String?
    var isFavourite:Bool?
    var urlToNews:String?
    
    init(){
        
    }
    
    init(id: Int? = nil, title: String? = nil,  description: String? = nil,urlToImage: String? = nil, isFavourite: Bool? = nil, urlToNews:String? = nil ) {
        self.id = id
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
        self.isFavourite = isFavourite
        self.urlToNews = urlToNews
    }
}



