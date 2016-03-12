//
//  TextCardTableCell.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/12.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class TextCardTableCell: UITableViewCell {
    
    var cardId: String? = ""
    var captionLabel: UILabel!
    var contentLabel: UILabel!
    
    var initSwitch: Bool = false;
    var initBoundWidth: CGFloat = 0;
    var initBoundHeight: CGFloat = 0;
    
    // caption info
    var captionLeft: Int = 30;
    var captionTop: Int = 60;
    var captionWidth: Int = 150;
    var captionHeight: Int = 44;
    var captionFontName: String = "TrebuchetMS-Bold";
    var captionFontSize: CGFloat = 18;
    
    // content size info
    var contentLeft: Int = 30;
    var contentTop: Int = 10;
    var contentWidth: Int = 150;
    var contentHeight: Int = 66;
    var contentFontName: String = "HelveticaNeue-Thin";
    var contentFontSize: CGFloat = 16;
    
    // table cell info
    var cellRightMargin: CGFloat = 4;
    var cellLeftMargin: CGFloat = 10;
    var cellBottomMargin: CGFloat = 2.5;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        captionLabel = UILabel(frame: CGRect(x: captionLeft, y: captionTop, width: captionWidth, height: captionHeight));
        captionLabel.textColor = UIColor.whiteColor();
        captionLabel.font = UIFont(name: captionFontName, size: captionFontSize)
        self.contentView.addSubview(captionLabel);
        
        contentLabel = UILabel(frame: CGRect(x: contentLeft, y: contentTop, width: captionWidth, height: captionHeight));
        contentLabel.lineBreakMode = .ByWordWrapping
        contentLabel.numberOfLines = 2
        contentLabel.font = UIFont(name: contentFontName, size: contentFontSize)
        contentLabel.textColor = UIColor.whiteColor()
        self.contentView.addSubview(contentLabel);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.contentView.backgroundColor = UIColor(colorNamed: DCColor.cardBackgroundColor)
        self.contentView.alpha = 0.9
        captionLabel.text = "待办记事"
        contentLabel.text = "通知相关企业，27日10时联系赵晨晨，56878542"
        
        contentView.contentMode = .ScaleAspectFill
        contentView.layer.masksToBounds = true
        
        let origX = self.frame.origin.x;
        let origY = self.frame.origin.y;
        
        if (initSwitch == false) {
            initBoundWidth = self.bounds.size.width;
            initBoundHeight = self.bounds.size.height;
            
            self.contentMode = .ScaleAspectFill
            self.layer.masksToBounds = true;
            self.frame = CGRectMake(origX, origY, initBoundWidth - cellRightMargin, initBoundHeight - cellBottomMargin);
            
            initSwitch = true;
        }
        
        contentView.frame = CGRectMake(cellLeftMargin, 0, initBoundWidth - (cellLeftMargin + cellRightMargin), initBoundHeight - cellBottomMargin)
    }
}

