//
//  Winkboard.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 18/11/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation

// MARK: - WinkboardViewCellDelegate -
protocol WinkboardViewCellDelegate {
 //   func editTapped (kWinkObj:WinkBoardListObj)
}

class WinkboardViewCell: UICollectionViewCell  {
    
    var bgImg: UIImageView!
    var winkLbl : UILabel?
    var editBtn : UIButton?
    var  delegate   : WinkboardViewCellDelegate?
    var winkObj: WinkBoardListObj?
    var processView : ImageLoadProcessView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height - 40)
        
        winkLbl  =   UILabel(frame: CGRectMake(3, frame.size.height - 40, frame.size.width - 6, 40))
        winkLbl!.text       =   ""
        winkLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        winkLbl!.numberOfLines  =   0
        winkLbl!.textColor  =   UIColor.blackColor()
        winkLbl!.textAlignment  =   NSTextAlignment.Center
        contentView.addSubview(winkLbl!)
        
        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor   =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.addSubview(bgImg)
        
        editBtn     =   UIButton(type: UIButtonType.Custom)
        editBtn!.frame      =   CGRectMake(frame.size.width - 36, frame.size.height - 40 - 36, 32, 32)
        editBtn!.setImage(UIImage(named: "edit.png"), forState: UIControlState.Normal)
     //   editBtn!.addTarget(self, action: "editWinkBoard", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(editBtn!)
        editBtn!.autoresizingMask  =   [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleBottomMargin]
        
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView!)
    }
    
    func editWinkBoard () {
     //   delegate?.editTapped(winkObj!)
    }
}


class WinkBoardController: UIViewController, WinkBoardListObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout , UIActionSheetDelegate, WinkboardViewCellDelegate{
    
    var processView : ProcessView?
    var noLbl : UILabel?
    var winkObjects : NSArray = NSArray()
    var collView: UICollectionView?
    var kWidth : CGFloat?
    let kImgBorder : CGFloat    = 2.0
    var isFirstTime : Bool  =   false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /*
        self.title  =   "Wink Board"
        if (isFirstTime == false) {
        isFirstTime =   true
        }
        else{
        loadWinkBoardObjects()
        }
        */
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(WinkBoardController.menuBtnTapped), forControlEvents: .TouchUpInside)
        
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(WinkBoardController.headBtnTapped)))
        
        self.navigationItem.titleView   =   kImgView
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = kSpac
        layout.minimumInteritemSpacing = kSpac
        
        layout.sectionInset = UIEdgeInsets(top: kSpac, left: kSpac, bottom: kSpac, right: kSpac)
        
        
//        collView = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60), collectionViewLayout: layout)
        collView = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: layout)
        collView!.dataSource   = self
        collView!.delegate     = self
        collView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collView!.registerClass(WinkboardViewCell1.self, forCellWithReuseIdentifier: "CollectionViewCell")
        //  collView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collView!)
        
//        let kView4: UIView  =   UIView(frame: CGRectMake(0 , self.view.frame.size.height - 64 - 60, self.view.frame.size.width , 60))
//        
//        let dummyView : UIImageView =   UIImageView(frame: CGRectMake(0, 0, kView4.frame.size.width, kView4.frame.size.height))
//        dummyView.backgroundColor   =   UIColor.blackColor()
//        kView4.addSubview(dummyView)
//        let addbutton: UIButton     =   UIButton(type: UIButtonType.Custom)
//        addbutton.frame             =   CGRectMake(0, 0,120, 40)
//        addbutton.setTitle("ADD", forState: UIControlState.Normal)
//        addbutton.titleLabel?.font  =   UIFont(name: Gillsans.Default.description, size: 18.0)
//        addbutton.backgroundColor    =   UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
//        addbutton.addTarget(self, action: "addBtnTapped", forControlEvents: UIControlEvents.TouchUpInside)
//        addbutton.layer.cornerRadius    =   20
//        addbutton.layer.masksToBounds   =   true
//        addbutton.center    =   dummyView.center
//        kView4.addSubview(addbutton)
//        self.view.addSubview(kView4)
        
       loadWinkBoardObjects()
        
    }
    func addBtnTapped () {
        let createWnkBrd    =   CreateWinkboardView(frame: CGRectMake(0,0,GetAppDelegate().window!.frame.size.width,GetAppDelegate().window!.frame.size.height)).cmpltnHandler { (name, uid) -> () in
            self.loadWinkBoardObjects()
        }
        GetAppDelegate().window?.rootViewController!.view.addSubview(createWnkBrd)
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
    
    func loadWinkBoardObjects () {
        
        self.winkObjects    =   NSArray()
        self.collView?.reloadData()
        
        if (processView?.isKindOfClass(NSNull) == false)
        {
            processView!.removeFromSuperview()
        }
        if (noLbl?.isKindOfClass(NSNull) == false)
        {
            noLbl!.removeFromSuperview()
        }
        processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView!)
        
        noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl!.text       =   "No detail found."
        noLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl!.textAlignment  =   .Center
        self.view.addSubview(noLbl!)
        noLbl!.hidden    =   true
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),"Feed"] , forKeys: [kLS_CP_UserId,kLS_CP_BoardType])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_WinkBoard_WinkboardList, parm: dict1, completion: { result , desc , code in
            self.processView!.removeFromSuperview()
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_WinkboardName as String, ascending: true)
                            let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                
                                let winkObj : WinkBoardListObj   =   WinkBoardListObj().setDetails(kDict as! NSDictionary, kDelegate: self as WinkBoardListObjDelegate, kImgWidth: self.kWidth!)
                                
                                kTempArr.addObject(winkObj)
                                
                            }
                            
                            self.winkObjects    =   NSArray(array: kTempArr)
                        }
                    }
                }
                if (isSuccess == false || self.winkObjects.count == 0)
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
            
            
            self.collView?.reloadData()
        })
        
    }
    
    
    func ImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return winkObjects.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let winkObj: WinkBoardListObj    =   (winkObjects.objectAtIndex(indexPath.row) as? WinkBoardListObj)!
        return CGSize(width: winkObj._imgWidth , height: winkObj._imgHeight)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! WinkboardViewCell1
        
        let winkObj: WinkBoardListObj    =   (winkObjects.objectAtIndex(indexPath.row) as? WinkBoardListObj)!
        cell.winkObj    =   winkObj
        cell.delegate   =   self
        cell.editBtn?.frame =   CGRectMake(cell.frame.size.width - 36, cell.frame.size.height - 40 - 36, 32, 32)
        cell.bgImg.frame    =   CGRect(x: 0, y: 0, width: winkObj._imgWidth , height: winkObj._imgHeight)
        cell.winkLbl!.frame =  CGRectMake(0, cell.frame.size.height - 40, cell.frame.size.width, 40)
        cell.bgImg.image    =   UIImage()
        cell.backgroundColor    =   UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        cell.winkLbl?.text  =   winkObj._WinkboardName.uppercaseString
        cell.processView?.hidden    =   false
        if (winkObj._isThumbImgDownloadIntiated == false)
        {
            winkObj.downloadThumbImg()
        }
        if ((winkObj._isThumbImgDownloadIntiated) == true && (winkObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   winkObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let winkObj: WinkBoardListObj    =   winkObjects.objectAtIndex(indexPath.row) as! WinkBoardListObj
        
        let winkImgsListVC  =   WinkBoardImagesController()
        winkImgsListVC.winkObj  =   winkObj
        winkImgsListVC.loadWinkImageObjects()
        self.navigationController?.pushViewController(winkImgsListVC, animated: true)
    }
    
}


class WinkboardViewCell1: UICollectionViewCell  {
    
    var bgImg: UIImageView!
    var winkLbl : UILabel?
    var editBtn : UIButton?
    var  delegate   : WinkboardViewCellDelegate?
    var winkObj: WinkBoardListObj?
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
        
        winkLbl  =   UILabel(frame: CGRectMake(3, frame.size.height - 40, frame.size.width - 6, 40))
        winkLbl!.text       =   ""
        winkLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        winkLbl!.numberOfLines  =   0
        winkLbl!.textColor  =   UIColor.whiteColor()
        winkLbl!.textAlignment  =   NSTextAlignment.Center
        winkLbl!.backgroundColor    =   UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        contentView.addSubview(winkLbl!)
        
   
        
        editBtn     =   UIButton(type: UIButtonType.Custom)
        editBtn!.frame      =   CGRectMake(frame.size.width - 36, frame.size.height - 40 - 36, 32, 32)
     //   editBtn!.setImage(UIImage(named: "edit.png"), forState: UIControlState.Normal)
        editBtn!.addTarget(self, action: #selector(WinkboardViewCell.editWinkBoard), forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(editBtn!)
        editBtn!.autoresizingMask  =   [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleBottomMargin]
        
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView!)
        
    }
    
    func editWinkBoard () {
        //   delegate?.editTapped(winkObj!)
    }
}

protocol ILikeControllerDelegate {
    func selectedObjects (kArray : NSArray)
}

protocol WinkSelectListDelegate {
    func selectedWinkboard (kWinkObj: WinkBoardListObj)
}
class WinkItController: UIViewController, UITextViewDelegate, ILikeControllerDelegate, WinkSelectListDelegate {
    
    var storyObj : ViewStoryObj?
    var winkObj : WinkImgObj?
    var isWink : Bool   =   false
    var storyId : NSString?
    
    var _fldHeight: CGFloat?
    var _fldMargin: CGFloat?
    var _fldsGap: CGFloat?
    var _viewWidth: CGFloat?
    var _viewHeight: CGFloat?
    var _bottomViewHeight: CGFloat?
    var scrollView: UIScrollView?
    var winkBoardBtn: UIButton?
    var winkBoardLbl: UILabel?
    var iLikeBtn: UIButton?
    var iLikeLbl: UILabel?
    var notesTxtView: UITextView?
    var selectedSpecArray : NSArray  =   NSArray()
    var selectedSpecialityID : NSString = ""
    var selectedWinkboardID: NSString = ""
    var placeHolderLbl : UILabel?
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden  =   false
    }
    
    func selectedObjects (kArray : NSArray)
    {
        selectedSpecArray   =   NSArray(array: kArray)
        
        iLikeLbl!.text      =   "I Like"
        iLikeLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        selectedSpecialityID    =   ""
        if (selectedSpecArray.count > 0)
        {
            let kMutArr =    NSMutableArray()
             let kMutArr1 =    NSMutableArray()
            for speObj in selectedSpecArray {
                kMutArr.addObject(((speObj as? SpecialityObj)?._specialityDesc)!)
                kMutArr1.addObject(((speObj as? SpecialityObj)?._specialityCd)!)
            }
            
            iLikeLbl!.text      =   kMutArr.componentsJoinedByString(", ")
            iLikeLbl!.textColor =   UIColor.blackColor()
            selectedSpecialityID    =   kMutArr1.componentsJoinedByString(",")
        }
    }
    func selectedWinkboard (kWinkObj: WinkBoardListObj)
    {
        winkBoardLbl!.text      =   kWinkObj._WinkboardName as String
        winkBoardLbl!.textColor =   UIColor.blackColor()
        selectedWinkboardID     =   kWinkObj._WinkboardId
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        _viewWidth  =   self.view.frame.size.width
        _viewHeight =   self.view.frame.size.height
        
        
        _fldHeight   =   40.0
        _fldMargin   =   15.0
        _fldsGap     =   20.0
        _bottomViewHeight   =   40.0
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "WINK IT"
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(WinkItController.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let aButton1     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton1.setImage(UIImage(named: "plusIcon.png"), forState: .Normal)
        aButton1.addTarget(self, action: #selector(WinkItController.createBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem1  =   UIBarButtonItem(customView: aButton1)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        
        //Set scrollView
        
        scrollView  =   UIScrollView(frame: CGRectMake(0, 0, _viewWidth!, _viewHeight! - _bottomViewHeight!))
        self.view.addSubview(scrollView!)
        //Set First two picker selectors
        
        let tempImgView :   UIImageView =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64))
   //     tempImgView.image   =   UIImage(CGImage: (storyObj?._thumbImg.CGImage)!).convertToGrayScale()
        tempImgView.contentMode = UIViewContentMode.ScaleAspectFit
        tempImgView.alpha   =   0.1
        tempImgView.userInteractionEnabled  =   true
        tempImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(WinkItController.tapAction)))
        scrollView?.addSubview(tempImgView)
        
        let kStartPoint: CGFloat    =    20
        
       
        
        let kView2: UIView  =   UIView(frame: CGRectMake(_fldMargin!, kStartPoint, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        
        iLikeLbl    =   UILabel(frame: CGRectMake(10, 0, kView2.frame.size.width - 30, kView2.frame.size.height))
        iLikeLbl!.backgroundColor    =   UIColor.clearColor()
        iLikeLbl!.text   =   "I Like"
        iLikeLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 18.0)
        iLikeLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView2.addSubview(iLikeLbl!)
        
        let arrowImg1      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg1.image    =   UIImage(named: "arrow.png")
        kView2.addSubview(arrowImg1)
        arrowImg1.center.x   =   kView2.frame.size.width - 15.0
        arrowImg1.center.y   =   kView2.frame.size.height / 2.0
        
        iLikeBtn     =   UIButton(type: UIButtonType.Custom)
        iLikeBtn!.frame      =   CGRectMake(0, 0, kView2.frame.size.width, kView2.frame.size.height)
        iLikeBtn!.backgroundColor    =   UIColor.clearColor()
        iLikeBtn!.layer.borderWidth  =   1.0
        iLikeBtn!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        iLikeBtn!.layer.cornerRadius =   3.0
        iLikeBtn!.addTarget(self, action: #selector(WinkItController.iLikeBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        kView2.addSubview(iLikeBtn!)
        
        scrollView?.addSubview(kView2)
        
        
        let kView3: UIView   =   UIView(frame: CGRectMake(_fldMargin!, kView2.frame.origin.y + _fldHeight! + _fldsGap! , (_viewWidth! - (2 * _fldMargin!)), _fldHeight! * 2))
        scrollView?.addSubview(kView3)
        
        placeHolderLbl    =   UILabel(frame: CGRectMake(10, 0, kView3.frame.size.width - 30,
            _fldHeight!))
        placeHolderLbl!.backgroundColor    =   UIColor.clearColor()
        placeHolderLbl!.text   =   "Notes"
        placeHolderLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 18.0)
        placeHolderLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView3.addSubview(placeHolderLbl!)
        
        notesTxtView                       =   UITextView(frame: CGRectMake(0, 0, (_viewWidth! - (2 * _fldMargin!)), _fldHeight! * 2))
        notesTxtView!.delegate             =   self
        notesTxtView!.layer.borderColor    =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        notesTxtView!.layer.cornerRadius    =   3.0
        notesTxtView!.layer.borderWidth    =   1.0
        notesTxtView!.font                  =   UIFont(name: Gillsans.Default.description, size: 18.0)
        notesTxtView!.backgroundColor       =   UIColor.clearColor()
        notesTxtView!.autocorrectionType    =   UITextAutocorrectionType.No
        //    notesTxtView?.userInteractionEnabled    =   false
        kView3.addSubview(notesTxtView!)
        
        
        let kView1: UIView  =   UIView(frame: CGRectMake(_fldMargin! , kView3.frame.origin.y +  _fldHeight! * 2 + _fldsGap!, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        
        winkBoardLbl    =   UILabel(frame: CGRectMake(10, 0, kView1.frame.size.width - 30, kView1.frame.size.height))
        winkBoardLbl!.backgroundColor    =   UIColor.clearColor()
        winkBoardLbl!.text   =   "My wink boards"
        winkBoardLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 18.0)
        winkBoardLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView1.addSubview(winkBoardLbl!)
        
        let arrowImg      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg.image    =   UIImage(named: "arrow.png")
        kView1.addSubview(arrowImg)
        arrowImg.center.x   =   kView1.frame.size.width - 15.0
        arrowImg.center.y   =   kView1.frame.size.height / 2.0
        
        winkBoardBtn     =   UIButton(type: UIButtonType.Custom)
        winkBoardBtn!.frame      =   CGRectMake(0, 0, kView1.frame.size.width, kView1.frame.size.height)
        winkBoardBtn!.backgroundColor    =   UIColor.clearColor()
        winkBoardBtn!.layer.borderWidth  =   1.0
        winkBoardBtn!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        winkBoardBtn!.layer.cornerRadius =   3.0
        winkBoardBtn!.addTarget(self, action: #selector(WinkItController.selectWinkBoard(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        kView1.addSubview(winkBoardBtn!)
        
        
        
        scrollView?.addSubview(kView1)
        
        let kView4: UIView  =   UIView(frame: CGRectMake(0 , _viewHeight! - 64 - 60, _viewWidth! , _fldHeight! + 20))
        
        let dummyView : UIImageView =   UIImageView(frame: CGRectMake(0, 0, kView4.frame.size.width, kView4.frame.size.height))
        dummyView.backgroundColor   =   UIColor.blackColor()
        kView4.addSubview(dummyView)
        let addbutton: UIButton     =   UIButton(type: UIButtonType.Custom)
        addbutton.frame             =   CGRectMake(0, 0,120, _fldHeight!)
        addbutton.setTitle("SAVE", forState: UIControlState.Normal)
        addbutton.titleLabel?.font  =   UIFont(name: Gillsans.Default.description, size: 18.0)
        addbutton.backgroundColor    =   UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        addbutton.addTarget(self, action: #selector(WinkBoardController.addBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        addbutton.layer.cornerRadius    =   20
        addbutton.layer.masksToBounds   =   true
        addbutton.center    =   dummyView.center
        kView4.addSubview(addbutton)
        scrollView?.addSubview(kView4)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func tapAction () {
        self.view.endEditing(true)
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createBtnTapped () {
        let createWnkBrd    =   CreateWinkboardView(frame: CGRectMake(0,0,GetAppDelegate().window!.frame.size.width,GetAppDelegate().window!.frame.size.height)).cmpltnHandler { (name, uid) -> () in
            self.winkBoardLbl!.text      =   name
            self.winkBoardLbl!.textColor =   UIColor.blackColor()
            self.selectedWinkboardID     =   uid
        }
        GetAppDelegate().window?.rootViewController!.view.addSubview(createWnkBrd)
    }
    
    func addBtnTapped () {
        
        self.view.endEditing(true)
        if (selectedSpecialityID.isEqualToString("") == true)
        {
            ShowAlert("Select atleast a category.")
            return
        }
        if (selectedWinkboardID.isEqualToString("") == true)
        {
            ShowAlert("Select wink board.")
            return
        }
       
        if(notesTxtView!.text!.isEmpty)
        {
            notesTxtView!.text   =   " "
        }
        
    let maskview    =   MaskView(frame:  CGRectMake(0 , 0, _viewWidth! , _viewHeight! - 64))
        self.view.addSubview(maskview)
//        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),"\(GetAppDelegate().loginDetails!._firstName) \(GetAppDelegate().loginDetails!._lastName)",selectedWinkboardID,storyObj!._UserId,storyObj!._UserName, storyObj!._UserRole,storyObj!._FileName,selectedSpecialityID,notesTxtView!.text!,storyId!], forKeys: [kLS_CP_UserId,kLS_CP_UserName,kLS_CP_WinkboardId,kLS_CP_ArtistId,kLS_CP_ArtistName,kLS_CP_ArtistRole,kLS_CP_FileName,kLS_CP_ILike,kLS_CP_ImgDesc,kLS_CP_StoryId])
        
        
        var dict1   =   [kLS_CP_UserId       :   getUserID()]
        
        if (isWink) {
            dict1  =   [
                kLS_CP_UserId       :   getUserID(),
                kLS_CP_UserName     :   "\(GetAppDelegate().loginDetails!._firstName) \(GetAppDelegate().loginDetails!._lastName)",
                kLS_CP_WinkboardId  :   selectedWinkboardID,
                kLS_CP_ArtistId     :   winkObj!._ArtistUserId,
                kLS_CP_ArtistName   :   winkObj!._ArtistUserName,
                kLS_CP_ArtistRole   :   winkObj!._ArtistRole,
                kLS_CP_FileName     :   winkObj!._FileName,
                kLS_CP_ILike        :   selectedSpecialityID,
                kLS_CP_ImgDesc      :   notesTxtView!.text!,
                kLS_CP_StoryId      :   winkObj!._StoryId]
        }
        else {
            dict1   =   [
                kLS_CP_UserId       :   getUserID(),
                kLS_CP_UserName     :   "\(GetAppDelegate().loginDetails!._firstName) \(GetAppDelegate().loginDetails!._lastName)",
                kLS_CP_WinkboardId  :   selectedWinkboardID,
                kLS_CP_ArtistId     :   storyObj!._UserId,
                kLS_CP_ArtistName   :   storyObj!._UserName,
                kLS_CP_ArtistRole   :   storyObj!._UserRole,
                kLS_CP_FileName     :   storyObj!._FileName,
                kLS_CP_ILike        :   selectedSpecialityID,
                kLS_CP_ImgDesc      :   notesTxtView!.text!,
                kLS_CP_StoryId      :   storyId!]
        }
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_WinkBoard_WinkImg, parm: NSMutableDictionary(dictionary: dict1), completion: { result , desc , code in
            
            maskview.removeFromSuperview()
            
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
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                if (isSuccess == false)
                {
                    ShowAlert("Wink image request failed.")
                }
            }
            else
            {
                var str =   "Wink image request failed."
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    str      =   desc
                }
                ShowAlert(str)
            }
            
        })
    }
    
    func selectWinkBoard (kButton:UIButton) {
        self.view.endEditing(true)
        let ilikeIt     =   WinkBoardSelectionController()
        ilikeIt.delegate    =   self
        self.navigationController?.pushViewController(ilikeIt, animated: true)
    }
    func iLikeBtnTapped (kButton:UIButton) {
        self.view.endEditing(true)
        let ilikeIt     =   ILikeController()
        ilikeIt.prevSelected    =   self.selectedSpecArray
        ilikeIt.delegate    =   self
        self.navigationController?.pushViewController(ilikeIt, animated: true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if let swRange = textView.text.rangeFromNSRange(range) {
            let newString = textView.text.stringByReplacingCharactersInRange(swRange, withString: text)
            
            if (NSString(string: "").isEqualToString(newString) == true)
            {
                placeHolderLbl?.hidden  =  false
            }
            else
            {
                placeHolderLbl?.hidden  =   true
            }
        }
        
        
        return true
    }
}


class WinkBoardSelectionController: UIViewController, WinkBoardListObjDelegate , UITableViewDelegate, UITableViewDataSource , WinkboardViewCellDelegate{
    
    var winkObjects : NSArray = NSArray()
     var tbleView: UITableView?
    var kWidth : CGFloat?
    var isFirstTime : Bool  =   false
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var delegate : WinkSelectListDelegate!  =   nil
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(WinkItController.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "MY WINK BOARDS"
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
        
        loadWinkBoardObjects()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    
    
    func loadWinkBoardObjects () {
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No wink board found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),"All"] , forKeys: [kLS_CP_UserId,kLS_CP_BoardType])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_WinkBoard_WinkboardList, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_WinkboardName as String, ascending: true)
                            let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                
                                let winkObj : WinkBoardListObj   =   WinkBoardListObj().setDetails(kDict as! NSDictionary, kDelegate: self as WinkBoardListObjDelegate, kImgWidth: self.kWidth!)
                                
                                kTempArr.addObject(winkObj)
                                
                            }
                            
                            self.winkObjects    =   NSArray(array: kTempArr)
                        }
                    }
                }
                if (isSuccess == false || self.winkObjects.count == 0)
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
    
    
    func ImageDownloadReqFinished () {
        self.tbleView?.reloadData()
    }
    

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winkObjects.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let winkObj: WinkBoardListObj    =   (winkObjects.objectAtIndex(indexPath.row) as? WinkBoardListObj)!
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        let imageView   =   UIImageView(frame: CGRectMake(20, 10, 60, 60))
        imageView.backgroundColor       =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        imageView.layer.masksToBounds   =   true
        imageView.layer.cornerRadius    =   30.0
        imageView.layer.borderWidth     =   1.0
        imageView.layer.borderColor     =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        cell.addSubview(imageView)
        
        let descLbl        =   UILabel(frame: CGRectMake(90,0, self.view.frame.size.width - 100 , 80))
        descLbl.text       =   winkObj._WinkboardName as String
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        let sepImg      =   UIImageView(frame: CGRectMake(20, 79, self.view.frame.size.width - 20, 1))
        sepImg.backgroundColor  =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.addSubview(sepImg)
        
        if (winkObj._isThumbImgDownloadIntiated == false)
        {
            winkObj.downloadThumbImg()
        }
        if ((winkObj._isThumbImgDownloadIntiated) == true && (winkObj._isThumbImgDownloaded == true))
        {
            imageView.image    =   winkObj._thumbImg
        }
        
        if (self.loadedIndexes.containsObject(indexPath) == false)
        {
            self.loadedIndexes.addObject(indexPath)
     
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegate.selectedWinkboard(self.winkObjects.objectAtIndex(indexPath.row) as! WinkBoardListObj)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}



class ILikeController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var specObjects : NSArray = NSArray()
    var tbleView: UITableView?
    var kWidth : CGFloat?
    var isFirstTime : Bool  =   false
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var selectedObjects : NSMutableArray    =   NSMutableArray()
    var delegate : ILikeControllerDelegate!  =   nil
    var prevSelected    =   NSArray()
    
    func backBtnTapped () {
        delegate.selectedObjects(self.selectedObjects)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(WinkItController.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "I LIKE!"
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
        
        loadWinkBoardObjects()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    
    
    func loadWinkBoardObjects () {
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No detail found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [] , forKeys: [])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_SignUp_GetSpectialities, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_specialityDesc as String, ascending: true)
                            let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                
                                let specObj : SpecialityObj   =   SpecialityObj().setDetails(kDict as! NSDictionary)
                                
                                kTempArr.addObject(specObj)
                                
                                for speObj in self.prevSelected {
                                    
                                    if ((speObj as? SpecialityObj)?._specialityCd.isEqualToString(specObj._specialityCd as String) == true)
                                    {
                                        self.selectedObjects.addObject(specObj)
                                    }
                                }
                            }
                            
                            self.specObjects    =   NSArray(array: kTempArr)
                        }

                    }
                }
                if (isSuccess == false || self.specObjects.count == 0)
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
    

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specObjects.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        cell.selectionStyle     =   .None
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let specObj: SpecialityObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        
        let imageView   =   UIImageView(frame: CGRectMake(20, 13, 15, 15))
        
        cell.addSubview(imageView)
        
        if (self.selectedObjects.containsObject(specObj))
        {
            imageView.image =   UIImage(named: "checked_checkbox.png")
        }
        else
        {
            imageView.image =   UIImage(named: "unchecked_checkbox.png")
        }
        
        let descLbl        =   UILabel(frame: CGRectMake(50,0, self.view.frame.size.width - 60 , 40))
        descLbl.text       =   specObj._specialityDesc as String
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
//        let sepImg      =   UIImageView(frame: CGRectMake(20, 39, self.view.frame.size.width - 20, 1))
//        sepImg.backgroundColor  =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
//        cell.addSubview(sepImg)
 
        
        if (self.loadedIndexes.containsObject(indexPath) == false)
        {
            self.loadedIndexes.addObject(indexPath)
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
         let specObj: SpecialityObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        
        if (self.selectedObjects.containsObject(specObj))
        {
            self.selectedObjects.removeObject(specObj)
        }
        else
        {
            self.selectedObjects.addObject(specObj)
        }
        
        tableView.reloadData()
    }
    
}

class WinkBoardImagesController: UIViewController, WinkImgObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout , UIActionSheetDelegate, WinkImgCellDelegate{
    
    var winkImgObjects : NSArray = NSArray()
    var winkObj : WinkBoardListObj?
    var collView: UICollectionView?
    var kWidth : CGFloat?
    var storyID : NSString?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title  =   winkObj?._WinkboardName as? String
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl         =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text        =   winkObj?._WinkboardName.uppercaseString
        descLbl.textColor   =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment   =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
        let aButton         =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(WinkItController.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)

        
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
        collView!.registerClass(WinkImgCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        //  collView!.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
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
    
    func loadWinkImageObjects () {
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),winkObj!._WinkboardId] , forKeys: [kLS_CP_UserId,kLS_CP_WinkBoardId])
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No detail found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_WinkBoard_GetAllUserWinkedImages, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_WinkedDateTime as String, ascending: false )
                            let sortDescriptors: NSArray    =   NSArray(object: brandDescriptor)
                            let sortedArray : NSArray       =   NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                
                                let winkObj : WinkImgObj    =   WinkImgObj().setDetails(kDict as! NSDictionary, kDelegate: self as WinkImgObjDelegate, kImgWidth: self.kWidth!)
                                kTempArr.addObject(winkObj)
                            }
                            
                            self.winkImgObjects    =   NSArray(array: kTempArr)
                        }
                    }
                }
                
                if (isSuccess == false || self.winkImgObjects.count == 0)
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
    
    
    func ImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    func editTapped (kWinkObj:WinkImgObj) {
        
    }
    
    
    // MARK: - Collectionview Handlers -
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return winkImgObjects.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let winkObj: WinkImgObj    =   (winkImgObjects.objectAtIndex(indexPath.row) as? WinkImgObj)!
        return CGSize(width: winkObj._imgWidth , height: winkObj._imgHeight  + 40)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, columnCountForSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! WinkImgCell
        
        let winkObj: WinkImgObj    =   (winkImgObjects.objectAtIndex(indexPath.row) as? WinkImgObj)!
        cell.winkObj        =   winkObj
        cell.delegate       =   self
        cell.bgImg.frame    =   CGRect(x: 0, y: 0, width: winkObj._imgWidth , height: winkObj._imgHeight)
        cell.editBtn?.frame =   CGRectMake(cell.frame.size.width - 36, cell.frame.size.height - 40 - 36, 32, 32)
        cell.winkLbl!.frame =  CGRectMake(0, cell.frame.size.height - 40, cell.frame.size.width, 40)
        cell.bgImg.image    =   UIImage()
        cell.backgroundColor    =   UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        cell.winkLbl?.text  =   winkObj._WinkImageDesc as String
        cell.processView?.hidden    =   false
        if (winkObj._isThumbImgDownloadIntiated == false)
        {
            winkObj.downloadThumbImg()
        }
        if ((winkObj._isThumbImgDownloadIntiated) == true && (winkObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   winkObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell    =   collectionView.cellForItemAtIndexPath(indexPath)
        
        let frame   =   cell?.superview!.convertRect((cell?.frame)!, toView: nil)
        
        let fullimgview             =   FullImageController()
        fullimgview.storyID         =   self.storyID
        fullimgview.isWink          =   true
        fullimgview.index           =   indexPath.row
        fullimgview.kScreenshot     =   screenShot()
        fullimgview.kFrame          =   frame
        fullimgview.pageObjects     =   NSArray(array: self.winkImgObjects)
        self.navigationController?.pushViewController(fullimgview, animated: false)
    }
    
    
}
// MARK: - WinkboardViewCellDelegate -
protocol WinkImgCellDelegate {
    func editTapped (kWinkObj:WinkImgObj)
}

class WinkImgCell: UICollectionViewCell  {
    
    var bgImg: UIImageView!
    var winkLbl : UILabel?
    var editBtn : UIButton?
    var  delegate   : WinkImgCellDelegate?
    var winkObj: WinkImgObj?
    var processView : ImageLoadProcessView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height - 40)
        
        winkLbl  =   UILabel(frame: CGRectMake(3, frame.size.height - 40, frame.size.width - 6, 40))
        winkLbl!.text       =   ""
        winkLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        winkLbl!.numberOfLines  =   0
        winkLbl!.textColor  =   UIColor.blackColor()
        winkLbl!.textAlignment  =   NSTextAlignment.Center
        contentView.addSubview(winkLbl!)
        
        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor   =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.addSubview(bgImg)
        
        editBtn     =   UIButton(type: UIButtonType.Custom)
        editBtn!.frame      =   CGRectMake(frame.size.width - 36, frame.size.height - 40 - 36, 32, 32)
    //    editBtn!.setImage(UIImage(named: "edit.png"), forState: UIControlState.Normal)
        editBtn!.addTarget(self, action: #selector(WinkboardViewCell.editWinkBoard), forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(editBtn!)
        
        editBtn!.autoresizingMask   =   [UIViewAutoresizing.FlexibleLeftMargin, UIViewAutoresizing.FlexibleBottomMargin]
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView!)
    }
    
    func editWinkBoard () {
        delegate?.editTapped(winkObj!)
    }
}

class CreateWinkboardView: UIView , UITextFieldDelegate{
    
    var kView : UIView?
    var nameTxtFld : UITextField?
    var createBtn : UIButton?
    var completionHandler : ((name :String,uid : String) -> ())!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let kTransperentImgView =   UIImageView(frame: CGRectMake(0,0,self.frame.size.width,self.frame.size.height))
        kTransperentImgView.backgroundColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(kTransperentImgView)
        
        kView   =   UIView(frame: CGRectMake(0,0,self.frame.size.width - 60 , 340))
        kView!.backgroundColor   =   UIColor.whiteColor()
        self.addSubview(kView!)
        kView!.layer.cornerRadius    =   5.0
        
        kView!.center    =   kTransperentImgView.center
        
        let kImgHead    =   UIImageView(frame: CGRectMake(0, 6, 34, 34))
        kImgHead.image  =   UIImage(named: "lenspire-logo.png")
        kView!.addSubview(kImgHead)
        kImgHead.center.x   =   kView!.frame.size.width / 2.0
        
        
        let closeBtn     = UIButton(type: UIButtonType.Custom)
        closeBtn.frame   =   CGRectMake(kView!.frame.size.width - 40, 5, 30, 30)
        closeBtn.setImage(UIImage(named: "cross.png"), forState: UIControlState.Normal)
        closeBtn.addTarget(self, action: #selector(CreateWinkboardView.closeBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        kView!.addSubview(closeBtn)
        
        let klbl    =   UILabel(frame: CGRectMake(0,50,kView!.frame.size.width,30))
        klbl.font   =   UIFont(name: Gillsans.Default.description, size: 20)
        klbl.text   =   "CREATE WINK BOARD"
        klbl.textAlignment  =   .Center
        klbl.backgroundColor    =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        klbl.textColor  =   UIColor.blackColor()
        kView!.addSubview(klbl)
        
        
        nameTxtFld              =   UITextField(frame: CGRectMake(20,120,kView!.frame.size.width - 40 , 30))
        nameTxtFld!.delegate         =   self
        nameTxtFld!.placeholder      =   "Name"
        let paddingView             =   UIView(frame: CGRectMake(0, 0, 10, nameTxtFld!.frame.height))
        nameTxtFld!.leftView         =   paddingView
        nameTxtFld!.leftViewMode     =   .Always
        nameTxtFld!.layer.borderWidth  =   1.0
        nameTxtFld!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        nameTxtFld!.layer.cornerRadius =   3.0
        nameTxtFld!.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        kView!.addSubview(nameTxtFld!)
        
        
        let kView2: UIView  =   UIView(frame: CGRectMake(20,180,kView!.frame.size.width - 40 , 30))
        
        let invColl    =   UILabel(frame: CGRectMake(10, 0, kView2.frame.size.width - 30, kView2.frame.size.height))
        invColl.backgroundColor    =   UIColor.clearColor()
        invColl.text   =   "Invite Collabrators"
        invColl.font   =   UIFont(name: Gillsans.Default.description, size: 18.0)
        invColl.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView2.addSubview(invColl)
        
        let arrowImg1      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg1.image    =   UIImage(named: "arrow.png")
        kView2.addSubview(arrowImg1)
        arrowImg1.center.x   =   kView2.frame.size.width - 15.0
        arrowImg1.center.y   =   kView2.frame.size.height / 2.0
        
        let invCollBtn     =   UIButton(type: UIButtonType.Custom)
        invCollBtn.frame      =   CGRectMake(0, 0, kView2.frame.size.width, kView2.frame.size.height)
        invCollBtn.backgroundColor    =   UIColor.clearColor()
        invCollBtn.layer.borderWidth  =   1.0
        invCollBtn.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        invCollBtn.layer.cornerRadius =   3.0
        invCollBtn.addTarget(self, action: #selector(CreateWinkboardView.invCollBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        kView2.addSubview(invCollBtn)
        kView!.addSubview(kView2)
        
        createBtn     =   UIButton(type: UIButtonType.Custom)
        createBtn!.frame   =   CGRectMake(0, 260, 160, 30.0)
        createBtn!.setImage(getButtonImage("CREATE", kWidth: 160.0 * 2.0, kHeight: 60.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        createBtn!.addTarget(self, action: #selector(WinkItController.createBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        kView!.addSubview(createBtn!)
        createBtn!.center.x  =   kView!.frame.size.width / 2.0
        
        kView!.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.3, animations: {
            self.kView!.layer.transform = CATransform3DMakeScale(1,1,1)
            },completion: { finished in
                UIView.animateWithDuration(0.1, animations: {
                    self.kView!.layer.transform = CATransform3DMakeScale(0.9,0.9,1)
                    },completion: { finished in
                        UIView.animateWithDuration(0.2, animations: {
                            self.kView!.layer.transform = CATransform3DMakeScale(1,1,1)
                        })
                })
        })
   
    }
    
    func cmpltnHandler ( completion : (name :String,uid : String) -> ()) -> CreateWinkboardView {
        self.completionHandler          =   completion
        return self
    }
    
    func invCollBtnTapped (sender : UIButton) {
    //    MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
    }
    
    func closeBtnTapped () {
        
        UIView.animateWithDuration(0.20, animations: { () -> Void in
            self.alpha    =   0
            }) { (iscompleted) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func createBtnTapped () {
        
        let uuid    =   NSUUID().UUIDString
        let name    =   nameTxtFld!.text
        
        if (nameTxtFld!.text?.isEmpty == true)
        {
            ShowAlert("Specify a valid wink board name.")
            nameTxtFld!.becomeFirstResponder()
            
            return
        }
        
        self.endEditing(true)
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),"Create",uuid,name!] , forKeys: [kLS_CP_UserId,kLS_CP_CheckType,kLS_CP_WinkBoardId,kLS_CP_WinkBoardName])
        
        let processView     =   ProcessView(frame: createBtn!.frame)
        kView!.addSubview(processView)
        createBtn!.hidden   =   true
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_WinkBoard_CheckWinkboardExists, parm: dict1, completion: { result , desc , code in
            
            print(result)
            if (result.isKindOfClass(NSNumber) == true)
            {
                if ((result as! NSNumber).intValue == 0)
                {
                    let dict2: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),"Public",uuid,name!,""] , forKeys: [kLS_CP_UserId,kLS_CP_SetAccess,kLS_CP_WinkBoardId,kLS_CP_WinkBoardName,kLS_CP_WinkBoardDesc])
                    
                    ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_WinkBoard_CreateWinkBoard, parm: dict2, completion: { result , desc , code in
                        
                        print(result)
                        processView.removeFromSuperview()
                        self.createBtn!.hidden   =   false
                        
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
                                    
                                    self.completionHandler(name: name!,uid: uuid)
                                    self.closeBtnTapped()
                                }
                            }
                            if (isSuccess == false)
                            {
                                ShowAlert(kLS_Err_Msg)
                            }
                        }
                        else
                        {
                            if((desc as NSString).isKindOfClass(NSNull) == false)
                            {
                                ShowAlert(desc)
                            }
                            else
                            {
                                ShowAlert(kLS_Err_Msg)
                            }
                        }
                        
                    })
                }
                else
                {
                    ShowAlert(kLS_WB_Exists)
                    processView.removeFromSuperview()
                    self.createBtn!.hidden   =   false
                }
            }
            else
            {
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    ShowAlert(desc)
                    processView.removeFromSuperview()
                    self.createBtn!.hidden   =   false
                }
                else
                {
                    ShowAlert(kLS_Err_Msg)
                    processView.removeFromSuperview()
                    self.createBtn!.hidden   =   false
                }
            }
        })
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        UIView.animateWithDuration(0.30) { () -> Void in
            self.kView!.center.y    = self.center.y - 100.0
        }
        
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        UIView.animateWithDuration(0.30) { () -> Void in
            self.kView!.center.y    = self.center.y
        }
        
        return true
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
