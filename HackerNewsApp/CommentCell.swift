//
//  CommentCell.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var postedBy: UILabel!
    @IBOutlet weak var commentText: UITextView!
    
    let attributedOptions : [String: AnyObject] = [
        NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
        NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
    ]
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commentText!.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setAttributedHtmlText (text: NSString) {
        do {
            let attributedComment = try NSMutableAttributedString(
                data: text.dataUsingEncoding(NSUTF8StringEncoding)!,
                options: attributedOptions,
                documentAttributes: nil)
            
            text.enumerateSubstringsInRange(NSMakeRange(0, attributedComment.length), options: .Reverse, usingBlock: {
                (substring, substringRange, _, _) in
                attributedComment.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12), range: substringRange)
                self.commentText!.attributedText = attributedComment
            })
        }
        catch let error as NSError {
            print(error)
        }
    }
    
}
