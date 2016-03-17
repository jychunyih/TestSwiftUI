//
//  TextCardCell.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/10.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class TextCardCell: UITableViewCell {
    
    var captionLabel: UILabel!
    var contentLabel: UILabel!
    
    let captionLeftPadding: Int = 50;
    let captionTopPadding: Int = 50
    let captionHeight: Int = 40;
    
    let contentLeftPadding: Int = 50;
    let contentTopPadding: Int = 120
    let contentHeight: Int = 60;
    
    var testSwitch: Bool = false;
    var testBoundWidth: CGFloat = 0;
    var testBoundHeight: CGFloat = 0;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        let contentViewWidth = Int(self.contentView.frame.size.width);
        let contentViewHeight = Int(self.contentView.frame.size.height);
        
        captionLabel = UILabel(frame: CGRect(x: 30, y: 60, width: 150, height: 44));
        captionLabel.textColor = UIColor.whiteColor();
        captionLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 18)
        self.contentView.addSubview(captionLabel);
        
        contentLabel = UILabel(frame: CGRect(x: 30, y: 10, width: 150, height: 66));
        contentLabel.lineBreakMode = .ByWordWrapping
        contentLabel.numberOfLines = 2
        contentLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 16)
        contentLabel.textColor = UIColor.whiteColor()
        self.contentView.addSubview(contentLabel);
        
        let origX = self.frame.origin.x;
        let origY = self.frame.origin.y;
        let origWidth = self.frame.size.width;
        let origHeight = self.frame.size.height;
        
        //contentView.frame = CGRect(x: 10, y: 0, width: contentViewWidth - 20, height: contentViewHeight - 10)
        //self.frame = CGRect(x: origX + 10, y: origY, width: origWidth - 20, height: origHeight - 10)
        
        //self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width - 50, self.bounds.size.height);
        
        //self.contentView.sizeToFit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        //self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width - 50, self.bounds.size.height);
        
        super.layoutSubviews()
        //self.contentView.backgroundColor = UIColor(red: 0x00, green: 0x89, blue: 0xB5, alpha: 1);
        self.contentView.backgroundColor = UIColor.blueColor()
        self.contentView.alpha = 0.9
        captionLabel.text = "待办记事"
        contentLabel.text = "通知相关企业，27日10时联系赵晨晨，56878542"
        
        contentView.contentMode = .ScaleAspectFill
        contentView.layer.masksToBounds = true
        
        let contentViewWidth = Int(self.contentView.frame.size.width);
        let contentViewHeight = Int(self.contentView.frame.size.height);
        
        let origX = self.frame.origin.x;
        let origY = self.frame.origin.y;
        let origWidth = self.frame.size.width;
        let origHeight = self.frame.size.height;
        
        let origBoundX = self.bounds.origin.x
        let origBoundY = self.bounds.origin.y
        
        if (testSwitch == false) {
            testBoundWidth = self.bounds.size.width;
            testBoundHeight = self.bounds.size.height;
            
            self.contentMode = .ScaleAspectFill
            self.layer.masksToBounds = true;
            //self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, testBoundWidth - 10, testBoundHeight - 10);
            self.frame = CGRectMake(origX, origY, testBoundWidth - 2.5, testBoundHeight - 2.5);
            //self.sizeToFit()
            
            testSwitch = true;
        }
        
        //contentView.frame = CGRectMake(x: 10, y: 0, width: testBoundWidth - 20, height: self.contentView.frame.size.width - 10)
        contentView.frame = CGRectMake(10, 0, testBoundWidth - 12.5, testBoundHeight - 2.5)
        //self.frame = CGRect(x: origX + 10, y: origY, width: origWidth - 20, height: origHeight - 10)
        //self.frame = contentView.frame;
        
        
    }
}
