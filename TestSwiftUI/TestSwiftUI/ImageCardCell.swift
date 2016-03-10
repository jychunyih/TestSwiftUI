//
//  ImageCardCell.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/10.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class ImageCardCell: UITableViewCell {
    
    var captionLabel: UILabel!
    var contentImage: UIImageView!
    
    var testSwitch: Bool = false;
    var testBoundWidth: CGFloat = 0;
    var testBoundHeight: CGFloat = 0;

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        captionLabel = UILabel(frame: CGRect(x: 30, y: 60, width: 150, height: 44));
        captionLabel.textColor = UIColor.whiteColor();
        captionLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 18)
        self.contentView.addSubview(captionLabel);
        
        contentImage = UIImageView(image: UIImage(named: "digicard_bg"));
        
        self.contentView.sizeToFit();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //captionLabel.text = "年会活动照片"
        
        self.backgroundView = contentImage;
        self.backgroundView?.contentMode = .ScaleAspectFill
        self.backgroundView?.layer.masksToBounds = true;
        
        /*
        contentView.contentMode = .ScaleAspectFill
        contentView.layer.masksToBounds = true
        
        let contentViewWidth = Int(self.contentView.frame.size.width);
        let contentViewHeight = Int(self.contentView.frame.size.height);
        
        //self.backgroundView?.frame = CGRect(x: 10, y: 0, width: contentViewWidth - 20, height: contentViewHeight)
        
        //self.imageView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0);
        self.imageView?.backgroundColor = UIColor.redColor();

        self.contentView.frame = CGRect(x: 10, y: 0, width: contentViewWidth - 20, height: contentViewHeight - 10)
        */
        
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
        
        self.backgroundView?.frame = self.contentView.frame;
    }

}
