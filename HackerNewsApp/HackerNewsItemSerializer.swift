//
//  HackerNewsItemSerializer.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/29/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import Foundation
import SwiftyJSON

class HackerNewsItemSerializer {
    
    static func parse (data: JSON) -> HackerNewsItem {
        return HackerNewsItem(
            id: data["id"].int!,
            deleted: data["deleted"].bool,
            type: HackerNewsItemType.parse(data["type"].string!)!,
            by: data["by"].string,
            time: NSDate(timeIntervalSince1970: data["time"].double!),
            text: data["text"].string,
            dead: data["dead"].bool,
            parent: data["parent"].int,
            kids: parseIntArray(data["kids"]),
            url: data["url"].string,
            score: data["score"].int,
            title: data["title"].string,
            parts: parseIntArray(data["parts"]),
            numberOfDescendants: data["decendants"].int
        )
    }
    
    static func parseIntArray (valuesAsJSON: JSON) -> [Int] {
        var valuesAsInts = [Int]()
        for (_,value):(String, JSON) in valuesAsJSON {
            valuesAsInts.append(value.int!)
        }
        return valuesAsInts
    }

}