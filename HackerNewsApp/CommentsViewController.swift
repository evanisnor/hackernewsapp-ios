//
//  CommentsViewController.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit

class CommentsViewController: UITableViewController {

    var story: HackerNewsItem?
    var comments: [HackerNewsItem]?
    
    let attributedOptions : [String: AnyObject] = [
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.story = (self.parentViewController as! StoryDetailController).story
        
        if (self.comments == nil) {
            self.comments = [HackerNewsItem]()
            fetchComments()
        }
    }
    
    // MARK: - Private helpers
    
    func fetchComments () {
        HackerNewsAPI().fetchEachKid(self.story!, kidResult: { kid in
            dispatch_async(dispatch_get_main_queue(),{
                self.appendCommentToTable(kid!)
            })
        })
    }
    
    func appendCommentToTable (comment: HackerNewsItem) {
        self.comments?.append(comment)
        self.tableView.beginUpdates()
        self.tableView.insertRowsAtIndexPaths(
            [NSIndexPath(forRow: self.tableView.numberOfRowsInSection(0), inSection: 0)],
            withRowAnimation: .Automatic)
        self.tableView.endUpdates()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments == nil ? 0 : (self.comments?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as! CommentCell
        let comment = (self.comments?[indexPath.row])!
        let content = comment.text ?? "Comment not found" as NSString
        
        cell.postedBy!.text = String(format: "%@  |  %@",
            comment.by ?? "unknown",
            DateUtil.timeAgoSinceDate(comment.time, numericDates: true))
        
        do {
            let attributedComment = try NSMutableAttributedString(
                data: content.dataUsingEncoding(NSUTF8StringEncoding)!,
                options: attributedOptions,
                documentAttributes: nil)
            
            content.enumerateSubstringsInRange(NSMakeRange(0, attributedComment.length), options: .ByWords, usingBlock: {
                (substring, substringRange, _, _) in
                attributedComment.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: substringRange)
                cell.commentText!.attributedText = attributedComment
            })
        }
        catch let error as NSError {
            print(error)
        }

        return cell
    }


}
