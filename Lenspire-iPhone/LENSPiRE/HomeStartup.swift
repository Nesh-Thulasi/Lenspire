//
//  HomeStartup.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 06/11/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation

class LandController: RESideMenu, RESideMenuDelegate {
    
    var isFromRegistration : Bool = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden  =   true
    }
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        
        self.menuPreferredStatusBarStyle    =   UIStatusBarStyle.LightContent
        self.contentViewShadowColor         =   UIColor.blackColor()
        self.contentViewShadowOffset        =   CGSizeMake(0, 0)
        self.contentViewShadowOpacity       =   0.6
        self.contentViewShadowRadius        =   12
        self.contentViewShadowEnabled       =   true
        
        if (isFromRegistration) {
            let VC  =   ProfileVC()
            let Nav =   UINavigationController(rootViewController: VC)
            Nav.navigationBar.translucent   =   false
            self.contentViewController      =   Nav
        } else {
        let VC  =   FeedsViewController()
        let Nav =   UINavigationController(rootViewController: VC)
        Nav.navigationBar.translucent   =   false
        self.contentViewController      =   Nav
        }
//        let Nav1 =   UINavigationController(rootViewController: SideMenuController())
//        Nav1.navigationBar.translucent  =   false
        
        let VC1 =   SideMenuController()
        VC1.isFromRegistration  =   self.isFromRegistration
        self.leftMenuViewController     =   VC1
        self.delegate   =   self;
        //ViewDidLoad should be here
        super.viewDidLoad()
        
        if (isFromRegistration) {
            ShowAlert("Welcome to LENSPiRE.")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
}

class SideMenuController: UIViewController , UITableViewDelegate, UITableViewDataSource, FeedObjDelegate{
    
    var tbleView: UITableView?
    var menuArray: NSArray?

    var isFromRegistration : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        setMenuArrayFunc()

        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "menu-head.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(SideMenuController.messageBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
//        tbleView    =   UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width * (2.5/3.0), self.view.frame.size.height - 64), style: UITableViewStyle.Plain)
        tbleView    =   UITableView(frame: CGRectMake(0, 20, self.view.frame.size.width * (2.5/3.0), self.view.frame.size.height - 20), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
      //  tbleView?.alwaysBounceVertical =   false
        tbleView?.separatorStyle    =   .None
        self.view.addSubview(tbleView!)
        tbleView?.selectRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), animated: true, scrollPosition: .None)
        if (isFromRegistration) {
            tbleView?.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .None)
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SideMenuController.homeHeadTapped), name: kLS_Noti_HomeHeadTapped, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SideMenuController.profileUpdated(_:)), name: kLS_Noti_ProfileUpdated, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setMenuArrayFunc () {
        if (GetAppDelegate().loginDetails!._specialityRole.isEqualToString("Agent") == true)
        {
            menuArray    =   [[ "title" :   "search",
                "image" :   "search.png"],
                [ "title" :   "home",
                    "image" :   "home.png"],
                [ "title" :   "Requests",
                    "image" :   "portIc.png"],
                [ "title" :   "My Artists",
                    "image" :   "myartist.png"],
                [ "title" :   "production book",
                    "image" :   "prodBkblack.png"],
                [ "title" :   "portfolio",
                    "image" :   "portIc.png"],
                [ "title" :   "wink boards",
                    "image" :   "winkIcon.png"],
//                [ "title" :   "settings",
//                    "image" :   "settings.png"],
                [ "title" :   "logout",
                    "image" :   "logout.png"]]
        }
        else
        {
            menuArray    =   [[ "title" :   "search",
                "image" :   "search.png"],
                [ "title" :   "home",
                    "image" :   "home.png"],
                [ "title" :   "Requests",
                    "image" :   "portIc.png"],
                [ "title" :   "production book",
                    "image" :   "prodBkblack.png"],
                [ "title" :   "portfolio",
                    "image" :   "portIc.png"],
                [ "title" :   "wink boards",
                    "image" :   "winkIcon.png"],
//                [ "title" :   "settings",
//                    "image" :   "settings.png"],
                [ "title" :   "logout",
                    "image" :   "logout.png"]]
        }
    }
    
    func profileUpdated (notification: NSNotification) {
        
        let userDetails =   (notification.object as? UserDetailsObj)
        GetAppDelegate().loginDetails!._firstName   =   (userDetails?._firstName)!
        GetAppDelegate().loginDetails!._lastName    =   (userDetails?._lastName)!
        GetAppDelegate().loginDetails!._specialityDesc  =   (userDetails?._specialitydesc)!
        GetAppDelegate().loginDetails!._specialityCode  =   (userDetails?._specialityCd)!
        GetAppDelegate().loginDetails!._userprofileImg  =   (userDetails?._imageurl)!
        GetAppDelegate().loginDetails!._specialityRole  =   (userDetails?._specialityRole)!
        GetAppDelegate().loginDetails!.updateImage()
        setMenuArrayFunc()
        
        tbleView?.reloadData()
        tbleView?.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .None)
    }
    func homeHeadTapped () {
        tbleView?.selectRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), animated: true, scrollPosition: .None)
        let Nav =   UINavigationController(rootViewController: FeedsViewController())
        Nav.navigationBar.translucent   =   false
        self.sideMenuViewController.setContentViewController(Nav , animated: true)
        self.sideMenuViewController.hideMenuViewController()
    }
    func messageBtnTapped () {
        MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row == 0)
        {
            return 80.0
        }
        return 60.0
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 20.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, (self.view.frame.size.width * (2.30/3.0)), 20)
        let ktitle : NSString =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        
        
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        
        let descLbl         =   UILabel(frame: CGRectMake(0,0, (self.view.frame.size.width * (2.30/3.0)) , 20))
        descLbl.textColor   =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 13.0)
        descLbl.textAlignment  =   .Center
        descLbl.text        =   ktitle as String
        customView.addSubview(descLbl)
        
        
        return customView
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray!.count + 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        if (indexPath.row == 0)
        {
            let kLbl : UILabel  =   UILabel(frame: CGRectMake(80, 0 + 20, (self.view.frame.size.width * (2.30/3.0)) - 80, 20))
            kLbl.text       =   "\(GetAppDelegate().loginDetails!._firstName) \(GetAppDelegate().loginDetails!._lastName)".uppercaseString
            kLbl.font       =   UIFont(name: Gillsans.Default.description, size: 18)
            kLbl.textColor  =   UIColor.blackColor()
            kLbl.textAlignment  =   NSTextAlignment.Left
            cell.addSubview(kLbl)
            
            let kLbl1 : UILabel  =   UILabel(frame: CGRectMake(80, 0 + 40, (self.view.frame.size.width * (2.30/3.0)) - 80, 30))
            kLbl1.text       =   "\(GetAppDelegate().loginDetails!._specialityDesc)".uppercaseString
            kLbl1.font       =   UIFont(name: Gillsans.Default.description, size: 12)
            kLbl1.textColor  =   UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1)
            kLbl1.textAlignment  =   NSTextAlignment.Left
            cell.addSubview(kLbl1)
            
            let sepImg1      =   UIImageView(frame: CGRectMake(0, 0 + 79, self.view.frame.size.width, 1))
            sepImg1.backgroundColor  =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            cell.addSubview(sepImg1)
            
            let profImg      =   UIImageView(frame: CGRectMake(10, 10, 60, 60))
//            profImg.image       =   UIImage(named: "NoImage1.png")
            profImg.layer.masksToBounds =   true
            profImg.layer.cornerRadius  =   30.0
            profImg.layer.borderWidth   =   2.0
            profImg.layer.borderColor   =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
            profImg.contentMode         =   .ScaleAspectFit
            cell.addSubview(profImg)
            GetAppDelegate().loginDetails!._delegate    =   self
            if (GetAppDelegate().loginDetails!._isThumbImgDownloadIntiated == false)
            {
                GetAppDelegate().loginDetails!.downloadThumbImg()
            }
            if ((GetAppDelegate().loginDetails!._isThumbImgDownloadIntiated) == true && (GetAppDelegate().loginDetails!._isThumbImgDownloaded == true))
            {
                profImg.image    =   GetAppDelegate().loginDetails!._thumbImg
            }
            
            return cell
        }
        
        let kImg        =   menuArray?.objectAtIndex(indexPath.row - 1).objectForKey("image") as? String
        let kTitle      =   menuArray?.objectAtIndex(indexPath.row - 1).objectForKey("title") as? String
        let imageView   =   UIImageView(frame: CGRectMake(18, 18, 24, 24))
        imageView.image =   UIImage(named: kImg!)
        cell.addSubview(imageView)
        
        let descLbl         =   UILabel(frame: CGRectMake(60,0, self.view.frame.size.width - 60 - 100 , 60))
        descLbl.text       =   kTitle!.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        let sepImg      =   UIImageView(frame: CGRectMake(0, 59, self.view.frame.size.width, 1))
        sepImg.image    =   UIImage(named: "dotted-line.png")
        cell.addSubview(sepImg)
        return cell
    }
    
    func feedImageDownloadReqFinished ()
    {
        self.tbleView?.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        if (GetAppDelegate().loginDetails!._specialityRole.isEqualToString("Agent") == true)
        {
            var vc  =   UIViewController()
            switch indexPath.row {
            case 0:
                vc  =   ProfileVC()
            case 1:
                vc  =   NewSearchViewController()
            case 2:
                vc  =   FeedsViewController()
            case 3:
                vc  =   RequestsVC()
            case 4:
                vc  =   MyArtistViewController()
            case 5:
                vc  =   ProductionbookListVC()
            case 6:
                vc  =   PortfolioListVC()
            case 7:
                vc  =   WinkBoardController()
            case 8:
                let alertController = UIAlertController(title: kLS_App_Name, message: "Do you want to logout of LENSPiRE?", preferredStyle: .Alert)
                let calcelAction = UIAlertAction(title: "CANCEL", style: .Default, handler: { (action) -> Void in
                    
                })
                alertController.addAction(calcelAction)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    SharedAppController().loadStartupView()
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            default:
                MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
                return
            }
            let Nav =   UINavigationController(rootViewController: vc)
            Nav.navigationBar.translucent   =   false
            self.sideMenuViewController.setContentViewController(Nav , animated: true)
            self.sideMenuViewController.hideMenuViewController()
        }
        else
        {
            var vc  =   UIViewController()
            switch indexPath.row {
            case 0:
                vc  =   ProfileVC()
            case 1:
                vc  =   NewSearchViewController()
            case 2:
                vc  =   FeedsViewController()
            case 3:
                vc  =   RequestsVC()
            case 4:
                vc  =   ProductionbookListVC()
            case 5:
                vc  =   PortfolioListVC()
            case 6:
                vc  =   WinkBoardController()
            case 7:
                let alertController = UIAlertController(title: kLS_App_Name, message: "Do you want to logout of LENSPiRE?", preferredStyle: .Alert)
                let calcelAction = UIAlertAction(title: "CANCEL", style: .Default, handler: { (action) -> Void in
                    
                })
                alertController.addAction(calcelAction)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                    SharedAppController().loadStartupView()
                })
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            default:
                MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
                return
            }
            let Nav =   UINavigationController(rootViewController: vc)
            Nav.navigationBar.translucent   =   false
            self.sideMenuViewController.setContentViewController(Nav , animated: true)
            self.sideMenuViewController.hideMenuViewController()
        }
    }
}

class ProdBookMenuController: UIViewController , UITableViewDelegate, UITableViewDataSource, FeedObjDelegate{
    
    var tbleView: UITableView?
    var menuArray: NSArray?
    
    var isFromRegistration : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        

        menuArray    =   [[ "title" :   "DETAILS",
                            "image" :   "search.png"],
                          [ "title" :   "PDF",
                            "image" :   "home.png"],
                          [ "title" :   "UPLOAD FILE",
                            "image" :   "myartist.png"]]
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "menu-head.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(SideMenuController.messageBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
    
        tbleView    =   UITableView(frame: CGRectMake(self.view.frame.size.width - self.view.frame.size.width * (2.5/3.0), 20, self.view.frame.size.width * (2.5/3.0), self.view.frame.size.height - 20), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
        //  tbleView?.alwaysBounceVertical =   false
        tbleView?.separatorStyle    =   .None
        self.view.addSubview(tbleView!)
       
      
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    deinit {
    }
    

   
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60.0
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.selectedBackgroundView = bgColorView
    
        
        let kImg        =   menuArray?.objectAtIndex(indexPath.row).objectForKey("image") as? String
        let kTitle      =   menuArray?.objectAtIndex(indexPath.row).objectForKey("title") as? String
        let imageView   =   UIImageView(frame: CGRectMake(18, 18, 24, 24))
        imageView.image =   UIImage(named: kImg!)
        cell.addSubview(imageView)
        
        let descLbl         =   UILabel(frame: CGRectMake(60,0, self.view.frame.size.width - 60 - 100 , 60))
        descLbl.text       =   kTitle!.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        let sepImg      =   UIImageView(frame: CGRectMake(0, 59, self.view.frame.size.width, 1))
        sepImg.image    =   UIImage(named: "dotted-line.png")
        cell.addSubview(sepImg)
        return cell
    }
    
    func feedImageDownloadReqFinished ()
    {
        self.tbleView?.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

        var vc  =   UIViewController()
        switch indexPath.row {
        case 0:
            vc  =   ProfileVC()
        case 1:
            vc  =   NewSearchViewController()
        case 2:
            vc  =   FeedsViewController()
            
        default:
            break
            
            self.sideMenuViewController.hideMenuViewController()
        }
    }
}


class ProductionbookListVC: UIViewController, TLSSegmentViewDelegate, CreateProducitonBookVCDelegate
{
    var segmentedControl: TLSSegmentView!
    var seletionBar: UIView = UIView()
    var contentView : UIView?
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    
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
        
//            let aButton1     =   UIButton(frame: CGRectMake(0, 0, 32, 32))
//            aButton1.setImage(UIImage(named: "plusIcon.png"), forState: .Normal)
//            aButton1.addTarget(self, action: "createBtnTapped", forControlEvents: .TouchUpInside)
//            
//            let aBarButtonItem1  =   UIBarButtonItem(customView: aButton1)
//            self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        
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
        segmentedControl.addSegments(["UPCOMING","PAST"])
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
    
    func createBtnTapped () {
        let createProdBookVC    =   CreateProducitonBookVC()
        createProdBookVC.delegate   =   self
        self.navigationController?.pushViewController(createProdBookVC, animated: true)
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
            let prodView            =   ProdBookCurrAndPastView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            prodView.prodBookContrl =   self
            prodView.kArtistID      =   kArtistID
            prodView.kArtistName    =   kArtistName
            contentView?.addSubview(prodView)
            prodView.loadDetails()
            break

        default:
            let prodView            =   ProdBookCurrAndPastView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            prodView.prodBookContrl =   self
            prodView.isCurrent      =   false
            prodView.kArtistID      =   kArtistID
            prodView.kArtistName    =   kArtistName
            contentView?.addSubview(prodView)
            prodView.loadDetails()
            break
        }
    }
    
   
}


class ProdBookCurrAndPastView: UIView, UITableViewDelegate, UITableViewDataSource , FeedObjDelegate {
    var prodBookContrl : UIViewController?
    var tbleView: UITableView?
    var keysArray: NSArray  =   NSArray()
    var detailsDict : NSDictionary?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var isCurrent : Bool = true
    var kArtistID : String  =   ""
    var kArtistName : String    =   ""
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
    }
    func loadDetails () {
        
        tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(ProductionBookCell.self, forCellReuseIdentifier: "LandProdCell")
        self.addSubview(tbleView!)
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No production book found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        var kSort   =   "0"
        if (isCurrent)
        {
            kSort   =   "1"
        }
        var kArID   =   kArtistID
        if (kArID == "")
        {
            kArID   =   getUserID() as String
        }
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kArID,kSort] , forKeys: [kLS_CP_UserId,kLS_CP_ArtistId,kLS_CP_SortId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ProductionBook_GetProductionBooks, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_PB_FromDt as String, ascending: true)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                            
                            let kKeysArr: NSMutableArray            =   NSMutableArray()
                            let kDetailDict: NSMutableDictionary    =   NSMutableDictionary()
                            
                            for  kDictionary in sortedArray {
                                let callSheet: CallSheet    =   CallSheet().setDetails(kDictionary as! NSDictionary, kDelegate: self as FeedObjDelegate)
                                let key =   productionbookSectionDateForDisplay(callSheet._PB_FromDt)
                                if (kKeysArr.containsObject(key))
                                {
                                    kDetailDict.objectForKey(key)?.addObject(callSheet)
                                }
                                else
                                {
                                    kKeysArr.addObject(key)
                                    kDetailDict.setObject(NSMutableArray(object: callSheet), forKey: key)
                                }
                            }
                            
                            if (self.isCurrent)
                            {
                                self.keysArray      =   NSArray(array: kKeysArr)
                            }
                            else
                            {
                                self.keysArray      =   NSArray(array: kKeysArr.reverseObjectEnumerator().allObjects)
                            }
                            self.detailsDict    =   NSDictionary(dictionary: kDetailDict)
                        }
                    }
                }
                if (isSuccess == false)
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
    
    func feedImageDownloadReqFinished () {
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        let CiLbl : UILabel     =   UILabel(frame: CGRectMake(20, 0, self.frame.size.width - 40, 50))
        CiLbl.text              =   self.keysArray.objectAtIndex(section).uppercaseString
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
        return self.keysArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.detailsDict?.objectForKey(self.keysArray.objectAtIndex(section))?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ProductionBookCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell") as! ProductionBookCell
        
        let callSheet: CallSheet    =   (self.detailsDict?.objectForKey((self.keysArray.objectAtIndex(indexPath.section)))?.objectAtIndex(indexPath.row))! as! CallSheet
        callSheet._delegate     =   cell as FeedObjDelegate
        cell.callSheet  =   callSheet
        
        cell.setDetails()
  
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
        
        let prodBook    =   ProductionbookViewVC()
        prodBook.productionBook      =   (self.detailsDict?.objectForKey((self.keysArray.objectAtIndex(indexPath.section)))?.objectAtIndex(indexPath.row))! as? CallSheet
        if (self.kArtistID != "")
        {
            prodBook.kArtistID   =   kArtistID
            prodBook.kArtistName    =   kArtistName
        }
        prodBookContrl!.navigationController?.pushViewController(prodBook, animated: true)
        
    }

}

class ProductionBookCell: UITableViewCell , FeedObjDelegate{
    
    var callSheet : CallSheet!  =    nil
    var imgView : UIImageView?
    var descLbl : UILabel?
    var descLbl1 : UILabel?
    var descLbl2 : UILabel?
    var descLbl3 : UILabel?
    var arrowImg : UIImageView?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        self.selectedBackgroundView = bgColorView
        
        imgView   =   UIImageView(frame: CGRectMake(30, 10, 60, 60))
        imgView!.layer.masksToBounds =   true
        imgView!.layer.cornerRadius  =   30.0
        imgView!.layer.borderWidth   =   2.0
        imgView!.contentMode       =   .ScaleAspectFit
        imgView!.backgroundColor     =   UIColor.whiteColor()
        imgView!.layer.borderColor   =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        self.addSubview(imgView!)
        
        descLbl        =   UILabel(frame: CGRectMake(100,10, UIScreen.mainScreen().bounds.size.width - 100 - 30 , 20))
        
        descLbl!.textColor  =   UIColor.blackColor()
        descLbl!.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
        descLbl!.textAlignment   =   .Left
        self.addSubview(descLbl!)
        
        descLbl1        =   UILabel(frame: CGRectMake(100,30, UIScreen.mainScreen().bounds.size.width - 100 - 30 , 20))
        
        descLbl1!.textColor  =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        descLbl1!.font       =   UIFont(name: Gillsans.Italic.description, size: 12.0)
        descLbl1!.textAlignment  =   .Left
        self.addSubview(descLbl1!)
        
        descLbl2        =   UILabel(frame: CGRectMake(100,50, 60 , 20))
        descLbl2!.text       =   "Agency:".uppercaseString
        descLbl2!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl2!.font       =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl2!.textAlignment  =   .Left
        self.addSubview(descLbl2!)
        
        descLbl3        =   UILabel(frame: CGRectMake(150,50, UIScreen.mainScreen().bounds.size.width - 150 - 30 , 20))
        
        descLbl3!.textColor  =   UIColor.blackColor()
        descLbl3!.font       =   UIFont(name: Gillsans.Default.description, size: 13.0)
        descLbl3!.textAlignment  =   .Left
        self.addSubview(descLbl3!)
        
        arrowImg      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg!.image    =   UIImage(named: "arrow.png")
        self.addSubview(arrowImg!)
        arrowImg!.center.x   =   UIScreen.mainScreen().bounds.size.width - 15.0
        arrowImg!.center.y   =   40.0
        
       
    }
    
    func setDetails () {
        descLbl!.text       =   "\(callSheet!._ProjectName)".uppercaseString
        descLbl1!.text      =   "\(productionbookDetailDateForDisplay(callSheet._PB_FromDt)) to \(productionbookDetailDateForDisplay(callSheet._PB_ToDt))"
        descLbl3!.text      =   "\(callSheet._AgencyName)".capitalizedString
        imgView!.image      =   callSheet._thumbImg
        
        if (callSheet._LogoURL.isEqualToString("") == false)
        {
            if (callSheet._isThumbImgDownloadIntiated == false)
            {
                callSheet.downloadThumbImg()
            }
            if ((callSheet._isThumbImgDownloadIntiated) == true && (callSheet._isThumbImgDownloaded == true))
            {
                imgView!.image    =   callSheet._thumbImg
            }
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func feedImageDownloadReqFinished () {
        imgView!.image    =   callSheet._thumbImg
    }
}

