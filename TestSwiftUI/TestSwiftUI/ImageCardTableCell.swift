//
//  ImageCardTableCell.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/12.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class ImageCardTableCell: UITableViewCell {
    
    var captionLabel: UILabel!
    var contentImage: UIImageView!
    
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
        
        contentImage = UIImageView(image: UIImage(named: "cardbg_test"));
        
        self.contentView.sizeToFit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundView = contentImage;
        self.backgroundView?.contentMode = .ScaleAspectFill
        self.backgroundView?.layer.masksToBounds = true;
        
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
        self.backgroundView?.frame = self.contentView.frame;
    }
    
}
