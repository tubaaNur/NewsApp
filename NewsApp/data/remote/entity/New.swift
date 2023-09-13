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
    var image:String?
    var description:String?
    init(){
        
    }
    init(id: Int? = nil, title: String? = nil, image: String? = nil, description: String? = nil) {
        self.id = id
        self.title = title
        self.image = image
        self.description = description
    }
}



