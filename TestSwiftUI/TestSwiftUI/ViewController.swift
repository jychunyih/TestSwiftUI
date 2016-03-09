//
//  ViewController.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        //set image for button
        button.setImage(UIImage(named: "logo"), forState: UIControlState.Normal)
        //add function for button
        // button.addTarget(self, action: "fbButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        
        //set frame
        button.frame = CGRectMake(0, 0, 40, 40)
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true;
        
        let barButton = UIBarButtonItem(customView: button)
        
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        //self.navigationController?.navigationBar.layer.cornerRadius = 20
        //self.navigationController?.navigationBar.clipsToBounds = true;
        
        
        //create a new button
        let menuBtn: UIButton = UIButton(type: UIButtonType.Custom)
        //set image for button
        menuBtn.setImage(UIImage(named: "digicard_logo"), forState: UIControlState.Normal)
        //add function for button
        menuBtn.addTarget(self, action: "changeListView", forControlEvents: UIControlEvents.TouchUpInside)
        
        //set frame
        menuBtn.frame = CGRectMake(0, 0, 40, 40)
        //menuBtn.layer.cornerRadius = button.frame.width / 2
        //menuBtn.clipsToBounds = true;
        
        var rightSearchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchTapped")
        
        let menuBarButton = UIBarButtonItem(customView: menuBtn);
        //let menuBarButton = MenuUIBarButtonItem();
        //menuBarButton.image = UIImage(named: "digicard_logo");
        
        self.navigationItem.rightBarButtonItems = [menuBarButton, rightSearchButton];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        NSLog("Click \(buttonIndex)");
        
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        // You need to only return true for the actions you want, otherwise you get the whole range of
        //  iOS actions. You can see this by just removing the if statement here.
        if action == Selector("timeOrderView") {
            return true
        }
        if action == Selector("tagOrderView") {
            return true
        }
        if action == Selector("nameOrderView") {
            return true
        }
        return false
    }
    
    func changeListView() {
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        let timeItem = UIMenuItem(title: "按时间排序", action: Selector("timeOrderView"))
        let tagItem = UIMenuItem(title: "按标签排序", action: Selector("tagOrderView"))
        let nameItem = UIMenuItem(title: "按标题排序", action: Selector("nameOrderView"))
        menu.menuItems = [timeItem, tagItem, nameItem]
        
        menu.arrowDirection = .Up
        
        let left = self.view.bounds.width - 50;
        let top: CGFloat = 0;
        
        menu.setTargetRect(CGRectMake(left, top, 50, 50), inView: self.view)
        //menu.setTargetRect(self.view.frame, inView: self.view.superview!)
        menu.setMenuVisible(true, animated: true)
        
        
    }
    
    func searchTapped() {
        let actionSheet: UIActionSheet = UIActionSheet(title: "选择排序方式", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "按时间排序", "按标签排序")
        actionSheet.actionSheetStyle = UIActionSheetStyle.Default;
        actionSheet.showInView(self.view);
    }

    override func viewDidAppear(animated: Bool) {
        // 1
        let nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        // 3
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        //imageView.contentMode = .ScaleAspectFit
        imageView.contentMode = .ScaleAspectFill
        
        //imageView.frame.offsetInPlace(dx: 80, dy: 0);
        
        // 4
        let image = UIImage(named: "digicard_title")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView
        
        nav?.layer.cornerRadius = 25
    }

}

