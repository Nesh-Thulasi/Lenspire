//
//  CreditsView.swift
//  LENSPiRE
//
//  Created by Tulasi on 22/04/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class RequestsVC: UIViewController, TLSSegmentViewDelegate
{
    var segmentedControl: TLSSegmentView!
    var seletionBar: UIView = UIView()
    var contentView : UIView?
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    var feedObjects : NSArray   =   NSArray()
    var acceptedList : NSArray  =   NSArray()
    var  rejectedList : NSArray = NSArray()
    
    
    func productionbookCreated() {
        self.segmentedControl.selectSegementAtIndex(0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        if (kArtistID == "")
        {
            let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
            aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
            aButton.addTarget(self, action: #selector(ProductionbookListVC.menuBtnTapped), forControlEvents: .TouchUpInside)
            
            
            let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
            self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
            
            let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
            kImgView.image  =   UIImage(named: "lenspire-logo.png")
            kImgView.userInteractionEnabled =   true
            kImgView.contentMode    =   .ScaleAspectFit
            kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProductionbookListVC.headBtnTapped)))
            
            self.navigationItem.titleView   =   kImgView
            
        }
        else
        {
            let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
            aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
            aButton.addTarget(self, action: #selector(ProductionbookListVC.backBtnTapped), forControlEvents: .TouchUpInside)
            
            let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
            self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
            
            
            let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
            let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
            descLbl.text       =   kArtistName.uppercaseString
            descLbl.textColor  =   UIColor.blackColor()
            descLbl.numberOfLines   =   0
            descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
            descLbl.textAlignment  =   .Center
            kTempView.addSubview(descLbl)
            descLbl.center.x    =   1
            descLbl.center.y    =   22
            self.navigationItem.titleView   =   kTempView
        }
        
        
        contentView     =   UIView(frame: CGRectMake(0,50.0,self.view.frame.size.width, self.view.frame.size.height - 50.0 - 64.0))
        contentView?.backgroundColor    =   UIColor.whiteColor()
        self.view.addSubview(contentView!)
        
        segmentedControl    =   TLSSegmentView(frame: CGRectMake(0, 0, self.view.frame.size.width, 50), textColor: UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1), selectedTextColor: UIColor.blackColor(), textFont: UIFont(name: Gillsans.Default.description, size: 15.0)!)
        segmentedControl.delegate = self
        segmentedControl.addSegments(["PENDING","ACCEPTED","REJECTED"])
        self.view.addSubview(segmentedControl)
        
        let kTempBar    = UIView(frame:CGRect(x: 0.0, y: 47.0, width: self.view.frame.size.width, height: 3.0))
        kTempBar.backgroundColor    =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        self.segmentedControl.addSubview(kTempBar)
        self.seletionBar.frame = CGRect(x: 0.0, y: 47.0, width: 0, height: 3.0)
        self.seletionBar.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.41, alpha: 1)
        self.segmentedControl.addSubview(self.seletionBar)
        self.segmentedControl.selectSegementAtIndex(0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func headBtnTapped () {
        NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_HomeHeadTapped, object: nil)
    }
    func menuBtnTapped () {
        presentLeftMenuViewController()
    }
    
    func segementSelected (segment : TLSSegment, index : Int) {
        
        UIView.animateWithDuration(0.2, animations: {
            self.seletionBar.frame = CGRectMake(segment.frame.origin.x, self.seletionBar.frame.origin.y, segment.frame.size.width, self.seletionBar.frame.size.height)
        })
        
        for kView in (contentView?.subviews)! {
            kView.removeFromSuperview()
        }
        
        switch index {
        case 0:
            let prodView            =   RequestsListView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            prodView.kArtistID      =   kArtistID
            prodView.kArtistName    =   kArtistName
            prodView.viewType       =   0
            prodView.requestVC      =   self
            contentView?.addSubview(prodView)
            prodView.loadDetails()
            break
            
        case 1:
            let prodView            =   AccepetedListView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            prodView.kArtistID      =   kArtistID
            prodView.kArtistName    =   kArtistName
            prodView.requestVC      =   self
            contentView?.addSubview(prodView)
            prodView.loadDetails()
            break
            
        default:

            let prodView            =   RejectedListView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            prodView.kArtistID      =   kArtistID
            prodView.kArtistName    =   kArtistName
            prodView.requestVC      =   self
            contentView?.addSubview(prodView)
            prodView.loadDetails()
            
            break
        }
    }
    
    
}

class RequestsListView: UIView, UITableViewDelegate, UITableViewDataSource , FeedObjDelegate {
    var tbleView: UITableView?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var viewType : Int          =   0
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    var feedList : NSMutableArray   =   NSMutableArray()
    var requestVC : RequestsVC?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
    }
    func loadDetails () {
        
        
        var kSort   =   "0"
        if (viewType == 0)
        {
            kSort   =   "1"
        }
        else if (viewType == 1)
        {
            
        }
        var kArID   =   kArtistID
        if (kArID == "")
        {
            kArID   =   getUserID() as String
        }
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kArID,kSort] , forKeys: [kLS_CP_UserId,kLS_CP_ArtistId,kLS_CP_SortId])
        self.getFeedDetails()
        
    }
    
    func getFeedDetails () {
        
        if (requestVC?.feedObjects.count > 0) {
            self.tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
            self.tbleView?.delegate      =   self
            self.tbleView?.dataSource    =   self
            self.tbleView?.separatorStyle    =   .None
            self.tbleView?.registerClass(RequestViewCell.self, forCellReuseIdentifier: "LandProdCell")
            self.addSubview(self.tbleView!)
            
            self.feedList   =   NSMutableArray(array:(requestVC?.feedObjects)!)
            return
        }
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No request found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),""] , forKeys: [kLS_CP_userid,kLS_CP_key])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Feed_GetFeeds, parm: dict1, completion: { result , desc , code in
            
            processView.removeFromSuperview()
            
            self.tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
            self.tbleView?.delegate      =   self
            self.tbleView?.dataSource    =   self
            self.tbleView?.separatorStyle    =   .None
            self.tbleView?.registerClass(RequestViewCell.self, forCellReuseIdentifier: "LandProdCell")
            self.addSubview(self.tbleView!)
            
            //  print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                {
                    isSuccess   =   true
                    
                    let kTempArr : NSMutableArray   =   NSMutableArray()
                    
                    for kDict in (kArr as! NSArray) {
                        let feedObj : FeedObj   =   FeedObj().setDetails(kDict as! NSDictionary, kDelegate: self as FeedObjDelegate, kImgWidth: 200)
                        kTempArr.addObject(feedObj)
                    }
                    
                    self.feedList.addObjectsFromArray(kTempArr as [AnyObject])
                    self.requestVC?.feedObjects  =   NSArray(array: self.feedList)
                    self.tbleView?.reloadData()
                    
                    
                }
                if (isSuccess == false)
                {
                    noLbl.hidden    =   false
                }
            }
            else
            {
                noLbl.hidden      =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                }
            }
        })
        
    }
    
    
    func feedImageDownloadReqFinished () {
        self.tbleView?.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        let CiLbl : UILabel     =   UILabel(frame: CGRectMake(20, 0, self.frame.size.width - 40, 50))
        CiLbl.text              =   "credit Request".uppercaseString
        CiLbl.textAlignment     =   NSTextAlignment.Left
        CiLbl.font              =   UIFont(name: Gillsans.Default.description, size: 14.0)
        CiLbl.textColor         =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        customView.addSubview(CiLbl)
        return customView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RequestViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell") as! RequestViewCell
        
        let feedObj: FeedObj    =   feedList.objectAtIndex(indexPath.row) as! FeedObj
        cell.descLbl?.text      =   (feedObj._StoryName as String).uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        cell.acceptBtn?.tag     =   indexPath.row
        cell.rejectBtn?.tag     =   indexPath.row
        cell.acceptBtn?.addTarget(self, action: #selector(RequestsListView.acceptBtnTapped(_:)), forControlEvents: .TouchUpInside)
        cell.rejectBtn?.addTarget(self, action: #selector(RequestsListView.rejectBtnTapped(_:)), forControlEvents: .TouchUpInside)
        
        if (feedObj._isThumbImgDownloadIntiated == false)
        {
            feedObj.downloadThumbImg()
        }
        if ((feedObj._isThumbImgDownloadIntiated) == true && (feedObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   feedObj._thumbImg
        }
        
        
        if (self.loadedIndexes.containsObject(indexPath) == false)
        {
            self.loadedIndexes.addObject(indexPath)
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animateWithDuration(0.3, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
                },completion: { finished in
                    UIView.animateWithDuration(0.1, animations: {
                        cell.layer.transform = CATransform3DMakeScale(0.9,0.9,1)
                        },completion: { finished in
                            UIView.animateWithDuration(0.2, animations: {
                                cell.layer.transform = CATransform3DMakeScale(1,1,1)
                            })
                    })
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell    =   tableView.cellForRowAtIndexPath(indexPath)
        
        let vc: ImageViewController = ImageViewController()
        
        vc.kScreenshot     =   screenShot()
        
        let frame   =   cell?.superview!.convertRect((cell?.frame)!, toView: nil)
        vc.kFrame       =   frame
        vc.kFrame1          =   frame
        
        vc.storyObj     =   self.feedList[indexPath.row] as! FeedObj
        
        self.requestVC?.navigationController?.pushViewController(vc, animated: false)
    }
    
    func acceptBtnTapped (button : UIButton) {
        let arr   = NSMutableArray(array: (requestVC?.acceptedList)!)
        arr.addObject(self.feedList.objectAtIndex(button.tag))
        requestVC?.acceptedList =   NSArray(array: arr)
        self.feedList.removeObjectAtIndex(button.tag)
        self.requestVC?.feedObjects  =   NSArray(array: self.feedList)
        self.tbleView?.reloadData()
        
        MessageAlertView().showMessage("Credit request accepted successfully.", kColor : kLS_SuccessMsgColor)
    }
    func rejectBtnTapped (button : UIButton) {
        let arr   = NSMutableArray(array: (requestVC?.rejectedList)!)
        arr.addObject(self.feedList.objectAtIndex(button.tag))
        requestVC?.rejectedList =   NSArray(array: arr)
        self.feedList.removeObjectAtIndex(button.tag)
        self.requestVC?.feedObjects  =   NSArray(array: self.feedList)
        self.tbleView?.reloadData()
        
        MessageAlertView().showMessage("Credit request rejected.", kColor : kLS_FailedMsgColor)
        
    }
}



class AccepetedListView: UIView, UITableViewDelegate, UITableViewDataSource , FeedObjDelegate {
    var tbleView: UITableView?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    var feedList : NSMutableArray   =   NSMutableArray()
    var requestVC : RequestsVC?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
    }
    func loadDetails () {
        
        var kArID   =   kArtistID
        if (kArID == "")
        {
            kArID   =   getUserID() as String
        }
        self.getFeedDetails()
        
    }
    
    func getFeedDetails () {
        
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No accepted request found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        self.feedList.addObjectsFromArray((self.requestVC?.acceptedList)! as [AnyObject])

        if (self.feedList.count == 0) {
            noLbl.hidden    =   false
        }
        else {
            self.tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
            self.tbleView?.delegate      =   self
            self.tbleView?.dataSource    =   self
            self.tbleView?.separatorStyle    =   .None
            self.tbleView?.registerClass(RequestViewCell.self, forCellReuseIdentifier: "LandProdCell")
            self.addSubview(self.tbleView!)
        }
        
    }
    
    
    func feedImageDownloadReqFinished () {
        self.tbleView?.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        let CiLbl : UILabel     =   UILabel(frame: CGRectMake(20, 0, self.frame.size.width - 40, 50))
        CiLbl.text              =   "Accepted credit Request".uppercaseString
        CiLbl.textAlignment     =   NSTextAlignment.Left
        CiLbl.font              =   UIFont(name: Gillsans.Default.description, size: 14.0)
        CiLbl.textColor         =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        customView.addSubview(CiLbl)
        return customView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RequestViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell") as! RequestViewCell
        
        let feedObj: FeedObj    =   feedList.objectAtIndex(indexPath.row) as! FeedObj
        cell.descLbl?.text      =   (feedObj._StoryName as String).uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)

        if (feedObj._isThumbImgDownloadIntiated == false)
        {
            feedObj.downloadThumbImg()
        }
        if ((feedObj._isThumbImgDownloadIntiated) == true && (feedObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   feedObj._thumbImg
        }
        
        cell.acceptBtn?.hidden  =   true
        cell.rejectBtn?.hidden  =   true
        
        
        let descLbl  =   UILabel(frame: CGRectMake(90, 40, UIScreen.mainScreen().bounds.size.width - 100, 30))
        descLbl.text       =   "Request Accepted"
        descLbl.font       =   UIFont.systemFontOfSize(15.0)
        descLbl.numberOfLines  =   0
        descLbl.textColor  =   kLS_SuccessMsgColor
        descLbl.textAlignment  =   NSTextAlignment.Left
        cell.contentView.addSubview(descLbl)
        
        if (self.loadedIndexes.containsObject(indexPath) == false)
        {
            self.loadedIndexes.addObject(indexPath)
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animateWithDuration(0.3, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
                },completion: { finished in
                    UIView.animateWithDuration(0.1, animations: {
                        cell.layer.transform = CATransform3DMakeScale(0.9,0.9,1)
                        },completion: { finished in
                            UIView.animateWithDuration(0.2, animations: {
                                cell.layer.transform = CATransform3DMakeScale(1,1,1)
                            })
                    })
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
}

class RejectedListView: UIView, UITableViewDelegate, UITableViewDataSource , FeedObjDelegate {
    var tbleView: UITableView?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    var feedList : NSMutableArray   =   NSMutableArray()
    var requestVC : RequestsVC?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
    }
    func loadDetails () {
        
        var kArID   =   kArtistID
        if (kArID == "")
        {
            kArID   =   getUserID() as String
        }
        self.getFeedDetails()
        
    }
    
    func getFeedDetails () {
        
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No rejected request found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        self.feedList.addObjectsFromArray((self.requestVC?.rejectedList)! as [AnyObject])
        
        if (self.feedList.count == 0) {
            noLbl.hidden    =   false
        }
        else {
            self.tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
            self.tbleView?.delegate      =   self
            self.tbleView?.dataSource    =   self
            self.tbleView?.separatorStyle    =   .None
            self.tbleView?.registerClass(RequestViewCell.self, forCellReuseIdentifier: "LandProdCell")
            self.addSubview(self.tbleView!)
        }
        
    }
    
    
    func feedImageDownloadReqFinished () {
        self.tbleView?.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        let CiLbl : UILabel     =   UILabel(frame: CGRectMake(20, 0, self.frame.size.width - 40, 50))
        CiLbl.text              =   "Rejected credit Request".uppercaseString
        CiLbl.textAlignment     =   NSTextAlignment.Left
        CiLbl.font              =   UIFont(name: Gillsans.Default.description, size: 14.0)
        CiLbl.textColor         =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        customView.addSubview(CiLbl)
        return customView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:RequestViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell") as! RequestViewCell
        
        let feedObj: FeedObj    =   feedList.objectAtIndex(indexPath.row) as! FeedObj
        cell.descLbl?.text      =   (feedObj._StoryName as String).uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        
        if (feedObj._isThumbImgDownloadIntiated == false)
        {
            feedObj.downloadThumbImg()
        }
        if ((feedObj._isThumbImgDownloadIntiated) == true && (feedObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   feedObj._thumbImg
        }
        
        cell.acceptBtn?.hidden  =   true
        cell.rejectBtn?.hidden  =   true
        
        
        let descLbl  =   UILabel(frame: CGRectMake(90, 40, UIScreen.mainScreen().bounds.size.width - 100, 30))
        descLbl.text       =   "Request Rejected"
        descLbl.font       =   UIFont.systemFontOfSize(15.0)
        descLbl.numberOfLines  =   0
        descLbl.textColor  =   kLS_FailedMsgColor
        descLbl.textAlignment  =   NSTextAlignment.Left
        cell.contentView.addSubview(descLbl)
        
        if (self.loadedIndexes.containsObject(indexPath) == false)
        {
            self.loadedIndexes.addObject(indexPath)
            cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
            UIView.animateWithDuration(0.3, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
                },completion: { finished in
                    UIView.animateWithDuration(0.1, animations: {
                        cell.layer.transform = CATransform3DMakeScale(0.9,0.9,1)
                        },completion: { finished in
                            UIView.animateWithDuration(0.2, animations: {
                                cell.layer.transform = CATransform3DMakeScale(1,1,1)
                            })
                    })
            })
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}



class RequestViewCell: UITableViewCell{
    
    var bgImg: UIImageView!
    var descLbl : UILabel?
    var feedObj: FeedObj?
    var acceptBtn : UIButton?
    var rejectBtn : UIButton?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        self.selectedBackgroundView = bgColorView
        
        
        bgImg   =   UIImageView(frame:  CGRectMake(15, 5, 60, 70))
        bgImg.backgroundColor   =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.addSubview(bgImg)
        
        descLbl  =   UILabel(frame: CGRectMake(90, 5, UIScreen.mainScreen().bounds.size.width - 100, 30))
        descLbl!.text       =   ""
        descLbl!.font       =   UIFont.boldSystemFontOfSize(16)
        descLbl!.numberOfLines  =   0
        descLbl!.textColor  =   UIColor.blackColor()
        descLbl!.textAlignment  =   NSTextAlignment.Left
        
        
        acceptBtn   =   UIButton(type: .Custom)
        acceptBtn?.setImage(getButtonImage("Accept", kWidth: ((UIScreen.mainScreen().bounds.size.width - 120) / 2.0) * 2.0, kHeight: 60.0, kFont: UIFont(name: Gillsans.Default.description, size: 28.0)!), forState: .Normal)
        acceptBtn?.frame    =   CGRectMake(90, 42, ((UIScreen.mainScreen().bounds.size.width - 120) / 2.0), 30.0)
        contentView.addSubview(acceptBtn!)
        
        rejectBtn   =   UIButton(type: .Custom)
        rejectBtn?.setImage(getRejectButtonImage("Reject", kWidth: ((UIScreen.mainScreen().bounds.size.width - 120) / 2.0) * 2.0, kHeight: 60.0, kFont: UIFont(name: Gillsans.Default.description, size: 28.0)!), forState: .Normal)
        rejectBtn?.frame    =   CGRectMake(90 + 10 + ((UIScreen.mainScreen().bounds.size.width - 120) / 2.0), 42, ((UIScreen.mainScreen().bounds.size.width - 120) / 2.0), 30.0)
        contentView.addSubview(rejectBtn!)
        
        contentView.addSubview(descLbl!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}



class ImageViewController: UIViewController, FeedObjDelegate  , UIScrollViewDelegate{
    
    var imageView: UIImageView!
    var storyObj: FeedObj!
    var scrollView : UIScrollView!
    var kFrame : CGRect?
    var imageView1: UIImageView!
    var kFrame1 : CGRect?
    var processView : ProcessView?
    var kScreenshot : UIImage?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBarHidden  =   true
        imageView1  =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(imageView1!)
        imageView1!.image =   kScreenshot
        
        
        
        UIView.animateWithDuration(0.60) { () -> Void in
            self.imageView1!.alpha =   0
            self.imageView1!.frame.size.width  =   self.imageView1!.frame.size.width - 30
            self.imageView1!.frame.size.height =   self.imageView1!.frame.size.height * ((self.imageView1!.frame.size.width - 30) / self.imageView1!.frame.size.width)
            self.imageView1!.center    =   self.view.center
        }
        
        self.scrollView =   UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height))
        scrollView.delegate =   self
        scrollView.bouncesZoom  =   true
        scrollView.clipsToBounds    =   true
        scrollView.maximumZoomScale =   2.0
        self.view.addSubview(scrollView)
        
        self.imageView  =   UIImageView(frame: kFrame!)
        self.imageView.contentMode  =   .ScaleAspectFit
        self.imageView.userInteractionEnabled   =   true
        self.scrollView.addSubview(self.imageView)
        
        processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height))
        self.view.addSubview(processView!)
        
   
            self.storyObj._delegate =   self
            if (storyObj._isImgDownloadIntiated == false)
            {
                storyObj.downloadImg()
            }
            if (storyObj._isThumbImgDownloaded == true)
            {
                imageView.image    =   storyObj._thumbImg
            }
            
            if (storyObj._isImgDownloaded == true)
            {
                processView?.removeFromSuperview()
                imageView.image     =   storyObj._Img
            }
        
        let aButton     =   UIButton(frame: CGRectMake(self.view.frame.size.width - 50, 20, 40, 40))
        aButton.setImage(UIImage(named: "cross.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(FullImageController.closeBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        let winkitBtn     =   UIButton(frame: CGRectMake(20, 20, 120, 32))
        winkitBtn.setImage(getButtonImage("WINK IT", kWidth: 120.0 * 2.0, kHeight: 64.0, kFont: UIFont(name: Gillsans.Default.description, size: 34.0)!), forState: .Normal)
        winkitBtn.addTarget(self, action: #selector(FullImageController.winkitBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(winkitBtn)
        winkitBtn.enabled   =   false
        
        UIView.animateWithDuration(0.30) { () -> Void in
            self.imageView.frame    =   CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func feedImageDownloadReqFinished ()
    {
        processView?.removeFromSuperview()
        imageView.image    =   storyObj._Img
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func closeBtnTapped () {
        
        self.navigationController?.navigationBarHidden  =   false
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    func winkitBtnTapped () {
        
        }
}
