//
//  News.swift
//  NewsApp
//
//  Created by Phyo Thinzar Aung on 11/18/18.
//  Copyright © 2018 padc. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class News : Object{
    @objc dynamic var id = UUID.init().uuidString
    @objc dynamic var author = ""
    @objc dynamic var title = ""
    @objc dynamic var desc = ""
    @objc dynamic var url = ""
    @objc dynamic var urlToImage = ""
    @objc dynamic var publishedAt = ""
    @objc dynamic var content = ""
    
    convenience init(author : String,  title : String, desc : String, url : String, urlToImage : String, publishedAt : String, content : String ){
        self.init()
        self.author = author
        self.title = title
        self.desc = desc
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    static func parseToNews (_ data : JSON) -> News {
        let news = News()
        news.author = data["author"].string ?? ""
        news.title = data["title"].string ?? ""
        news.desc = data["description"].string ?? ""
        news.url = data["url"].string ?? ""
        news.urlToImage = data["urlToImage"].string ?? ""
        news.publishedAt = data["publishedAt"].string ?? ""
        news.content = data["content"].string ?? ""
        return news
    }
}
