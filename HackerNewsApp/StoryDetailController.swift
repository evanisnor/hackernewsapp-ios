//
//  StoryDetailController.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit

class StoryDetailController: UITabBarController {
    
    var story: HackerNewsItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.story?.title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
