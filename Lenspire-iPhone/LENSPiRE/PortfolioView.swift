//
//  PortfolioView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 11/11/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation

class PortfolioListVC: UIViewController , UITableViewDelegate, UITableViewDataSource, FeedObjDelegate {
    
    var tbleView: UITableView?
    var keysArray: NSArray?
    var kWidth : CGFloat?
    var detailsDict : NSDictionary?
    var refreshControl = UIRefreshControl()
    var processView : ProcessView?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var noLbl : UILabel?
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        self.keysArray  =   NSArray()

        
        if (kArtistID == "")
        {
            let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
            aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
            aButton.addTarget(self, action: #selector(PortfolioListVC.menuBtnTapped), forControlEvents: .TouchUpInside)
            
            
            let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
            self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
            
            let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
            kImgView.image  =   UIImage(named: "lenspire-logo.png")
            kImgView.userInteractionEnabled =   true
            kImgView.contentMode    =   .ScaleAspectFit
            kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PortfolioListVC.headBtnTapped)))
            
            self.navigationItem.titleView   =   kImgView
     
            
        }
        else
        {
            let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
            aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
            aButton.addTarget(self, action: #selector(PortfolioListVC.backBtnTapped), forControlEvents: .TouchUpInside)
            
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
        
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let kStartPoint: CGFloat    =   self.navigationController!.navigationBar.frame.size.height + 20.0
        
        tbleView    =   UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kStartPoint), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(PortfolioListVC.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let tableViewController     =   UITableViewController(style: .Plain)
        self.addChildViewController(tableViewController)
        tableViewController.refreshControl  =   self.refreshControl
        tableViewController.tableView   =   tbleView
        self.view.addSubview(tableViewController.tableView)
        
        noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl!.text       =   "No portfolio found."
        noLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl!.textAlignment  =   .Center
        self.view.addSubview(noLbl!)
        self.noLbl!.hidden    =   true
        processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView!)
        
        self.loadObjectsDetails()
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadObjectsDetails () {
        
        self.noLbl?.hidden      =   true
        
        var kTempId =   ""
        if (kArtistID == "") {
            kTempId =   getUserID() as String
        }
        else {
            kTempId =   kArtistID
        }
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kTempId] , forKeys: [kLS_CP_UserId,kLS_CP_PortfolioUserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Story_GetUserPortfolioList, parm: dict1, completion: { result , desc , code in
            self.processView!.removeFromSuperview()
            self.keysArray  = NSArray()
            if ( code == 99)
            {
                print("\(result)")
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        isSuccess   =   true
                        let kArr: AnyObject?   =   result .objectForKey(kLS_CP_result)
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true)
                        {
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_PortfolioName as String, ascending: true)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                            
                            let kKeysArr: NSMutableArray            =   NSMutableArray()


                            for  kDictionary in sortedArray {
                                let callSheet: PortfolioGroupObj    =   PortfolioGroupObj().setDetails(kDictionary as! NSDictionary)
                                if (kKeysArr.containsObject(callSheet) == false)
                                {

                                    kKeysArr.addObject(callSheet)
                                }
                            }
                            
                            self.keysArray      =   NSArray(array: kKeysArr)
                            self.loadedIndexes  =   NSMutableArray()
                        }
                    }
                }
                if (isSuccess == false || self.keysArray?.count == 0)
                {
                    self.noLbl!.hidden    =   false
                }
            }
            else
            {
                self.noLbl!.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    self.noLbl!.text      =   desc
                }
            }
            
            
            let updateString = "Last Updated at \(dateforRefreshDisplay())"
            self.refreshControl.attributedTitle = NSAttributedString(string: updateString)
            if self.refreshControl.refreshing
            {
                self.refreshControl.endRefreshing()
            }
            self.tbleView?.reloadData()
        })
        
    }
    
    func refresh(sender:AnyObject) {
        self.loadObjectsDetails()
    }
    
    func headBtnTapped () {
        NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_HomeHeadTapped, object: nil)
    }
    func feedImageDownloadReqFinished () {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keysArray!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        
//        let callSheet: CallSheet    =   (self.detailsDict?.objectForKey((self.keysArray?.objectAtIndex(indexPath.section))!)?.objectAtIndex(indexPath.row))! as! CallSheet
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        let descLbl        =   UILabel(frame: CGRectMake(20,0, self.view.frame.size.width - 30 , 50))
        descLbl.text       =   (self.keysArray?.objectAtIndex(indexPath.row) as? PortfolioGroupObj)?._PortfolioName.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        let sepImg      =   UIImageView(frame: CGRectMake(0, 49, self.view.frame.size.width, 1))
        sepImg.image    =   UIImage(named: "dotted-line.png")
        cell.addSubview(sepImg)
        
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
        
        let prodBook    =   PortfolioDetailsController()
        prodBook.portfolioId      =   ((self.keysArray?.objectAtIndex(indexPath.row) as? PortfolioGroupObj)?._PortfolioId)! as String
        prodBook.kTitle =   ((self.keysArray?.objectAtIndex(indexPath.row) as? PortfolioGroupObj)?._PortfolioName.uppercaseString)!
        prodBook.kArtistID  =   self.kArtistID
        prodBook.kArtistName    =   self.kArtistName
        self.navigationController?.pushViewController(prodBook, animated: true)
        
    }
    func menuBtnTapped () {
        presentLeftMenuViewController()
    }
}

class PortfolioDetailsController: UIViewController, FeedObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout{
    
    var collView: UICollectionView?
    var kWidth : CGFloat?
    var portObjs : NSArray  =   NSArray()
    var portfolioId : String    =   ""
    var kTitle : String =   ""
    
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
 
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(PortfolioListVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        

        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   kTitle.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
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
        
        loadDetails()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func loadDetails () {
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No story found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        var kTempId =   ""
        if (kArtistID == "") {
            kTempId =   getUserID() as String
        }
        else {
            kTempId =   kArtistID
        }
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kTempId,self.portfolioId] , forKeys: [kLS_CP_UserId,kLS_CP_StoryUserId,kLS_CP_PortfolioId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Story_GetStoryListByPortfolio, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        isSuccess   =   true
                        let kArr: AnyObject?   =   result .objectForKey(kLS_CP_result)
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true)
                        {
                         
                            let kKeysArr: NSMutableArray            =   NSMutableArray()
                            
                            for  kDictionary in kArr as! NSArray {
                                let callSheet: PortfolioObj    =   PortfolioObj().setDetails(kDictionary as! NSDictionary, kDelegate: self as FeedObjDelegate, kImgWidth: self.kWidth!)
                               
                                    kKeysArr.addObject(callSheet)
                                
                            }
                            
                            self.portObjs    =   NSArray(array: kKeysArr)
                        }
                    }
                }
                if (isSuccess == false || self.portObjs.count == 0)
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

    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func feedImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return portObjs.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let portObj: PortfolioObj    =   portObjs.objectAtIndex(indexPath.row) as! PortfolioObj
        return CGSize(width: portObj._imgWidth, height: portObj._imgHeight + 40)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! FeedCollViewCell
        
        let portObj: PortfolioObj    =   portObjs.objectAtIndex(indexPath.row) as! PortfolioObj
        portObj._delegate       =   self
        cell.bgImg.frame        =   CGRect(x: 0, y: 0, width: portObj._imgWidth , height: portObj._imgHeight)
        cell.bgImg.image        =   UIImage()
        cell.descLbl!.frame     =  CGRectMake(3, cell.frame.size.height - 40, cell.frame.size.width - 3, 40)
        cell.backgroundColor    =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        cell.descLbl?.text      =   (portObj._Name as String).uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        cell.processView?.hidden    =   false
        if (portObj._isThumbImgDownloadIntiated == false)
        {
            portObj.downloadThumbImg()
        }
        if ((portObj._isThumbImgDownloadIntiated) == true && (portObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   portObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let feedView    =   PortDescVC()
        feedView.portObj      =   portObjs.objectAtIndex(indexPath.row) as? PortfolioObj
        self.navigationController?.pushViewController(feedView, animated: true)
    }
    
}

class PortDescVC: UIViewController, TLSSegmentViewDelegate
{
    var portObj : PortfolioObj?
    var segmentedControl: TLSSegmentView!
    var seletionBar: UIView = UIView()
    var contentView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(PortfolioListVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
   
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   portObj?._Name.uppercaseString
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
            stryView.coverImg       =   self.portObj?._CoverImg
            stryView.storyID        =   self.portObj?._StoryId
            stryView.viewController =   self
            contentView?.addSubview(stryView)
            stryView.loadDetails()
        case 1:
            let stryView            =   BehindTheSceneView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            stryView.viewController =   self
            stryView.coverImg       =   self.portObj?._CoverImg
            stryView.storyID        =   self.portObj?._StoryId
            contentView?.addSubview(stryView)
            stryView.loadDetails()
            break
        default:
            let stryView         =   CreditsView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            stryView.storyID    =   self.portObj?._StoryId
            contentView?.addSubview(stryView)
            stryView.loadDetails()
            break
        }
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}


