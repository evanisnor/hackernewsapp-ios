//
//  HackerNewsItemType.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/29/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import Foundation

enum HackerNewsItemType : String {
    case
    Job = "job",
    Story = "story",
    Comment = "comment",
    Poll = "poll",
    PollOpt = "pollopt"
    
    static let allValues = [ Job, Story, Comment, Poll, PollOpt ]
    
    static func parse (value: String) -> HackerNewsItemType? {
        switch (value) {
        case Job.rawValue:
            return Job
        case Story.rawValue:
            return Story
        case Comment.rawValue:
            return Comment
        case Poll.rawValue:
            return Poll
        case PollOpt.rawValue:
            return PollOpt
        default:
            return nil
        }
    }
}
