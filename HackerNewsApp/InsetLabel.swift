//
//  InsetLabel.swift
//  HackerNewsApp
//
//  Created by Evan Isnor on 8/30/16.
//  Copyright © 2016 Evan Isnor. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {

    override func drawRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)))
    }

}
