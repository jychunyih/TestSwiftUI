//
//  CardListViewController.swift
//  TestSwiftUI
//
//  Created by chunyih on 16/3/9.
//  Copyright © 2016年 chunyih. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet var footerView: UIView!
    
    @IBOutlet weak var footerLineHeightConstraint: NSLayoutConstraint! {
        didSet{footerLineHeightConstraint.constant = 0.5}
    }
    
    var tableView : UITableView!;
    var arraySource = NSMutableArray();
    var etatSwitch  = false;
    var cardSortedKeys = [String]();
    var cardDataDict: Dictionary<String, [Card]>?;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "浏览卡片"
        //self.view.backgroundColor = UIColor(red: 0x00, green: 0xB5, blue: 0x89, alpha: 0.95);
        
        /*
        self.cardListView.registerNib(CardTableViewCell.NibObject(), forCellReuseIdentifier: CardTableViewCell.identifier)
        self.cardListView.estimatedRowHeight = 54
        self.cardListView.sectionIndexColor = UIColor.darkGrayColor()
        self.cardListView.tableFooterView = self.footerView
        */
        
        //self.cardListView.estimatedRowHeight = 54
        //self.cardListView.sectionIndexColor = UIColor.darkGrayColor()
        
        
        //self.FetchCardData();
        
        self.CreateNavPanel();
        self.setupTableView();
    }
    
    func setupTableView(){
        
        //Populate your array source
        arraySource.insertObject("object1", atIndex: 0)
        arraySource.insertObject("object2", atIndex: 0)
        arraySource.insertObject("object3", atIndex: 0)
        arraySource.insertObject("object4", atIndex: 0)
        
        //setup your tableView
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Grouped)
        tableView.backgroundColor = UIColor.whiteColor();
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.registerClass(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        //Create a footer and a header for your tableView
        let footerTableView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        footerTableView.backgroundColor = UIColor.blueColor()
        
        let textFieldFooter = UILabel(frame: footerTableView.bounds)
        textFieldFooter.text = "Footer view"
        textFieldFooter.textAlignment = .Center
        footerTableView.addSubview(textFieldFooter)
        
        let headerTableView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        headerTableView.backgroundColor = UIColor.redColor()
        
        let textFieldHeader = UILabel(frame: headerTableView.bounds)
        textFieldHeader.text = "Header view"
        textFieldHeader.textAlignment = .Center
        headerTableView.addSubview(textFieldHeader)
        
        //Add your header and your footer to your tableView
        //tableView.tableFooterView = footerTableView
        //tableView.tableHeaderView = headerTableView
        
        // top, left, bottom, right
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //tableView.sizeToFit();
        //add your tableView in your main view
        self.view.addSubview(tableView)
        
        
    }
    
    func FetchCardData() {
        // fake data
        let card1 = Card(id: "1", type: CardType.Text, caption: "Card1", mediaContent: "Card1 Content");
        let card2 = Card(id: "2", type: CardType.Text, caption: "Card2", mediaContent: "Card2 Content");
        let card3 = Card(id: "3", type: CardType.Text, caption: "Card3", mediaContent: "Card3 Content");
        let card4 = Card(id: "4", type: CardType.Text, caption: "Card4", mediaContent: "Card4 Content");
        let card5 = Card(id: "5", type: CardType.Text, caption: "Card5", mediaContent: "Card5 Content");
        
        var cardArray1: [Card] = [card1, card2, card3];
        var cardArray2: [Card] = [card4, card5];
        
        cardSortedKeys.append("section1");
        cardSortedKeys.append("section2");
        
        cardDataDict = Dictionary<String, [Card]>();
        cardDataDict!["section1"] = cardArray1;
        cardDataDict!["section2"] = cardArray2;
        
        //self.cardListView.reloadData();
    }
    
    func CreateNavPanel() {
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
        
        let rightSearchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchTapped")
        
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

extension CardListViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "row selected : \(indexPath.row) in section \(indexPath.section) ", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension CardListViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        /*
        if (cardDataDict?.keys == nil) {
            return 0;
        }
        return (self.cardDataDict?.keys.count)!;
        */
        if etatSwitch{
            return 2
        }
        else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        let key: String = self.cardSortedKeys[section];
        let dataArray: [Card] = self.cardDataDict![key]!
        return dataArray.count
        */
        if section == 0 {
            if etatSwitch{
                return 4
            }
            else{
                return 1
            }
        }
        else if section == 1 {
            return 1
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        let cell = tableView.dequeueReusableCellWithIdentifier(CardTableViewCell.identifier, forIndexPath: indexPath) as! CardTableViewCell;
        guard indexPath.section < self.cardSortedKeys.count else {
            return cell;
        }
        
        let key: String = self.cardSortedKeys[indexPath.section];
        let dataArray: [Card] = self.cardDataDict![key]!;
        cell.setCellContent(dataArray[indexPath.row]);
        
        return cell;
        */
        if indexPath.row == 0 && indexPath.section == 0{
            let cell : CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell") as! CustomCell
            cell.textLabel?.text = "\(arraySource.objectAtIndex(indexPath.row))"
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            cell.switchButton.addTarget(self, action: "switchButton:", forControlEvents: UIControlEvents.ValueChanged)
            return cell
        }
        else{
            let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell")!
            cell.textLabel?.text = "\(arraySource.objectAtIndex(indexPath.row))"
            cell.accessoryType = UITableViewCellAccessoryType.DetailButton
            return cell
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /*
        let title = self.cardSortedKeys[section];
        return title;
        */
        return "section \(section)"
    }
    
    func switchButton(sender:UISwitch){
        
        if sender.on{
            tableView.beginUpdates()
            let target1 = NSIndexPath(forRow: 1, inSection: 0)
            let target2 = NSIndexPath(forRow: 2, inSection: 0)
            let target3 = NSIndexPath(forRow: 3, inSection: 0)
            
            tableView.insertSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Bottom)
            tableView.insertRowsAtIndexPaths([target1,target2,target3], withRowAnimation: UITableViewRowAnimation.Middle)
            etatSwitch = true
            tableView.endUpdates()
        }
        else{
            let target1 = NSIndexPath(forRow: 1, inSection: 0)
            let target2 = NSIndexPath(forRow: 2, inSection: 0)
            let target3 = NSIndexPath(forRow: 3, inSection: 0)
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([target1,target2,target3], withRowAnimation: UITableViewRowAnimation.Bottom)
            tableView.deleteSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Fade)
            etatSwitch = false
            tableView.endUpdates()
        }
        
    }
}
