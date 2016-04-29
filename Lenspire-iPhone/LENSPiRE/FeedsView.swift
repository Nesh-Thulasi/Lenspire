//
//  FeedsView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 11/11/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation
import UIKit

class FeedsViewController: UIViewController, FeedObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout{
    
    var feedList : NSMutableArray?
    var messagesList : NSArray  =   NSArray()
    var collView: UICollectionView?
    var kPagingKey : NSString = ""
    var kWidth : CGFloat?
    var isLoadingFinished : Bool?
    var loadedKeys : NSMutableArray?
    var isFirstTime : Bool  =   true
    var currentServiceReq   =   ServiceWrapper()
    var processView : ProcessView?
    var noLbl : UILabel?
    var notiMsgCountLbl : UILabel?
    var isNotificationServiceLoaded : Bool  =   false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //   self.title  =   "Feeds"
        
        /*
        if (isFirstTime == false) {
        isFirstTime =   true
        }
        else{
        feedList    =   NSMutableArray()
        isLoadingFinished  =   false
        loadedKeys  =   NSMutableArray()
        kPagingKey  =   ""
        collView?.reloadData()
        getFeedDetails(kPagingKey)
        }
        */
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        feedList    =   NSMutableArray()
        isLoadingFinished  =   false
        loadedKeys  =   NSMutableArray()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(FeedsViewController.menuBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let aButton1     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton1.setImage(UIImage(named: "notification.png"), forState: .Normal)
        aButton1.addTarget(self, action: #selector(FeedsViewController.notificationBtnTapped), forControlEvents: .TouchUpInside)
        
        
        notiMsgCountLbl        =   UILabel(frame: CGRectMake(0, 0, 24  , 24))
        notiMsgCountLbl!.text       =   "0"
        notiMsgCountLbl!.textColor  =   UIColor.blackColor()
        notiMsgCountLbl!.layer.backgroundColor    =   UIColor.yellowColor().CGColor
        notiMsgCountLbl!.layer.borderColor  =   UIColor.whiteColor().CGColor
        notiMsgCountLbl!.layer.borderWidth  =   2.0
        notiMsgCountLbl!.adjustsFontSizeToFitWidth  =   true
        notiMsgCountLbl!.minimumScaleFactor =   0.4
        notiMsgCountLbl!.layer.cornerRadius =   12.0
        notiMsgCountLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        notiMsgCountLbl!.textAlignment  =   .Center
        aButton1.addSubview(notiMsgCountLbl!)
        self.notiMsgCountLbl!.hidden    =   true
        notiMsgCountLbl!.center     =   CGPointMake(28, 0)
        
        
        let aBarButtonItem1  =   UIBarButtonItem(customView: aButton1)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedsViewController.headBtnTapped)))
        
        self.navigationItem.titleView   =   kImgView
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
  
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = kSpac
        layout.minimumInteritemSpacing = kSpac
        
        layout.sectionInset = UIEdgeInsets(top: kSpac, left: kSpac, bottom: kSpac, right: kSpac)
        
        collView = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: layout)
        collView!.dataSource   = self
        collView!.delegate     = self
        collView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collView!.registerClass(FeedCollViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
       
        collView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collView!)
      
        getNotificationMessages()
        getFeedDetails(kPagingKey)
        
    }
    
    func notificationBtnTapped () {
        if (isNotificationServiceLoaded) {
            let msgView =   NotiMsgViewController()
            msgView.messagesList    =   NSArray(array: self.messagesList)
            self.navigationController?.pushViewController(msgView, animated: true)
        }
    }
    
    func getNotificationMessages () {
        
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID()] , forKeys: [kLS_CP_UserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Notification_GetNotificationMessages, parm: dict1, completion: { result , desc , code in
            
            self.isNotificationServiceLoaded =   true
            
            self.notiMsgCountLbl!.frame     =   CGRectMake(0, 0, 0 , 0)
            self.notiMsgCountLbl!.hidden    =   false
            self.notiMsgCountLbl!.center    =   CGPointMake(28, 0)
            
            
            UIView.animateWithDuration(0.40, animations: { () -> Void in
                self.notiMsgCountLbl!.frame     =   CGRectMake(0, 0, 24  , 24)
                self.notiMsgCountLbl!.center    =   CGPointMake(28, 0)
            })
              print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                {
                    isSuccess   =   true
                   
                   
                    let kTempArr : NSMutableArray   =   NSMutableArray()
                    
                    for kDict in (kArr as! NSArray) {
                        let feedObj : NotiMsgObj   =   NotiMsgObj().setDetails(kDict as! NSDictionary)
                        kTempArr.addObject(feedObj)
                    }
                    self.messagesList   =   NSArray(array: kTempArr)
           //         self.collView?.reloadData()
                    
                }
                if (isSuccess == false || self.messagesList.count == 0)
                {
                  //  self.noLbl!.hidden    =   false
                }
            }
            else
            {
                
              //  self.noLbl!.hidden      =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                }
            }
            
            self.notiMsgCountLbl!.text  =   "\(self.messagesList.count)"
        })
        
    }
    
    func getFeedDetails (aKey: NSString) {
        if (isFirstTime == true)
        {
            noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
            noLbl!.text       =   "No feed found."
            noLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            noLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
            noLbl!.textAlignment  =   .Center
            self.view.addSubview(noLbl!)
            self.noLbl!.hidden    =   true
            processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
            self.view.addSubview(processView!)
        }
        
        loadedKeys?.addObject(aKey)
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),aKey] , forKeys: [kLS_CP_userid,kLS_CP_key])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Feed_GetFeeds, parm: dict1, completion: { result , desc , code in
            
            self.processView?.removeFromSuperview()
            
          //  print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                {
                    self.isFirstTime =   false
                    isSuccess   =   true
                    if (result.objectForKey(kLS_CP_key) != nil)
                    {
                        self.kPagingKey         =   (result.objectForKey(kLS_CP_key) as? NSString)!
                    }
                    else
                    {
                        self.isLoadingFinished =   true
                    }
                    
                    if (kArr?.count < 5)
                    {
                        self.isLoadingFinished =   true
                    }
                    let kTempArr : NSMutableArray   =   NSMutableArray()
                    
                    for kDict in (kArr as! NSArray) {
                        let feedObj : FeedObj   =   FeedObj().setDetails(kDict as! NSDictionary, kDelegate: self as FeedObjDelegate, kImgWidth: self.kWidth!)
                        kTempArr.addObject(feedObj)
                    }
                    
                    self.feedList?.addObjectsFromArray(kTempArr as [AnyObject])
                    self.collView?.reloadData()
                    
                    
                }
                if (isSuccess == false)
                {
                    if (self.isFirstTime == true)
                    {
                        self.isFirstTime =   false
                        self.noLbl!.hidden    =   false
                    }
                }
            }
            else
            {
                if (self.isFirstTime == true)
                {
                    self.isFirstTime        =   false
                    self.noLbl!.hidden      =   false
                    if((desc as NSString).isKindOfClass(NSNull) == false)
                    {
                        self.noLbl!.text      =   desc
                    }
                }
            }
        })
    
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func menuBtnTapped () {
        presentLeftMenuViewController()
    }
    func headBtnTapped () {
        NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_HomeHeadTapped, object: nil)
    }
    func feedImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return feedList!.count
    }
 
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let feedObj: FeedObj    =   feedList?.objectAtIndex(indexPath.row) as! FeedObj
        return CGSize(width: feedObj._imgWidth, height: feedObj._imgHeight + 40)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! FeedCollViewCell
        
        let feedObj: FeedObj    =   feedList?.objectAtIndex(indexPath.row) as! FeedObj
        cell.bgImg.frame        =   CGRect(x: 0, y: 0, width: feedObj._imgWidth , height: feedObj._imgHeight)
        cell.bgImg.image        =   UIImage()        
        cell.descLbl!.frame     =  CGRectMake(3, cell.frame.size.height - 40, cell.frame.size.width - 3, 40)
        cell.bgImg.image        =   UIImage()
        cell.backgroundColor    =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        cell.descLbl?.text      =   (feedObj._StoryName as String).uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        cell.processView?.hidden    =   false
        if (feedObj._isThumbImgDownloadIntiated == false)
        {
            feedObj.downloadThumbImg()
        }
        if ((feedObj._isThumbImgDownloadIntiated) == true && (feedObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   feedObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        if ((loadedKeys?.containsObject(kPagingKey) == false) && (isLoadingFinished == false) && (indexPath.row == feedList!.count-5))
        {
            self.getFeedDetails(self.kPagingKey)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let feedView    =   FeedViewVC()
        feedView.feedObj      =   feedList?.objectAtIndex(indexPath.row) as? FeedObj
        self.navigationController?.pushViewController(feedView, animated: true)
    }
    
}

class FeedCollViewCell: UICollectionViewCell {
    
    var bgImg: UIImageView!
    var descLbl : UILabel?
    var feedObj: FeedObj?
    var processView : ImageLoadProcessView?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height)
        
        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor   =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.addSubview(bgImg)
        
        descLbl  =   UILabel(frame: CGRectMake(3, frame.size.height - 40, frame.size.width - 3, 40))
        descLbl!.text       =   ""
        descLbl!.font       =   UIFont.boldSystemFontOfSize(16)
        descLbl!.numberOfLines  =   0
        descLbl!.textColor  =   UIColor.blackColor()
        descLbl!.textAlignment  =   NSTextAlignment.Center
        contentView.addSubview(descLbl!)
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView!)
    }
}

class FeedViewVC: UIViewController, TLSSegmentViewDelegate
{
    var feedObj : FeedObj?
    var segmentedControl: TLSSegmentView!
    var seletionBar: UIView = UIView()
    var contentView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(FeedViewVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
     
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   feedObj?._StoryName.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
    
        
        contentView     =   UIView(frame: CGRectMake(0,50.0,self.view.frame.size.width, self.view.frame.size.height - 50.0 - 64.0))
        contentView?.backgroundColor    =   UIColor.whiteColor()
        self.view.addSubview(contentView!)
        
        segmentedControl    =   TLSSegmentView(frame: CGRectMake(0, 0, self.view.frame.size.width, 50), textColor: UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1), selectedTextColor: UIColor.blackColor(), textFont: UIFont(name: Gillsans.Default.description, size: 15.0)!)
        segmentedControl.delegate = self
        segmentedControl.addSegments(["STORY","BEHIND THE SCENES","CREDIT"])
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
    
    func segementSelected (segment : TLSSegment, index : Int) {
        
        UIView.animateWithDuration(0.2, animations: {
            self.seletionBar.frame = CGRectMake(segment.frame.origin.x, self.seletionBar.frame.origin.y, segment.frame.size.width, self.seletionBar.frame.size.height)
        })
        
        for kView in (contentView?.subviews)! {
            kView.removeFromSuperview()
        }
        
        switch index {
        case 0:
            let stryView            =   StoryView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            stryView.coverImg       =   self.feedObj?._coverImg
            stryView.storyID        =   self.feedObj?._StoryId
            stryView.viewController =   self
            contentView?.addSubview(stryView)
            stryView.loadDetails()
        case 1:
            let stryView            =   BehindTheSceneView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            stryView.coverImg       =   self.feedObj?._coverImg
            stryView.storyID        =   self.feedObj?._StoryId
            stryView.viewController =   self
            contentView?.addSubview(stryView)
            stryView.loadDetails()
            break
        default:
            let stryView         =   CreditsView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            stryView.storyID    =   self.feedObj?._StoryId
            contentView?.addSubview(stryView)
            stryView.loadDetails()
            break
        }
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
 
}

class StoryView: UIView, FeedObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    var storyObjects : NSArray = NSArray()
    var storyID : NSString?
    var coverImg: NSString?
    var collView: UICollectionView?
    var viewController : UIViewController?
    var kWidth : CGFloat?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.frame.size.width - (3 * kSpac)) / 2
        
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = kSpac
        layout.minimumInteritemSpacing = kSpac
        
        layout.sectionInset = UIEdgeInsets(top: kSpac, left: kSpac, bottom: kSpac, right: kSpac)
        
        collView = UICollectionView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), collectionViewLayout: layout)
        collView!.dataSource   = self
        collView!.delegate     = self
        collView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collView!.registerClass(StoryViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        //  collView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collView!.backgroundColor = UIColor.whiteColor()
        self.addSubview(collView!)
    }
    
    func loadDetails () {
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),storyID!,coverImg!] , forKeys: [kLS_CP_UserId,kLS_CP_StoryId,kLS_CP_FileName])
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No story found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        
        noLbl.hidden    =   true
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ViewStory_GetViewStory, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                {
                    isSuccess   =   true
                    let kTempArr : NSMutableArray   =   NSMutableArray()

                    for kDict in (kArr as! NSArray) {
                        
                        let storyObj : ViewStoryObj   =   ViewStoryObj().setDetails(kDict as! NSDictionary, kDelegate: self as FeedObjDelegate, kImgWidth: self.kWidth!)
                
                        if (storyObj._isBigImage == true)
                        {
                            kTempArr.insertObject(storyObj, atIndex: 0)
                        }
                        else
                        {
                            kTempArr.addObject(storyObj)
                        }
                        
                    }
                    
                    self.storyObjects   =   NSArray(array: kTempArr)
                }
                
                if (isSuccess == false || self.storyObjects.count == 0)
                {
                    noLbl.hidden    =   false
                }
            }
            else
            {
                noLbl.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                }
            }
            self.collView?.reloadData()
            
        })
    }
    
    func feedImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (storyObjects.count > 0)
        {
            if (section == 0) { return 1 }
            return storyObjects.count - 1
        }
        else { return 0 }
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        var storyObj: ViewStoryObj?
        if (indexPath.section == 0)
        {
            storyObj    =   storyObjects.objectAtIndex(indexPath.row) as? ViewStoryObj
        }
        else
        {
            storyObj    =   storyObjects.objectAtIndex(indexPath.row + 1) as? ViewStoryObj
            
        }
        
        return CGSize(width: storyObj!._imgWidth, height: storyObj!._imgHeight)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        
        if (section == 0) { return 1 }
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! StoryViewCell
        var storyObj: ViewStoryObj?
        if (indexPath.section == 0)
        {
            storyObj    =   storyObjects.objectAtIndex(indexPath.row) as? ViewStoryObj
        }
        else
        {
            storyObj    =   storyObjects.objectAtIndex(indexPath.row + 1) as? ViewStoryObj
        }
        
        cell.storyObj   =   storyObj
        cell.bgImg.frame    =   CGRect(x: 0, y: 0, width: storyObj!._imgWidth , height: storyObj!._imgHeight)
        cell.bgImg.image    =   UIImage()
        cell.processView?.hidden    =   false
        
        if (storyObj!._isThumbImgDownloadIntiated == false)
        {
            storyObj!.downloadThumbImg()
        }
        if ((storyObj!._isThumbImgDownloadIntiated) == true && (storyObj!._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   storyObj!._thumbImg
            cell.processView?.hidden    =   true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell    =   collectionView.cellForItemAtIndexPath(indexPath)
       
        let frame   =   cell?.superview!.convertRect((cell?.frame)!, toView: nil)
        
        let fullimgview             =   FullImageController()
        if (indexPath.section == 0)
        {
            fullimgview.index   =   0
        }
        else
        {
            fullimgview.index   =   indexPath.row + 1
        }
        fullimgview.kScreenshot     =   screenShot()
        fullimgview.storyID         =   self.storyID
        fullimgview.kFrame          =   frame
        fullimgview.pageObjects     =   NSArray(array: self.storyObjects)
        self.viewController?.navigationController?.pushViewController(fullimgview, animated: false)
        
    }
}

class StoryViewCell: UICollectionViewCell  {
    
    var bgImg: UIImageView!
    var storyObj : ViewStoryObj?
    var processView : ImageLoadProcessView?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height)

        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor   =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        contentView.addSubview(bgImg)
        
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView!)
    }
}

class BehindTheSceneView: UIView, FeedObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    var storyObjects : NSArray = NSArray()
    var storyID : NSString?
    var coverImg: NSString?
    var collView: UICollectionView?
    var viewController : UIViewController?
    var kWidth : CGFloat?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.frame.size.width - (3 * kSpac)) / 2
        
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = kSpac
        layout.minimumInteritemSpacing = kSpac
        
        layout.sectionInset = UIEdgeInsets(top: kSpac, left: kSpac, bottom: kSpac, right: kSpac)
        
        collView = UICollectionView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), collectionViewLayout: layout)
        collView!.dataSource   = self
        collView!.delegate     = self
        collView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collView!.registerClass(StoryViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        //  collView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collView!.backgroundColor = UIColor.whiteColor()
        self.addSubview(collView!)
    }
    
    func loadDetails () {
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),storyID!,coverImg!] , forKeys: [kLS_CP_UserId,kLS_CP_StoryId,kLS_CP_FileName])
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No story found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        
        noLbl.hidden    =   true
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ViewStory_GetBehindTheSceneMedia, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                {
                    isSuccess   =   true
                    let kTempArr : NSMutableArray   =   NSMutableArray()
                    
                    for kDict in (kArr as! NSArray) {
                        
                        let storyObj : ViewStoryObj   =   ViewStoryObj().setDetails(kDict as! NSDictionary, kDelegate: self as FeedObjDelegate, kImgWidth: self.kWidth!)
                        
                        if (storyObj._isBigImage == true)
                        {
                            kTempArr.insertObject(storyObj, atIndex: 0)
                        }
                        else
                        {
                            kTempArr.addObject(storyObj)
                        }
                    }
                    
                    self.storyObjects   =   NSArray(array: kTempArr)
                }
                
                if (isSuccess == false || self.storyObjects.count == 0)
                {
                    noLbl.hidden    =   false
                }
            }
            else
            {
                noLbl.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                }
            }
            self.collView?.reloadData()
        })
    }
    
    func feedImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return storyObjects.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let storyObj: ViewStoryObj      =   (storyObjects.objectAtIndex(indexPath.row) as? ViewStoryObj)!
        
        return CGSize(width: storyObj._imgWidth, height: storyObj._imgHeight)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! StoryViewCell
        let storyObj: ViewStoryObj      =   (storyObjects.objectAtIndex(indexPath.row) as? ViewStoryObj)!
       
        
        cell.storyObj   =   storyObj
        cell.bgImg.frame    =   CGRect(x: 0, y: 0, width: storyObj._imgWidth , height: storyObj._imgHeight)
        cell.bgImg.image    =   UIImage()
        cell.processView?.hidden    =   false
        
        if (storyObj._isThumbImgDownloadIntiated == false)
        {
            storyObj.downloadThumbImg()
        }
        if ((storyObj._isThumbImgDownloadIntiated) == true && (storyObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   storyObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell    =   collectionView.cellForItemAtIndexPath(indexPath)
        
        let frame   =   cell?.superview!.convertRect((cell?.frame)!, toView: nil)
        
        let fullimgview             =   FullImageController()
        fullimgview.storyID         =   self.storyID
        fullimgview.index           =   indexPath.row
        fullimgview.kScreenshot     =   screenShot()
        fullimgview.kFrame          =   frame
        fullimgview.pageObjects     =   NSArray(array: self.storyObjects)
        self.viewController?.navigationController?.pushViewController(fullimgview, animated: false)
    }
}


class CreditsView: UIView, UITableViewDelegate, UITableViewDataSource
{
    var tbleView: UITableView?
    var keysArray : NSArray     =   NSArray()
    var objectsDict : NSDictionary  =   NSDictionary()
    var storyID : NSString?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
        
        tbleView    =   UITableView(frame: CGRectMake(0, 0 , self.frame.size.width, self.frame.size.height), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
        tbleView?.alwaysBounceVertical =   false
        tbleView?.separatorStyle    =   .None
        self.addSubview(tbleView!)
    }
    
    func loadDetails () {
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),storyID!] , forKeys: [kLS_CP_UserId,kLS_CP_StoryId])
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No credit found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        
        noLbl.hidden    =   true
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Story_GetStoryCredits, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                {
                    isSuccess   =   true
                    let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_ArtistName as String, ascending: true)
                    let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                    
                    let kTempArr : NSMutableArray       =   NSMutableArray()
                    let kTempDict : NSMutableDictionary =   NSMutableDictionary()
                    for kDict in sortedArray {
                        
                        let creditObj : CreditObj   =   CreditObj().setDetails(kDict as! NSDictionary)
                        if (kTempArr.containsObject(creditObj._SpecialityDesc) == false)
                        {
                            kTempArr.addObject(creditObj._SpecialityDesc)
                            kTempDict.setObject(NSMutableArray(object: creditObj), forKey: creditObj._SpecialityDesc)
                        }
                        else
                        {
                            kTempDict.objectForKey(creditObj._SpecialityDesc)?.addObject(creditObj)
                        }
                    }
                    
                    self.keysArray   =   NSArray(array: kTempArr.sortedArrayUsingSelector(#selector(NSNumber.compare(_:))))
                    self.objectsDict    =   NSDictionary(dictionary: kTempDict)
                }
                
                if (isSuccess == false || self.keysArray.count == 0)
                {
                    noLbl.hidden    =   false
                }
            }
            else
            {
                noLbl.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                }
            }
            self.tbleView?.reloadData()
            
        })
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 60)
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        let CiLbl : UILabel     =   UILabel(frame: CGRectMake(20, 20, self.frame.size.width - 30, 40))
        CiLbl.text              =   self.keysArray.objectAtIndex(section).uppercaseString
        CiLbl.textAlignment     =   NSTextAlignment.Left
        CiLbl.font              =   UIFont(name: Gillsans.Default.description, size: 15.0)
        CiLbl.textColor         =   UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1)
        customView.addSubview(CiLbl)
        return customView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.keysArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.objectsDict.objectForKey(self.keysArray.objectAtIndex(section)) as? NSMutableArray)?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        cell.selectionStyle     =   .None
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        let descLbl             =   UILabel(frame: CGRectMake(20,0, self.frame.size.width - 30 , 40))
        descLbl.text            =   ((self.objectsDict.objectForKey(self.keysArray.objectAtIndex(indexPath.section)) as? NSMutableArray)?.objectAtIndex(indexPath.row) as? CreditObj)!._ArtistName.uppercaseString
        descLbl.textColor       =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment   =   .Left
        cell.addSubview(descLbl)
        
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
}


class FullImageController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageObjects: NSArray!
    var kScreenshot : UIImage?
    var storyID : NSString?
    var index : Int?
    var kFrame : CGRect?
    var isFirstTime = true
    var imageView : UIImageView?
    var winkitBtn : UIButton?
    var isWink : Bool    =   false
    
    func closeBtnTapped () {
        
        self.navigationController?.navigationBarHidden  =   false
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    func winkitBtnTapped () {
        let winkitVC : WinkItController =   WinkItController ()
        if (isWink) {
            winkitVC.winkObj   =   self.pageObjects.objectAtIndex(index!) as? WinkImgObj
            winkitVC.isWink     =   true
        }
        else {
            winkitVC.storyObj   =   self.pageObjects.objectAtIndex(index!) as? ViewStoryObj
        }
        
        winkitVC.storyId    =   self.storyID
        self.navigationController?.pushViewController(winkitVC, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden  =   true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden  =   true
        imageView  =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.view.addSubview(imageView!)
        imageView!.image =   kScreenshot
        
        
        
        UIView.animateWithDuration(0.60) { () -> Void in
            self.imageView!.alpha =   0
            self.imageView!.frame.size.width  =   self.imageView!.frame.size.width - 30
            self.imageView!.frame.size.height =   self.imageView!.frame.size.height * ((self.imageView!.frame.size.width - 30) / self.imageView!.frame.size.width)
            self.imageView!.center    =   self.view.center
        }
        
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(index!) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame          =   CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        let aButton     =   UIButton(frame: CGRectMake(self.view.frame.size.width - 50, 20, 40, 40))
        aButton.setImage(UIImage(named: "cross.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(FullImageController.closeBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        winkitBtn     =   UIButton(frame: CGRectMake(20, 20, 120, 32))
        winkitBtn!.setImage(getButtonImage("WINK IT", kWidth: 120.0 * 2.0, kHeight: 64.0, kFont: UIFont(name: Gillsans.Default.description, size: 34.0)!), forState: .Normal)
        winkitBtn!.addTarget(self, action: #selector(FullImageController.winkitBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(winkitBtn!)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartAction(sender: AnyObject)
    {
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        if ((self.pageObjects.count == 0) || (index >= self.pageObjects.count)) {
            return ContentViewController()
        }
        
        let vc: ContentViewController = ContentViewController()
        if (isFirstTime)
        {
            vc.kFrame       =   self.kFrame
            isFirstTime     =   false
        }
        else
        {
            vc.kFrame       =   CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        }
        
        
        vc.pageIndex    =   index
        
        if (isWink) {
            vc.winkObj     = self.pageObjects[index] as! WinkImgObj
            vc.isWink       =   true
            return vc
        }
        
        vc.storyObj     =   self.pageObjects[index] as! ViewStoryObj
        
        return vc

    }
    
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        
        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        
        index -= 1
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound)
        {
            return nil
        }
        
        index += 1
        
        if (index == self.pageObjects.count)
        {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }

}


class ContentViewController: UIViewController, FeedObjDelegate , WinkImgObjDelegate , UIScrollViewDelegate{
    
    var imageView: UIImageView!
    var pageIndex: Int!
    var storyObj: ViewStoryObj!
    var scrollView : UIScrollView!
    var winkObj : WinkImgObj!
    var isWink : Bool   =   false
    var kFrame : CGRect?
    var processView : ProcessView?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
        
        if (isWink) {
            winkObj._delegate   =   self
            if (winkObj._isImgDownloadIntiated == false)
            {
                winkObj.downloadImg()
            }
            if (winkObj._isThumbImgDownloaded == true)
            {
                imageView.image    =   winkObj._thumbImg
            }
            
            if (winkObj._isImgDownloaded == true)
            {
                processView?.removeFromSuperview()
                imageView.image     =   winkObj._Img
            }
        }
        else {
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
        }
        
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
    
    func ImageDownloadReqFinished () {
        processView?.removeFromSuperview()
        imageView.image    =   winkObj._Img
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}

class NotiMsgViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messagesList : NSArray  =   NSArray()
    var tbleView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(FeedViewVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "Notifications".uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
      
        
        tbleView    =   UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
        tbleView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tbleView!)
        
        if (messagesList.count == 0)
        {
            let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
            noLbl.text       =   "No notification found."
            noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
            noLbl.textAlignment  =   .Center
            self.view.addSubview(noLbl)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
        let specObj    =   (messagesList.objectAtIndex(indexPath.row) as? NotiMsgObj)!
        let height = heightForView(specObj._notificationMessage as String, font: UIFont(name: Gillsans.Default.description, size: 16.0)!, width: self.view.frame.size.width - 40 )
        
        return height + 30
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        cell.selectionStyle     =   .None
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        
        let specObj    =   (messagesList.objectAtIndex(indexPath.row) as? NotiMsgObj)!
        
       let height = heightForView(specObj._notificationMessage as String, font: UIFont(name: Gillsans.Default.description, size: 16.0)!, width: self.view.frame.size.width - 40 )
        cell.backgroundColor = UIColor.whiteColor()
        
        let descLbl        =   UILabel(frame: CGRectMake(20,0, self.view.frame.size.width - 40 , height + 30))
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 16.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        descLbl.text    =   specObj._notificationMessage as String
        
        let sepImg1      =   UIImageView(frame: CGRectMake(0, height + 29, self.view.frame.size.width, 1))
        sepImg1.backgroundColor  =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        cell.addSubview(sepImg1)
        
        return cell
    }

}