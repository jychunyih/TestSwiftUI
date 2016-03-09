//
//  Card.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import Foundation

enum CardType: Int {
    case None = 0
    case Text = 1
    case Image = 2
}

class Card {
    var Id: String? = "";
    var Type: CardType = CardType.None;
    var Caption: String? = "";
    var MediaContent: String? = "";
    var CreateTime: NSDate? = nil;
    
    init(id: String?, type: CardType, caption: String?, mediaContent: String?) {
        self.Id = id;
        self.Type = type;
        self.Caption = caption;
        self.MediaContent = mediaContent;
        self.CreateTime = NSDate();
    }
}