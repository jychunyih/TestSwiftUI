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
    var refreshControl: UIRefreshControl!
    
    // size info
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
    
    // drag variable
    struct My {
        static var cellSnapshot : UIView? = nil
    }
    struct Path {
        static var initialIndexPath : NSIndexPath? = nil
        static var previousIndexPath: NSIndexPath? = nil
    }
    
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
        
        //tableView.contentInset = UIEdgeInsetsMake(0, 50, 0, 50)
        
        // set table view properties
        tableView.backgroundColor = UIColor.whiteColor();
        tableView.separatorStyle = .None;
        
        // long press gesture
        let longPress = UILongPressGestureRecognizer(target: self, action: "tableViewLongPress:")
        tableView.addGestureRecognizer(longPress)

        // set delegation and cell object model
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.registerClass(TextCardTableCell.self, forCellReuseIdentifier: "TextCardTableCell")
        tableView.registerClass(ImageCardTableCell.self, forCellReuseIdentifier: "ImageCardTableCell")
        
        // add refresh control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControl.addTarget(self, action: "TableRefreshData:", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        // add subview
        self.view.addSubview(tableView)
    }
    
    func snapshotOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        
        UIGraphicsEndImageContext()
        
        let cellSnapshot : UIView = UIImageView(image: image)
        
        cellSnapshot.layer.masksToBounds = false
        
        cellSnapshot.layer.cornerRadius = 0.0
        
        cellSnapshot.layer.shadowOffset = CGSizeMake(-0.0, 0.0)
        
        cellSnapshot.layer.shadowRadius = 5.0
        
        cellSnapshot.layer.shadowOpacity = 0.4
        
        return cellSnapshot
        
    }
    
    func tableViewLongPress(gestureRecognizer: UIGestureRecognizer) {
        NSLog("tableViewLongPress triggerer")
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        NSLog("tableViewLongPress state = " + String(state))
        
        let locationInView: CGPoint = longPress.locationInView(self.tableView)
        let indexPath: NSIndexPath? = self.tableView.indexPathForRowAtPoint(locationInView)
        NSLog("tableViewLongPress indexPath = " + String(indexPath))
        
        if (indexPath == nil) {
            return
        }
        
        switch state {
            case UIGestureRecognizerState.Began:
            
            Path.initialIndexPath = indexPath
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
            My.cellSnapshot  = snapshotOfCell(cell)
            var center = cell.center
            My.cellSnapshot!.center = center
            My.cellSnapshot!.alpha = 0.0
            
            tableView.addSubview(My.cellSnapshot!)
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                My.cellSnapshot!.transform = CGAffineTransformMakeScale(0.95, 0.95)
                My.cellSnapshot!.alpha = 0.98
                
                cell.alpha = 0.0
                }, completion: { (finished) -> Void in
                    
                    if finished {
                        
                        cell.hidden = true
                        
                    }
                    
            })
        case UIGestureRecognizerState.Changed:
            var center = My.cellSnapshot!.center
            
            center.y = locationInView.y
            
            My.cellSnapshot!.center = center
            
            if (indexPath != Path.initialIndexPath) {

                if Path.previousIndexPath != nil {
                    let previousCell = tableView.cellForRowAtIndexPath(Path.previousIndexPath!) as UITableViewCell!
                    //previousCell.contentView.layer.borderColor = UIColor.redColor().CGColor
                    previousCell.contentView.layer.borderWidth = 0.0
                }
                Path.previousIndexPath = indexPath
                //tableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath)
                
                //Path.initialIndexPath = indexPath
                let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                //cell.backgroundColor = UIColor.redColor()
                cell.contentView.layer.borderColor = UIColor.redColor().CGColor
                cell.contentView.layer.borderWidth = 2.0
                
            }
        default:
            let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
            NSLog("default indexPath = " + String(indexPath))
            
            if Path.previousIndexPath != nil {
                let previousCell = tableView.cellForRowAtIndexPath(Path.previousIndexPath!) as UITableViewCell!
                //previousCell.contentView.layer.borderColor = UIColor.redColor().CGColor
                previousCell.contentView.layer.borderWidth = 0.0
            }
            
            cell.hidden = false
            
            cell.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                
                My.cellSnapshot!.center = cell.center
                
                My.cellSnapshot!.transform = CGAffineTransformIdentity
                
                My.cellSnapshot!.alpha = 0.0
                
                cell.alpha = 1.0
                
                }, completion: { (finished) -> Void in
                    
                    if finished {
                        
                        Path.initialIndexPath = nil
                        
                        My.cellSnapshot!.removeFromSuperview()
                        
                        My.cellSnapshot = nil
                        
                    }
            })
        }
    }
    
    func TableRefreshData(sender: AnyObject) {
        
        self.refreshControl?.beginRefreshing()
        self.refreshControl.attributedTitle = NSAttributedString(string: "加载中...")

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            NSLog("Do Table Refresh Data")
            sleep(5)
            self.refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
            self.refreshControl?.endRefreshing()
            /*
            dispatch_async(dispatch_get_main_queue(), {
                
            });
            */
        })
        
        //self.tableView.reloadData()
        
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
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        if (self.refreshControl.refreshing == false) {
            //self.refreshControl.attributedTitle = NSAttributedString(string: "加载中...")
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (self.refreshControl.refreshing == false) {
            //self.refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        }
    }
    
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