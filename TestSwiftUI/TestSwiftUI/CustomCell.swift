//
//  CustomCell.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var labelNom : UILabel!
    var labelDate : UILabel!
    var labelTotal : UILabel!
    var switchButton : UISwitch!
    var margin :CGFloat!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //self.contentView.backgroundColor = UIColor.orangeColor()
        labelTotal = UILabel()
        labelTotal.textAlignment = NSTextAlignment.Right
        contentView.addSubview(labelTotal)
        
        labelNom = UILabel()
        contentView.addSubview(labelNom)
        
        labelDate = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 50));
        contentView.addSubview(labelDate)
 
        switchButton = UISwitch()
        contentView.addSubview(switchButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.accessoryView = switchButton
        self.contentView.backgroundColor = UIColor.greenColor()
        labelDate.text = "hahaha";

    }

}
