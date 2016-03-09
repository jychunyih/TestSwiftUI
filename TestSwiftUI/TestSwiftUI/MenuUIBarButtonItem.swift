//
//  MenuUIBarButtonItem.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class MenuUIBarButtonItem: UIBarButtonItem, UIActionSheetDelegate {
    
    override init() {
        super.init();
        let actionSheet: UIActionSheet = UIActionSheet(title: "testtitle", delegate: self, cancelButtonTitle: "cancel", destructiveButtonTitle: "destroy", otherButtonTitles: "button 1", "button 2")
        actionSheet.actionSheetStyle = UIActionSheetStyle.Default;
    }

    required init?(coder aDecoder: NSCoder) {
        super.init();
        let actionSheet: UIActionSheet = UIActionSheet(title: "testtitle", delegate: self, cancelButtonTitle: "cancel", destructiveButtonTitle: "destroy", otherButtonTitles: "button 1", "button 2")
        actionSheet.actionSheetStyle = UIActionSheetStyle.Default;
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        NSLog("Click \(buttonIndex)");
    
    }
}
