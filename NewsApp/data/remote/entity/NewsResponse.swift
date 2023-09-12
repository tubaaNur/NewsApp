//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Tuba Nur  on 12.09.2023.
//

import Foundation

struct NewsResponse: Decodable{
    
    let articles : [News]?
    let status: String?
    let totalResults: Int?
}

struct News: Decodable{
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    
    let source : Sources?
}

struct Sources: Decodable{
    let id: String?
    let name: String?
}

