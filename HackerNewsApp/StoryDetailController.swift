//
//  StoryDetailController.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit
import SafariServices

class StoryDetailController: UITabBarController {
    
    var story: HackerNewsItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.story?.title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.tabBar.translucent = false
    }
    
}
