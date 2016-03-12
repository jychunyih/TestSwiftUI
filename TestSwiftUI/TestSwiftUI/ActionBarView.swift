//
//  ActionBarView.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/12.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import Foundation
import UIKit
import UIColor_Hex_Swift


@IBDesignable class ActionBarView: UIView {
    // MARK: Constraint
    static let ActionBarHeight:CGFloat = 50
    let Padding:CGFloat = 5
    let InputFieldWidth:CGFloat = 200
    let ButtonSize:CGFloat = 40
    let textFieldLeftoffset: CGFloat = 15
    let textFieldRightOffset: CGFloat = 10
    
    // MARK: Properties
    
    var textInput: UITextField!
    
    var photoBtn: UIButton!
    
    var voiceBtn: UIButton!
    
    // MARK: Initialiazation
    override init(frame: CGRect) {
        super.init(frame: frame)
        textInput = UITextField()
        photoBtn = UIButton()
        voiceBtn = UIButton()
        addSubview(textInput)
        addSubview(photoBtn)
        addSubview(voiceBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textInput = UITextField()
        photoBtn = UIButton()
        voiceBtn = UIButton()
        addSubview(textInput)
        addSubview(photoBtn)
        addSubview(voiceBtn)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width, ActionBarView.ActionBarHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // set view property
        self.backgroundColor = UIColor.whiteColor()
        self.alpha = 1
        
        voiceBtn.setImage(UIImage(named: "voice", inBundle: DigiCardGlobals.getCameraBundle(), compatibleWithTraitCollection: nil), forState: .Normal)
        voiceBtn.frame = CGRect(x:UIScreen.mainScreen().bounds.width - Padding - ButtonSize, y:Padding, width:ButtonSize, height:ButtonSize)
        
        photoBtn.setImage(UIImage(named: "takephoto", inBundle: DigiCardGlobals.getCameraBundle(), compatibleWithTraitCollection: nil), forState: .Normal)
        photoBtn.frame = CGRect(x: voiceBtn.frame.origin.x-Padding-ButtonSize, y: Padding, width: ButtonSize, height: ButtonSize)
        
        textInput.background = UIImage(named: "input", inBundle: DigiCardGlobals.getCameraBundle(), compatibleWithTraitCollection: nil)
        textInput.frame = CGRect(x: Padding, y: Padding, width: voiceBtn.frame.origin.x-2*Padding-ButtonSize-textFieldRightOffset, height: ActionBarView.ActionBarHeight-2*Padding)
        textInput.attributedPlaceholder = NSAttributedString(string: "撰写卡片...")
        let paddingView = UIView(frame: CGRectMake(0, 0, textFieldLeftoffset, self.textInput.frame.height))
        textInput.leftView = paddingView
        textInput.leftViewMode = UITextFieldViewMode.Always
    }
    
    
}

