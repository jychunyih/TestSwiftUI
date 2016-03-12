//
//  CardListViewController.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit
import Foundation

class CardListViewController: UIViewController {
    
    // MARK : Properties
    var actionBarView: ActionBarView!
    var tableView : UITableView!
    var navBarHeight: CGFloat = 0
    var statusBarHeight: CGFloat = 20
    var menuShowOffset: CGFloat = 50
    var menuShowWidth: CGFloat = 50
    var titleFrameLeftOffset: CGFloat = 60
    var titleFrameTopOffset: CGFloat = 8
    var titleFrameWidth: CGFloat = 128.5
    var titleFrameHeight: CGFloat = 30
    var barButtonWidth: CGFloat = 40
    var barItemWidth: CGFloat = 44
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        actionBarView = ActionBarView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        actionBarView = ActionBarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavPanel()
        setupTableView()
        
        setupActionBarView()
        view.addSubview(actionBarView)
        //view.bringSubviewToFront(actionBarView)
    }
    
    func setupTableView() {
        // create the table view object
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - navBarHeight - statusBarHeight), style: UITableViewStyle.Grouped)
        
        // set table view properties
        tableView.backgroundColor = UIColor.whiteColor();
        tableView.separatorStyle = .None;
        
        // set delegation and cell object model
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.registerClass(TextCardTableCell.self, forCellReuseIdentifier: "TextCardTableCell")
        tableView.registerClass(ImageCardTableCell.self, forCellReuseIdentifier: "ImageCardTableCell")
        
        // add subview
        self.view.addSubview(tableView)
    }
    
    func setupNavPanel() {
        
        // set navigation bar properties
        //self.navigationController?.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, navBarHeight);
        navBarHeight = (self.navigationController?.navigationBar.frame.height)!;
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor();
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor();
        self.navigationController?.navigationBar.translucent = false;
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // people logo button
        let peopleBtn: UIButton = UIButton(type: UIButtonType.Custom)
        peopleBtn.setImage(UIImage(named: "cardlogo_test"), forState: UIControlState.Normal)
        peopleBtn.frame = CGRectMake(0, 0, barButtonWidth, barButtonWidth)
        peopleBtn.layer.cornerRadius = peopleBtn.frame.width / 2
        peopleBtn.clipsToBounds = true;
        let peopleBarBtn = UIBarButtonItem(customView: peopleBtn)
        
        
        // view style button
        let viewStyleBtn: UIButton = UIButton(type: UIButtonType.Custom)
        viewStyleBtn.setImage(UIImage(named: "time_"), forState: UIControlState.Normal)
        viewStyleBtn.addTarget(self, action: "changeListView", forControlEvents: UIControlEvents.TouchUpInside)
        viewStyleBtn.frame = CGRectMake(0, 0, barButtonWidth, barButtonWidth)
        let viewStyleBarBtn = UIBarButtonItem(customView: viewStyleBtn);
        
        // search button
        let rightSearchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchTapped")
        
        // set left and right bar button
        self.navigationItem.leftBarButtonItem = peopleBarBtn
        self.navigationItem.rightBarButtonItems = [viewStyleBarBtn, rightSearchButton];
        
        // set title view
        let viewWidth = self.navigationController?.navigationBar.frame.width;
        let titleViewWidth = viewWidth! - titleFrameLeftOffset - 3*barItemWidth;
        
        let imageView = UIImageView(frame: CGRectMake(0, titleFrameTopOffset, titleFrameWidth, titleFrameHeight))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "logo_")
        
        let titleUIView = UIView(frame: CGRect(x: 0, y: 0, width: titleViewWidth, height: barButtonWidth))
        titleUIView.addSubview(imageView);
        
        self.navigationItem.titleView = titleUIView
        self.navigationItem.titleView?.contentMode = .ScaleAspectFill
        self.navigationItem.titleView?.layer.masksToBounds = true;
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
        return false
    }
    
    func changeListView() {
        becomeFirstResponder()
        let menu = UIMenuController.sharedMenuController()
        let timeItem = UIMenuItem(title: "按时间排序", action: Selector("timeOrderView"))
        let tagItem = UIMenuItem(title: "按标签排序", action: Selector("tagOrderView"))
        menu.menuItems = [timeItem, tagItem]
        
        menu.arrowDirection = .Up
        
        let left = self.view.bounds.width - menuShowOffset;
        let top: CGFloat = 0 - navBarHeight - statusBarHeight;
        
        menu.setTargetRect(CGRectMake(left, top, menuShowWidth, menuShowWidth), inView: self.view)
        menu.setMenuVisible(true, animated: true)
    }
    
    func searchTapped() {
        // do nothing so far
    }
}

// MARK: ActionBarView Logic
extension CardListViewController{
    func setupActionBarView(){
        actionBarView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - ActionBarView.ActionBarHeight  - navBarHeight - statusBarHeight, width: UIScreen.mainScreen().bounds.width, height: ActionBarView.ActionBarHeight)
        actionBarView.sizeToFit()
        
        let photoBtn = self.actionBarView.photoBtn
        photoBtn.addTarget(self, action: "openCamera:", forControlEvents: .TouchUpInside)
    }
    
    func openCamera(sender: UIButton){
        /*
        let cameraViewController = CameraViewController(allowsLibraryAccess: true) { (image) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(cameraViewController, animated: true, completion: nil)
        */
    }
}

// MARK: Table View Delegation extension
extension CardListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "row selected : \(indexPath.row) in section \(indexPath.section) ", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // do nothing
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // delete action
        let deleteAction = UITableViewRowAction(style: .Normal, title: "      ") { action, index in
            NSLog("deleteAction tapped")
            // TODO
        }
        let imageDelete = UIImage(named: "delete_")
        deleteAction.backgroundColor = UIColor(patternImage: imageDelete!)
        
        // tag action
        let tagAction = UITableViewRowAction(style: .Normal, title: "      ") { action, index in
            print("tagAction tapped")
            // TODO
        }
        let imageTag = UIImage(named: "tag_")
        tagAction.backgroundColor = UIColor(patternImage: imageTag!)
        
        // share action
        let shareAction = UITableViewRowAction(style: .Normal, title: "      ") { action, index in
            NSLog("shareAction tapped")
            // TODO
        }
        let imageShare = UIImage(named: "share_")
        shareAction.backgroundColor = UIColor(patternImage: imageShare!)
        
        return [shareAction, tagAction, deleteAction]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
}

// MARK: Table View Data Source extension
extension CardListViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 4
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if (indexPath.row == 0) {
                let cell: TextCardTableCell = tableView.dequeueReusableCellWithIdentifier("TextCardTableCell") as! TextCardTableCell;
                return cell;
            }
            else if (indexPath.row == 2) {
                let cell: TextCardTableCell = tableView.dequeueReusableCellWithIdentifier("TextCardTableCell") as! TextCardTableCell;
                cell.captionLabel.text = "和赵晨晨的聊天"
                return cell;
            }
            else if (indexPath.row == 1) {
                let cell: ImageCardTableCell = tableView.dequeueReusableCellWithIdentifier("ImageCardTableCell") as! ImageCardTableCell;
                cell.captionLabel.text = "年会活动照片"
                return cell;
            }
            else {
                let cell: ImageCardTableCell = tableView.dequeueReusableCellWithIdentifier("ImageCardTableCell") as! ImageCardTableCell;
                cell.captionLabel.text = "孩子的成长日记"
                return cell;
            }
        }
        else{
            let cell: TextCardTableCell = tableView.dequeueReusableCellWithIdentifier("TextCardTableCell") as! TextCardTableCell;
            return cell;
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "今天"
        }
        else {
            return "最近7天"
        }
    }
}