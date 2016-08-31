//
//  SafariNavigationViewController.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit
import SafariServices

class SafariNavigationViewController: UINavigationController {
    
    var story: HackerNewsItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.story = (self.parentViewController as! StoryDetailController).story
        
        let safariView = SFSafariViewController(URL: NSURL(string: self.story!.url!)!, entersReaderIfAvailable: true)
        safariView.title = self.title
        addChildViewController(safariView)
    }

}
