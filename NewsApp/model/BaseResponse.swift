//
//  BaseResponse.swift
//  NewsApp
//
//  Created by Phyo Thinzar Aung on 11/12/18.
//  Copyright © 2018 padc. All rights reserved.
//

import Foundation

class BaseResponse: Codable {
    var status : String
    var totalResults : Int64
    var articles : [ArticleModel] = []
}
