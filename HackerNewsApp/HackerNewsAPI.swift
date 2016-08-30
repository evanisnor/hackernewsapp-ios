//
//  HackerNewsAPI.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/29/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ManyItemsResult = ([HackerNewsItem]?) -> Void
typealias SingleItemResult = (HackerNewsItem?) -> Void

class HackerNewsAPI {
    
    let fetchLimit = 20
    let topStoriesUrl = "https://hacker-news.firebaseio.com/v0/topstories.json"
    let itemUrl = "https://hacker-news.firebaseio.com/v0/item/"
    
    func fetchItemById(id: Int, itemResult : SingleItemResult) {
        let specificItemUrl = itemUrl + String(id) + ".json"
        HttpRequest.makeHttpGetRequest(specificItemUrl,
            onResult: { statusCode, json in
                print(String(format:"Retrieved HN Item by ID (%d) - Status: %d", id, statusCode ?? 0))
                itemResult(HackerNewsItemSerializer.parse(json))
            },
            onError: { statusCode, error in
                print(String(format:"Failed to retrieve HN Item by ID (%d) - Status: %d - Error: %@", id, statusCode ?? 0, error))
        })
    }

    func fetchEachTopStory(topStoryResult: SingleItemResult) {
        HttpRequest.makeHttpGetRequest(topStoriesUrl,
            onResult: { statusCode, data in
                print(String(format:"Retrieved HN Top Stories - Status: %d", statusCode ?? 0))
                
                func acquire(itemId: Int) {
                    self.fetchItemById(itemId, itemResult: { item in
                        topStoryResult(item!)
                    })
                }
                
                var currentItem = 0
                while (currentItem < self.fetchLimit && currentItem++ < data.count - 1) {
                    let itemId = data[currentItem].int!
                    acquire(itemId)
                }
            },
            onError: { statusCode, error in
                print(String(format:"Failed to retrieve HN Top Stories - Status: %d - Error: %@", statusCode ?? 0, error))
        })
    }
    
    func fetchEachKid (item: HackerNewsItem, kidResult: SingleItemResult) {
        func acquire(itemId: Int) {
            self.fetchItemById(itemId, itemResult: { item in
                kidResult(item!)
            })
        }
        
        var currentItem = 0
        while (currentItem < self.fetchLimit && currentItem++ < item.kids.count - 1) {
            acquire(item.kids[currentItem])
        }
    }
    
}