//
//  TopStoriesViewController.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit

class TopStoriesViewController: UITableViewController {
    
    var topStories: [HackerNewsItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        
        if (topStories == nil) {
            topStories = [HackerNewsItem]()
            self.fetchTopStories()
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let detailView = segue.destinationViewController as! StoryDetailController
        detailView.story = self.topStories![self.tableView.indexPathForSelectedRow!.row]
    }
    
    // MARK: - Private helpers
    
    func fetchTopStories () {
        HackerNewsAPI().fetchEachTopStory({ story in
            dispatch_async(dispatch_get_main_queue(),{
                self.appendStoryToTable(story!)
            })
        })
    }
    
    func appendStoryToTable (story: HackerNewsItem) {
        self.topStories?.append(story)
        self.tableView.beginUpdates()
        self.tableView.insertRowsAtIndexPaths(
            [NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0), inSection: 0)],
            withRowAnimation: .Automatic)
        self.tableView.endUpdates()

    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topStories == nil ? 0 : (self.topStories?.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopStoryCell") as! TopStoryCell
        let story = (self.topStories?[indexPath.row])!
        cell.storyTitle!.text = story.title
        cell.postedBy!.text = String(format: "%d points by %@ %@  |  %d comments",
            story.score ?? 0,
            story.by ?? "unknown",
            DateUtil.timeAgoSinceDate(story.time, numericDates: true),
            story.kids.count)
        return cell
    }
}
