//
//  New.swift
//  NewsApp
//
//  Created by Tuba Nur  on 10.09.2023.
//

import Foundation

class New{
    var id: Int?
    var title:String?
    var urlToImage:String?
    var description:String?
    var isFavourite:Bool?
    var urlToNews:String?
    init(){
        
    }
    init(id: Int? = nil, title: String? = nil, urlToImage: String? = nil, description: String? = nil, isFavourite: Bool? = nil, urlToNews:String? = nil ) {
        self.id = id
        self.title = title
        self.urlToImage = urlToImage
        self.description = description
        self.isFavourite = isFavourite
        self.urlToNews = urlToNews
    }
}



