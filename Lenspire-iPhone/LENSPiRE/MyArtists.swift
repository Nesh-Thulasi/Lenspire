//
//  MyArtists.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 28/12/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation


class MyArtistViewController: UIViewController, LinkedArtistObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout{
    
    var usersList : NSArray?
    var collView: UICollectionView?
    var kWidth : CGFloat?
    var processView : ProcessView?
    var noLbl : UILabel?
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        usersList    =   NSMutableArray()

        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(MyArtistViewController.menuBtnTapped), forControlEvents: .TouchUpInside)
        
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(MyArtistViewController.headBtnTapped)))
        
        self.navigationItem.titleView   =   kImgView
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyArtistViewController.profileUpdated(_:)), name: kLS_Noti_ArtistProfileUpdated, object: nil)
        
        loadDetails()
    }
        
    func profileUpdated (notification: NSNotification) {
        
        loadDetails()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func loadDetails () {
        
        for kView in self.view.subviews {
            kView.removeFromSuperview()
        }
        
        self.usersList  =   NSArray()
        self.collView?.reloadData()
        
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
        collView!.registerClass(MyArtistViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        collView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collView!)
        
        noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl!.text       =   "No artist found."
        noLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl!.textAlignment  =   .Center
        self.view.addSubview(noLbl!)
        self.noLbl!.hidden    =   true
        processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView!)
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),getUserID()] , forKeys: [kLS_CP_UserId,kLS_CP_ArtistId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_UserProfile_GetLinkedUsersList, parm: dict1, completion: { result , desc , code in
            
            self.processView?.removeFromSuperview()
            
            print(result)
            var isSuccess : Bool =    false
            if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
            {
                
                let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                
                if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true && (kArr as! NSArray).count > 0)
                {
                    isSuccess   =   true
                    
                    let kTempArr : NSMutableArray   =   NSMutableArray()
                    
                    for kDict in (kArr as! NSArray) {
                        let linkUserObj : LinkedArtistObj   =   LinkedArtistObj().setDetails(kDict as! NSDictionary, kDelegate: self)
                        kTempArr.addObject(linkUserObj)
                    }
                    
                    self.usersList  =   NSArray(array:kTempArr)
                    self.collView?.reloadData()
                    
                }
                if (isSuccess == false)
                {
                    self.noLbl!.hidden    =   false
                }
            }
            else
            {
                
                self.noLbl!.hidden      =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    self.noLbl!.text      =   desc
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
    func ImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return usersList!.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        return CGSize(width: kWidth!, height: (kWidth! / 2.0) + 30 + 40)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! MyArtistViewCell
        
        let linkUserObj : LinkedArtistObj    =   usersList?.objectAtIndex(indexPath.row) as! LinkedArtistObj
        cell.bgImg.frame        =   CGRect(x: 0, y: 20, width: kWidth! / 2.0 , height: kWidth! / 2.0)
        cell.bgImg.layer.cornerRadius    =   kWidth! / 4.0
        cell.bgImg.image        =   UIImage()
        cell.descLbl!.frame     =  CGRectMake(3, cell.frame.size.height - 40, cell.frame.size.width - 5, 40)
        cell.backgroundColor    =   UIColor.clearColor()
        cell.descLbl?.text      =   linkUserObj._ArtistName.uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        
        cell.bgImg.center.x       =   kWidth! / 2.0
        
        if (linkUserObj._isThumbImgDownloadIntiated == false)
        {
            linkUserObj.downloadThumbImg()
        }
        if ((linkUserObj._isThumbImgDownloadIntiated) == true && (linkUserObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   linkUserObj._thumbImg
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let artistView            =   ArtistDetailViewController()
        artistView.artistObj      =   usersList?.objectAtIndex(indexPath.row) as? LinkedArtistObj
        self.navigationController?.pushViewController(artistView, animated: true)
    }
    
}

class MyArtistViewCell: UICollectionViewCell {
    
    var bgImg: UIImageView!
    var descLbl : UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height)
        
        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor       =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        bgImg.layer.masksToBounds   =   true
        bgImg.layer.borderWidth     =   1.0
        bgImg.contentMode           =   .ScaleAspectFit
        bgImg.layer.borderColor     =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1).CGColor
        contentView.addSubview(bgImg)
        
        descLbl  =   UILabel(frame: CGRectMake(3, frame.size.height - 40, frame.size.width - 5, 40))
        descLbl!.text       =   ""
        descLbl!.font       =   UIFont.boldSystemFontOfSize(16)
        descLbl!.numberOfLines  =   0
        descLbl!.textColor  =   UIColor.blackColor()
        descLbl!.textAlignment  =   NSTextAlignment.Center
        contentView.addSubview(descLbl!)
    }
}

class ArtistViewCell: UICollectionViewCell {
    
    var bgImg: UIImageView!
    var descLbl : UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height)
        
        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor       =   UIColor.clearColor()
        bgImg.contentMode           =   .ScaleAspectFit
        contentView.addSubview(bgImg)
        
        descLbl  =   UILabel(frame: CGRectMake(3, frame.size.height - 40, frame.size.width - 5, 40))
        descLbl!.text       =   ""
        descLbl!.font       =   UIFont.boldSystemFontOfSize(16)
        descLbl!.numberOfLines  =   0
        descLbl!.textColor  =   UIColor.blackColor()
        descLbl!.textAlignment  =   NSTextAlignment.Center
        contentView.addSubview(descLbl!)
    }
}


class ArtistDetailViewController: UIViewController , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout{
    
    var usersList : NSMutableArray?
    var collView: UICollectionView?
    var kWidth : CGFloat?
    var artistObj : LinkedArtistObj!
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        usersList    =   [[ "title" :   "production book",
            "image" :   "pbIcon.png"],
            [ "title" :   "profile",
                "image" :   "profileA.png"],
            [ "title" :   "portfolio",
                "image" :   "portfolioblck.png"]]
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(ArtistDetailViewController.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   artistObj._ArtistName.uppercaseString
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
        collView!.registerClass(ArtistViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        collView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collView!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    // MARK: - Collectionview Handlers -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return usersList!.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        return CGSize(width: kWidth!, height: (kWidth! / 2.0) + 30 + 40)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! ArtistViewCell
        
        let kImg        =   usersList?.objectAtIndex(indexPath.row).objectForKey("image") as? String
        let kTitle      =   usersList?.objectAtIndex(indexPath.row).objectForKey("title") as? String
        
        cell.bgImg.frame        =   CGRect(x: 0, y: 20, width: kWidth! / 2.0 , height: kWidth! / 2.0)
        cell.bgImg.image        =   UIImage(named: kImg!)
        cell.descLbl!.frame     =  CGRectMake(3, cell.frame.size.height - 40, cell.frame.size.width - 5, 40)
        cell.backgroundColor    =   UIColor.clearColor()
        cell.descLbl?.text      =   kTitle!.uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        
        cell.bgImg.center.x       =   kWidth! / 2.0
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0)
        {
            let prodListView            =   ProductionbookListVC()
            prodListView.kArtistID      =   artistObj._ArtistId as String
            prodListView.kArtistName    =   artistObj._ArtistName as String
            self.navigationController?.pushViewController(prodListView, animated: true)
        }
        else if (indexPath.row == 1)
        {
//            MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
            let profile            =   ProfileVC()
            if (artistObj._ArtistAgentStatus.isEqualToString("1"))
            {
                profile.isArtistEditable    =   true
            }
            profile.kArtistID      =   artistObj._ArtistId as String
            profile.kArtistName    =   artistObj._ArtistName as String
            self.navigationController?.pushViewController(profile, animated: true)
            
        }
        else if (indexPath.row == 2) {
            let prodListView            =   PortfolioListVC()
            prodListView.kArtistID      =   artistObj._ArtistId as String
            prodListView.kArtistName    =   artistObj._ArtistName as String
            self.navigationController?.pushViewController(prodListView, animated: true)
        }
    }
    
}

