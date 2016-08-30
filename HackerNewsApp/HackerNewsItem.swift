//
//  HackerNewsItem.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/29/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import Foundation

struct HackerNewsItem {
    
    var id: Int
    var deleted: Bool?
    var type: HackerNewsItemType
    var by: String?
    var time: NSDate
    var text: String?
    var dead: Bool?
    var parent: Int?
    var kids: [Int]
    var url: String?
    var score: Int?
    var title: String?
    var parts: [Int]
    var numberOfDescendants: Int?
    
}
