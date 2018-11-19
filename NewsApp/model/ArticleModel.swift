//
//  ArticleModel.swift
//  NewsApp
//
//  Created by Phyo Thinzar Aung on 11/12/18.
//  Copyright © 2018 padc. All rights reserved.
//

import Foundation
import SwiftyJSON

class ArticleModel: Codable {
    
    var author : String? = nil
    
    var title : String? = nil
    
    var description : String? = nil
    
    var url : String? = nil
    
    var urlToImage : String? = nil
    
    var publishedAt : String? = nil
    
    var content : String? = nil
    
    static func parseToNews (_ data : JSON) -> ArticleModel {
        let news = ArticleModel()
        news.author = data["author"].string
        news.title = data["title"].string
        news.description = data["description"].string
        news.url = data["url"].string
        news.urlToImage = data["urlToImage"].string
        news.publishedAt = data["publishedAt"].string
        news.content = data["content"].string
        return news
    }
    
}
