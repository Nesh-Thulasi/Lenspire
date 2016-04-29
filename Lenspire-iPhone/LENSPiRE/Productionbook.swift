//
//  Productionbook.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 06/11/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation
import MessageUI
import EventKit
import MapKit
import CoreLocation

class ProductionbookViewVC: UIViewController, TLSSegmentViewDelegate
{
    var productionBook : CallSheet?
    var segmentedControl: TLSSegmentView!
    var seletionBar: UIView = UIView()
    var contentView : UIView?
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    var outStandingObjects : NSArray    =   NSArray()
    var oustandingConfirmView : OustandingAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(ProductionbookViewVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let aButton1     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton1.setImage(UIImage(named: "info.png"), forState: .Normal)
        aButton1.addTarget(self, action: #selector(ProductionbookViewVC.infoBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem1  =   UIBarButtonItem(customView: aButton1)
        
        let aButton2     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton2.setImage(UIImage(named: "pdf.png"), forState: .Normal)
        aButton2.addTarget(self, action: #selector(ProductionbookViewVC.pdfBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem2  =   UIBarButtonItem(customView: aButton2)
        self.navigationItem.setRightBarButtonItems([aBarButtonItem1,aBarButtonItem2], animated: true)
        
        let kTempView   =   UIView(frame: CGRectMake(0,0,self.view.frame.size.width - 100, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100 , 24))
        descLbl.text       =   "\(productionBook!._ProjectName)".uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        
        let descLbl1        =   UILabel(frame: CGRectMake(0,24, self.view.frame.size.width - 100, 20))
        descLbl1.text       =   "\(productionbookDetailDateForDisplay(productionBook!._PB_FromDt)) - \(productionbookDetailDateForDisplay(productionBook!._PB_ToDt))"
        descLbl1.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl1.font       =   UIFont(name: Gillsans.Italic.description, size: 13.0)
        descLbl1.textAlignment  =   .Center
        kTempView.addSubview(descLbl1)
        self.navigationItem.titleView   =   kTempView
        
        contentView     =   UIView(frame: CGRectMake(0,50.0,self.view.frame.size.width, self.view.frame.size.height - 50.0 - 64.0))
        contentView?.backgroundColor    =   UIColor.whiteColor()
        self.view.addSubview(contentView!)
        
        
        segmentedControl    =   TLSSegmentView(frame: CGRectMake(0, 0, self.view.frame.size.width, 50), textColor: UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1), selectedTextColor: UIColor.blackColor(), textFont: UIFont(name: Gillsans.Default.description, size: 15.0)!)
        segmentedControl.delegate = self
        segmentedControl.addSegments(["SCHEDULE","CALLSHEET","TRAVEL"])
        self.view.addSubview(segmentedControl)
        
        let kTempBar    = UIView(frame:CGRect(x: 0.0, y: 47.0, width: self.view.frame.size.width, height: 3.0))
        kTempBar.backgroundColor    =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        self.segmentedControl.addSubview(kTempBar)
        self.seletionBar.frame = CGRect(x: 0.0, y: 47.0, width: 100, height: 3.0)
        self.seletionBar.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.41, alpha: 1)
        self.segmentedControl.addSubview(self.seletionBar)
        
        self.segmentedControl.selectSegementAtIndex(0)
        
        
        loadOutstandingActions ()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func loadOutstandingActions () {
        if (self.oustandingConfirmView != nil) {
            self.oustandingConfirmView.removeFromSuperview()
            self.oustandingConfirmView =   nil
        }
        self.outStandingObjects =   NSArray()
        let kPBID: String   =  productionBook!._PB_Id as String
        let dict1: NSMutableDictionary   =
        NSMutableDictionary(objects: [getUserID(), kPBID , self.kArtistID.trim() == "" ? getUserID() : self.kArtistID] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionbookId,kLS_CP_ArtistId])
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Callsheet_GetOutstandingConfirmDates, parm: dict1, completion: { result , desc , code in
            if ( code == 99)
            {
                print(result)
                if  (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if ( kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                        
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true)
                        {
                            let kObjsArr: NSMutableArray            =   NSMutableArray()
                            
                            for  kDictionary in (kArr as? NSArray)!{
                                let outstandingObj: OutstandingConfirmDate    =   OutstandingConfirmDate().setDetails(kDictionary as! NSDictionary)
                                kObjsArr.addObject(outstandingObj)
                            }
                            
                            self.outStandingObjects =   NSArray(array: kObjsArr)
                            
                            if (self.outStandingObjects.count > 0) {
                               self.oustandingConfirmView    =   OustandingAlertView().showMessage(self.view, completion: { () -> () in
                                let outstand    =   OutstandingConfirmationView(frame: CGRectMake(0,0,GetAppDelegate().window!.frame.size.width,GetAppDelegate().window!.frame.size.height))
                                outstand.objectsArr =   self.outStandingObjects
                                outstand.prodBook   =   self.productionBook
                                
                                outstand.loadView()
                                outstand.cmpltnHandler({ () -> () in
                                    self.loadOutstandingActions()
                                })
                                
                                GetAppDelegate().window?.rootViewController!.view.addSubview(outstand)
                                
                               })
                                self.view.bringSubviewToFront(self.oustandingConfirmView)
                            }
                        }
                    }
                }
            }
        })
        
    }
    func scheduleCreated () {
        self.segmentedControl.selectSegementAtIndex(0)
    }
    
    func callsheetCrewAdded () {
        self.segmentedControl.selectSegementAtIndex(1)
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
            let schView         =   ScheduleView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            schView.prodBook    =   self.productionBook
            schView.viewController  =   self
            if (self.kArtistID != "")
            {
                schView.kArtistID   =   kArtistID
                schView.kArtistName =   self.kArtistName
            }
            contentView?.addSubview(schView)
            schView.loadDetails()
            break
        case 1:
            let schView         =   CallsheetView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            schView.prodBook    =   self.productionBook
            schView.viewController  =   self
            contentView?.addSubview(schView)
            schView.loadDetails()
            break
        default:
            let schView         =   TravelView(frame: CGRectMake(0,0,(contentView?.frame.size.width)!,(contentView?.frame.size.height)!))
            schView.prodBook    =   self.productionBook
            schView.viewController  =   self
            if (self.kArtistID != "")
            {
                schView.kArtistID   =   kArtistID
                schView.kArtistName =   self.kArtistName
            }
            contentView?.addSubview(schView)
            schView.loadDetails()
            break
        }
        
        if (self.oustandingConfirmView != nil) {
            self.view.bringSubviewToFront(self.oustandingConfirmView)
        }
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func infoBtnTapped () {
        let pbDetails   =   PBDetailsView()
        pbDetails.prodBook  =   self.productionBook
        self.navigationController?.pushViewController(pbDetails, animated: true)
    }
    func pdfBtnTapped () {
//        let kView       =   UploadDealMemo()
//        kView.productionBook    =   self.productionBook
//        self.navigationController?.pushViewController(kView, animated: true)
//        return
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [(self.productionBook?._PB_Id)!,getUserID()] , forKeys: [kLS_CP_ProductionBookId,kLS_CP_UserId])
        
        ServiceWrapper(frame: self.view.frame).postToCloud(kLS_CM_Callsheet_generateCallSheetPDF, parm: dict, completion: { result , desc , code in
            
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                {
                    let kString  =   result.objectForKey(kLS_CP_status) as! String
                    
                    if (kString     ==  (kLS_CP_success as String))
                    {
                        let kFileName   =   result.objectForKey(kLS_CP_FileName) as! String
                        let kFilePath   =   result.objectForKey(kLS_CP_FilePath) as! String
                        
                        
                        let attachmntVC =   AttachmentView()
                        attachmntVC.kURLString  =   "\(NSUserDefaults.standardUserDefaults().objectForKey("ServerSetting") as! NSString)\(kFilePath)"
                        attachmntVC.kTitle   =  (self.productionBook?._ProjectName)! as String
                        self.presentViewController(UINavigationController(rootViewController: attachmntVC), animated: true) { () -> Void in
                            
                        }
                    }
                    else
                    {
                        ShowAlert(kLS_Err_Msg)
                    }
                }
                else
                {
                    ShowAlert(kLS_Err_Msg)
                }
            }
            else
            {
                ShowAlert(desc)
            }
        })

    }
}

class UploadDealMemo : UIViewController, UITextFieldDelegate {
    
    var productionBook : CallSheet?
    var fileNameTxtFld: UITextField?
    var fileNameContainer : UIView?
    var chkImg1 : UIImageView?
    var chkImg2 : UIImageView?
    var allCrewView : UIView?
    var selectCrewView : UIView?
    var selectCrewLbl : UILabel?
    var uploadFileView : UIView?
    var linkToWinkBoard : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(UploadDealMemo.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 24))
        descLbl.text       =   "\(productionBook!._ProjectName)".uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   12
        
        let descLbl1        =   UILabel(frame: CGRectMake(0,24, self.view.frame.size.width - 100, 20))
        descLbl1.text       =   "\(productionbookDetailDateForDisplay(productionBook!._PB_FromDt)) - \(productionbookDetailDateForDisplay(productionBook!._PB_ToDt))"
        descLbl1.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl1.font       =   UIFont(name: Gillsans.Italic.description, size: 13.0)
        descLbl1.textAlignment  =   .Center
        descLbl1.center.x    =   1
        descLbl1.center.y    =   34
        kTempView.addSubview(descLbl1)
        
        self.navigationItem.titleView   =   kTempView
        
        var  kStrtY : CGFloat = 20.0
        
        let descLbl2        =   UILabel(frame: CGRectMake(0,kStrtY, self.view.frame.size.width, 20))
        descLbl2.text       =   "LABEL FILE (IE: MENU, DEAL MEMO)"
        descLbl2.textColor  =   UIColor.blackColor()
        descLbl2.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl2.textAlignment  =   .Center
        self.view.addSubview(descLbl2)
        
        kStrtY  =   kStrtY + 30.0
        
        fileNameContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.view.addSubview(fileNameContainer!)
        
        
        fileNameTxtFld              =   UITextField(frame: CGRectMake(0,0,(fileNameContainer?.frame.size.width )!,40))
        fileNameTxtFld!.delegate    =   self
        fileNameTxtFld?.backgroundColor =   UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
        fileNameTxtFld?.placeholder =   "".capitalizedString
        fileNameTxtFld?.layer.masksToBounds =   true
        fileNameTxtFld?.layer.cornerRadius  =   20.0
        fileNameTxtFld?.textAlignment  =   .Left
        fileNameTxtFld?.autocapitalizationType  =   .AllCharacters
        fileNameTxtFld?.keyboardType    =   UIKeyboardType.Default
        fileNameTxtFld?.textAlignment   =   .Center
        fileNameTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        fileNameContainer!.addSubview(fileNameTxtFld!)
    
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        let descLbl3        =   UILabel(frame: CGRectMake(0,kStrtY, self.view.frame.size.width, 20))
        descLbl3.text       =   "SHARE UPLOADED FILES WITH"
        descLbl3.textColor  =   UIColor.blackColor()
        descLbl3.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl3.textAlignment  =   .Center
        self.view.addSubview(descLbl3)
        
        kStrtY  =   kStrtY + 25.0
        
        allCrewView   =   UIView(frame: CGRectMake(0,kStrtY, self.view.frame.size.width / 2.0 , 40.0))
        self.view.addSubview(allCrewView!)
        
        selectCrewView   =   UIView(frame: CGRectMake(self.view.frame.size.width / 2.0,kStrtY, self.view.frame.size.width / 2.0 , 40.0))
        self.view.addSubview(selectCrewView!)
        
        var kWidth  =   widthForView("ALL CREW", font: UIFont.init(name: Gillsans.Default.description, size: 15.0)!)
        kWidth  = kWidth + 20.0
        
        let kTempview1   =   UIView(frame: CGRectMake(0,0, kWidth , 40.0))
        allCrewView!.addSubview(kTempview1)
        kTempview1.center.x  =   self.view.frame.size.width / 4.0
        
        chkImg1  =   UIImageView(frame: CGRectMake(0, 0, 20, 20))
        kTempview1.addSubview(chkImg1!)
        chkImg1!.center.x     =   0
        chkImg1!.center.y     =   20
        chkImg1!.image    =   UIImage(named: "white-round.png")
        
        let descLbl4        =   UILabel(frame: CGRectMake(20,0, kWidth - 20, 40))
        descLbl4.text       =   "ALL CREW"
        descLbl4.textColor  =   UIColor.blackColor()
        descLbl4.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl4.textAlignment  =   .Left
        kTempview1.addSubview(descLbl4)
        
        var kWidth1  =   widthForView("SELECT CREW", font: UIFont.init(name: Gillsans.Default.description, size: 15.0)!)
        kWidth1  = kWidth1 + 20.0
        
        let kTempview2   =   UIView(frame: CGRectMake(0,0, kWidth1 , 40.0))
        selectCrewView!.addSubview(kTempview2)
        kTempview2.center.x  =   self.view.frame.size.width / 4.0
        
        chkImg2  =   UIImageView(frame: CGRectMake(0, 0, 20, 20))
        kTempview2.addSubview(chkImg2!)
        chkImg2!.center.x     =   0
        chkImg2!.center.y     =   20
        chkImg2!.image    =   UIImage(named: "white-round.png")
        
        selectCrewLbl        =   UILabel(frame: CGRectMake(20,0, kWidth1 - 20, 40))
        selectCrewLbl!.text       =   "SELECT CREW"
        selectCrewLbl!.textColor  =   UIColor.blackColor()
        selectCrewLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        selectCrewLbl!.textAlignment  =   .Left
        kTempview2.addSubview(selectCrewLbl!)
        
        allCrewView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UploadDealMemo.allCrewTapped)))
        selectCrewView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UploadDealMemo.selectCrewTapped)))
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        uploadFileView  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 80))
        self.view.addSubview(uploadFileView!)
        uploadFileView?.layer.cornerRadius  =   8.0
        uploadFileView?.layer.borderWidth   =   1.0
        uploadFileView?.layer.borderColor   =   UIColor.blackColor().CGColor
        
        let descLbl5        =   UILabel(frame: CGRectMake(0,50, uploadFileView!.frame.size.width, 30))
        descLbl5.text       =   "UPLOAD FILE"
        descLbl5.textColor  =   UIColor.blackColor()
        descLbl5.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl5.textAlignment  =   .Center
        uploadFileView!.addSubview(descLbl5)

        kStrtY      =   kStrtY + 80.0 + 20.0
        
        linkToWinkBoard  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 80))
        self.view.addSubview(linkToWinkBoard!)
        linkToWinkBoard?.layer.cornerRadius  =   8.0
        linkToWinkBoard?.layer.borderWidth   =   1.0
        linkToWinkBoard?.layer.borderColor   =   UIColor.blackColor().CGColor
        
        let descLbl6        =   UILabel(frame: CGRectMake(0,50, uploadFileView!.frame.size.width, 30))
        descLbl6.text       =   "LINK TO WINK BOARD"
        descLbl6.textColor  =   UIColor.blackColor()
        descLbl6.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl6.textAlignment  =   .Center
        linkToWinkBoard!.addSubview(descLbl6)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func allCrewTapped () {
        chkImg1!.image    =   UIImage(named: "yellow-round.png")
        chkImg2!.image    =   UIImage(named: "white-round.png")
    }
    
    func selectCrewTapped() {
        chkImg1!.image    =   UIImage(named: "white-round.png")
        chkImg2!.image    =   UIImage(named: "yellow-round.png")
    }
}

class ScheduleView: UIView, UITableViewDelegate, UITableViewDataSource {
    var tbleView: UITableView?
    var shootScheduleArray: NSArray =   NSArray()
    var upcomingScheduleArray: NSArray  =   NSArray()
    var detailsDict: NSDictionary?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var prodBook : CallSheet?
    var viewController : ProductionbookViewVC?
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
    }
    func iCalTapped (sender : UIButton) {
        
        let alertController = UIAlertController(title: kLS_App_Name, message: "Do you want to add events to calendar?", preferredStyle: .Alert)
        let calcelAction = UIAlertAction(title: "CANCEL", style: .Default, handler: { (action) -> Void in
            
        })
        alertController.addAction(calcelAction)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let eventStore = EKEventStore()
            let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
            
            switch (status)
            {
            case EKAuthorizationStatus.NotDetermined:
                // This happens on first-run
                eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
                    (accessGranted: Bool, error: NSError?) in
                    if accessGranted == true {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.addAllEvents(eventStore, kArray: (sender.tag == 0 ? self.upcomingScheduleArray: self.shootScheduleArray))
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            ShowAlert("Calendar access denied.")
                        })
                    }
                })
            case EKAuthorizationStatus.Authorized:
                // Things are in line with being able to show the calendars in the table view
                dispatch_async(dispatch_get_main_queue(), {
                    self.addAllEvents(eventStore, kArray: (sender.tag == 0 ? self.upcomingScheduleArray: self.shootScheduleArray))
                })
                
            case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
                // We need to help them give us permission
                dispatch_async(dispatch_get_main_queue(), {
                    ShowAlert("Calendar access denied.")
                })
            }
        })
        alertController.addAction(okAction)
        self.viewController!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func addAllEvents (kEventStore: EKEventStore , kArray : NSArray) {
        var isSuccess = false
        for scheEvent in kArray {
            if (scheEvent.isKindOfClass(ScheduleEvent) == true)
            {
                let kDate   =   (scheEvent as? ScheduleEvent)?._scheduleDate
                let kTime   =   (scheEvent as? ScheduleEvent)?._scheduleTime.uppercaseString
                let kfinDate   =   getScheduleDateFromString("\(kDate!) \(kTime!)")
                if (NSDate().isLessThanDate(kfinDate))
                {
                    isSuccess   =   true
                    let event:EKEvent = EKEvent(eventStore: kEventStore)
                    let alarm       =   EKAlarm()
                    let kDate       =   kfinDate
                    let kHalfDate   =   kfinDate.addHours(-0.5)
                    event.title     =   prodBook!._ProjectName.capitalizedString + "- Schedule"
                    event.startDate =   kHalfDate
                    event.endDate   =   kDate
                    
                    if (event.title == "")
                    {
                        event.title =   "LENSPiRE EVENT"
                    }
                    
                    if (kHalfDate.isGreaterThanDate(NSDate()))
                    {
                        event.alarms    =   [alarm]
                    }
                    
                    if (((scheEvent as? ScheduleEvent)?._locationName as! String).trim() != "")
                    {
                        event.location  =   (scheEvent as? ScheduleEvent)?._locationName as? String
                    }
                    
                 //   event.URL   =   NSURL(string:"pb://\(prodBook!._PB_Id)")
                    event.notes     =   "ACTION:\n" + (scheEvent as? ScheduleEvent)!._scheduleAction.capitalizedString + "\n\n" + "NOTES:\n" + (scheEvent as? ScheduleEvent)!._scheduleNotes.capitalizedString
                    event.calendar  =   kEventStore.defaultCalendarForNewEvents
                    do {
                        try kEventStore.saveEvent(event, span: EKSpan.ThisEvent)
                    }
                    catch {
                    }
                    
                }
            }
        }
        if (isSuccess)
        {
            ShowAlert("Events has been added to calendar.")
        }
        else
        {
            ShowAlert("No upcoming events are available.")
        }
    }
    
    private var myContext = 0
    
    deinit {
        prodBook?.removeObserver(self, forKeyPath: "_thumbImg")
    }
    
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &myContext {
            if let newValue = change?[NSKeyValueChangeNewKey] {
                print("Image: \(newValue)")
                self.tbleView?.reloadData()
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }

    
    func loadDetails () {
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No schedule found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        var kArtistUserId   =   "%"
        if (self.kArtistID != "")
        {
            kArtistUserId  =   self.kArtistID
        }
        
        
        let kPBID: String   =  prodBook!._PB_Id as String
        let dict1: NSMutableDictionary   =
        NSMutableDictionary(objects: [getUserID(), kPBID , "%", kArtistUserId] , forKeys: [kLS_CP_userId,kLS_CP_productionBookId,kLS_CP_date,kLS_CP_artistUserId])
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Schedule_GetScheduleEvent, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                        
                        
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                        {
                            isSuccess   =   true
                            
                            let kArr1   =   NSMutableArray()
                            let kArr2   =   NSMutableArray()
                            let kArr3   =   NSMutableArray()
                            
                            for kDict in (kArr as? NSArray)!
                            {
                                let kDict1  =   NSMutableDictionary(dictionary: kDict as! [NSObject : AnyObject])
                                let kdate   =   getScheduleDateFromString("\(kDict.objectForKey(kLS_CP_scheduleDate)!) \(kDict.objectForKey(kLS_CP_scheduleTime)!)")
                                kDict1.setObject(kdate, forKey: "sortKey")
                                
                             //   kDict1.setObject("\(kDict.objectForKey(kLS_CP_scheduleDate)) \(kDict.objectForKey(kLS_CP_scheduleTime))", forKey: "sortKey")
                                kArr1.addObject(kDict1)
                            }
                            
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: "sortKey", ascending: true)
                            let sortedArray: NSArray = NSArray(array: kArr1 as NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                            
                            for kDic in sortedArray
                            {
                                let scheEv: ScheduleEvent =  ScheduleEvent().setDetails(kDic as! NSDictionary)
                                
                                if (kArr2.containsObject(scheEv._scheduleDate) == false)
                                {
                                    kArr2.addObject(scheEv._scheduleDate)
                                }
                                kArr2.addObject(scheEv)
                                if (self.kArtistID == "")
                                {
                                    if (scheEv._artistUserId.componentsSeparatedByString(",").contains(getUserID() as String))
                                    {
                                        kArr3.addObject(scheEv)
                                    }
                                }
                                else
                                {
                                    if (scheEv._artistUserId.componentsSeparatedByString(",").contains(self.kArtistID as String))
                                    {
                                        kArr3.addObject(scheEv)
                                    }
                                }
                            }
                            
                            self.shootScheduleArray     =   NSArray(array: kArr2)
                            self.upcomingScheduleArray  =   NSArray(array: kArr3)
                        }
                    }
                }
                
                if (self.shootScheduleArray.count > 0) {
                    self.tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
                    self.tbleView?.delegate      =   self
                    self.tbleView?.dataSource    =   self
                    self.tbleView?.separatorStyle    =   .None
                    self.tbleView?.registerClass(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
                    self.addSubview(self.tbleView!)
                }
                
                if (isSuccess == false || self.shootScheduleArray.count == 0)
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
        })
        
        prodBook?.addObserver(self, forKeyPath: "_thumbImg", options: .New, context: &myContext)
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
   
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
     
        
        let descLbl         =   UILabel(frame: CGRectMake(60,0, self.frame.size.width - 60 - 10 , 50))
        descLbl.textColor   =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 13.0)
        descLbl.textAlignment  =   .Left
        descLbl.text        =   "SHOOT SCHEDULE"
        customView.addSubview(descLbl)
        
        
        
        if (((section == 0) && (upcomingScheduleArray.count > 0)) || ((section == 1) && (shootScheduleArray.count > 0)))
        {
            let scheBtn         =   UIButton(type: .Custom)
            scheBtn.setImage(UIImage(named: "ical.png"), forState: .Normal)
            scheBtn.frame       =   CGRectMake(self.frame.size.width - 44, 0, 40, 50)
            scheBtn.tag         =   section
            scheBtn.addTarget(self, action: #selector(ScheduleView.iCalTapped(_:)), forControlEvents: .TouchUpInside)
            customView.addSubview(scheBtn)
        }
        
        
        let imageView   =   UIImageView(frame: CGRectMake(15, 10, 30, 30))
        imageView.image =   UIImage(named: "calendar.png")
        customView.addSubview(imageView)
        
        return customView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
     
        let scheEvent : AnyObject    =   self.shootScheduleArray.objectAtIndex(indexPath.row)
        if (scheEvent.isKindOfClass(NSString) == true)
        {
            return  50.0
        }
        else
        {
            
            let height = heightForView(((scheEvent as? ScheduleEvent)?._scheduleNotes as? String)!, font: UIFont(name: Gillsans.Italic.description, size: 15.0)!, width: self.frame.size.width - 85 - 40)
            
            if (height > 20.0)
            {
                return 60.0 + height - 20.0
            }
        }
        return  60.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.shootScheduleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ScheduleCell   =   (tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell)!
        cell.selectionStyle     =   .None
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        
        let scheEvent : AnyObject    =   self.shootScheduleArray.objectAtIndex(indexPath.row)
        if (scheEvent.isKindOfClass(NSString) == true)
        {
            let descLbl         =   UILabel(frame: CGRectMake(60,15, self.frame.size.width - 60 - 10 , 30))
            descLbl.text        =   scheduleDetailDateForDisplay((scheEvent as? String)!).uppercaseString
            descLbl.textColor   =   UIColor.blackColor()
            descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl.textAlignment  =   .Left
            cell.addSubview(descLbl)
            
            let kDate   =   getDateFromString((scheEvent as? String)!)
            if (kDate.isGreaterThanDate(NSDate())) {
                let kButton     =   ScheduleButton(type: .Custom)
                kButton.date    =   kDate
                kButton.kStrDate    =   (scheEvent as? String)!
                kButton.setImage(UIImage(named: "add-yel.png"), forState: .Normal)
                kButton.addTarget(self, action: #selector(ScheduleView.createScheduleTapped(_:)), forControlEvents: .TouchUpInside)
                kButton.frame   =   CGRectMake(self.frame.size.width - 40,15, 30 , 30)
//                cell.addSubview(kButton)
            }
            
            let imageView       =   UIImageView(frame: CGRectMake(70,45, self.frame.size.width - 70 , 1))
            imageView.backgroundColor   =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
            cell.addSubview(imageView)
        }
        else
        {
            
            let descLbl2        =   UILabel(frame: CGRectMake(70,0, 60 , 25))
            descLbl2.text       =   (scheEvent as? ScheduleEvent)?._scheduleTime.uppercaseString
            descLbl2.textColor  =   UIColor.blackColor()
            descLbl2.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
            descLbl2.textAlignment  =   .Left
            cell.addSubview(descLbl2)
            
            let descLbl3        =   UILabel(frame: CGRectMake(135,0, self.frame.size.width - 135 - 40 , 25))
            descLbl3.text       =   ((scheEvent as? ScheduleEvent)?._scheduleAction as? String)?.uppercaseString
            descLbl3.textColor  =   UIColor.blackColor()
            descLbl3.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
            descLbl3.textAlignment  =   .Left
            cell.addSubview(descLbl3)
            
            let descLbl        =   UILabel(frame: CGRectMake(85,25, self.frame.size.width - 85 - 40 , 20))
            descLbl.text       =   (scheEvent as? ScheduleEvent)?._scheduleNotes as? String
            descLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            descLbl.font        =   UIFont(name: Gillsans.Italic.description, size: 15.0)
            descLbl.textAlignment  =   .Left
            descLbl.numberOfLines   =   0
            cell.addSubview(descLbl)
            
            let height = heightForView(((scheEvent as? ScheduleEvent)?._scheduleNotes as? String)!, font: UIFont(name: Gillsans.Italic.description, size: 15.0)!, width: self.frame.size.width - 85 - 40)
            
            if (height > 20.0)
            {
                descLbl.frame   =   CGRectMake(85,25, self.frame.size.width - 85 - 40 , height)
            }
            if (self.upcomingScheduleArray.containsObject(scheEvent) == true) {
                let imageView   =   UIImageView(frame: CGRectMake(30, 8, 12, 12))
                imageView.backgroundColor   =   UIColor.yellowColor()
                imageView.layer.cornerRadius    =   6.0
                imageView.layer.borderWidth     =   1.0
                imageView.layer.borderColor     =   UIColor.blackColor().CGColor
                cell.addSubview(imageView)
            }
          
            if (((scheEvent as? ScheduleEvent)?._latLng as! String).trim() != "")
            {
                let scheBtn         =   ScheduleButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                scheBtn.scheObj     =   scheEvent as? ScheduleEvent
                scheBtn.frame       =   CGRectMake(self.frame.size.width - 40, 0, 30, 30)
                scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
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
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       /*
        if (noOfSections == 2)
        {
            if (indexPath.section == 0)
            {
                return
            }
        }
        
        let scheEvent : AnyObject    =   self.shootScheduleArray.objectAtIndex(indexPath.row)
        if (scheEvent.isKindOfClass(NSString) == true)
        {
        }
        else
        {
            let createSchVc         =   CreateScheduleVC()
            createSchVc.isEditMode  =   true
            createSchVc.scheduleEvent   =   scheEvent as! ScheduleEvent
            createSchVc.pbDate      =   (scheEvent as! ScheduleEvent)._scheduleDate
            createSchVc.viewController  =   viewController
            createSchVc.productionBookId    =   (self.prodBook?._PB_Id)!
            self.viewController?.navigationController?.pushViewController(createSchVc, animated: true)
        }
*/
    }
    
    func createScheduleTapped (sender : ScheduleButton) {
        
        let createSchVc =   CreateScheduleVC()
        createSchVc.pbDate  =   sender.kStrDate!
        createSchVc.viewController  =   viewController
        createSchVc.productionBookId    =   (self.prodBook?._PB_Id)!
        self.viewController?.navigationController?.pushViewController(createSchVc, animated: true)
    }
    
    func locateTapped (sender: ScheduleButton) {
        let mapDisp         =   MapDisplayView()
        mapDisp.kTitle      =   (sender.scheObj?._scheduleAction)! as String
        mapDisp.kSubtitle   =   (sender.scheObj?._locationName)! as String
        if (sender.scheObj!._latLng.isEqualToString("") == false)
        {
            mapDisp.kLat        =   sender.scheObj!._latLng.componentsSeparatedByString(",")[0]
            mapDisp.kLang       =   sender.scheObj!._latLng.componentsSeparatedByString(",")[1]
        }
        self.viewController?.navigationController?.pushViewController(mapDisp, animated: true)
    }

}

class ScheduleCell: UITableViewCell {
    
}

class ScheduleButton : UIButton {
    var scheObj: ScheduleEvent?
    var date : NSDate?
    var kStrDate : NSString?
    
}

class CallsheetCrewButton : UIButton {
    var castID: String?
    var castCode : String?
    
}

class TravelButton : UIButton {

    var ktitle : String     =   ""
    var kSubTitle : String  =   ""
    var kLatLang : NSString =   ""
    var kLat : String       =   ""
    var kLang : String      =   ""
}

class InfoDetailButton : UIButton {
    var locObj: LocationObj?
    
}

class AttachmentButton : UIButton {
    var attachmentUrl: String?
    var kTitle : String?
    
}

class CallsheetButton : UIButton {
    var callObj: callSheetObj?
    
}
protocol CallsheetCellDelegate {
    func cellOpened ()
}
class CallsheetCell: UITableViewCell {
    
    var nameLbl : UILabel?
    var callSheetDate : UILabel?
    var callSheetTime : UILabel?
    var mailBtn : CallsheetButton?
    var callBtn : CallsheetButton?
    var kView : UIView?
    var kView1 : UIView?
    var firstLocation: CGPoint?
    var isOpen : Bool   =   false
    var delegate   : CallsheetCellDelegate!   =   nil
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        kView       =   UIView(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width , 44))
        kView!.backgroundColor   =   UIColor(red: 0.87, green: 0.87, blue: 0.41, alpha: 1)
        self.contentView.addSubview(kView!)
        
        kView1       =   UIView(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width , 44))
        kView1!.backgroundColor   =   UIColor.whiteColor()
        self.contentView.addSubview(kView1!)
        
        mailBtn         =   CallsheetButton(type: .Custom)
        mailBtn?.setImage(UIImage(named: "msg.png"), forState: .Normal)
        mailBtn?.frame  =   CGRectMake(UIScreen.mainScreen().bounds.size.width - 120, 0, 60, 44)
        kView!.addSubview(mailBtn!)
        mailBtn?.tag    =   0
        callBtn         =   CallsheetButton(type: .Custom)
        callBtn?.setImage(UIImage(named: "phone.png"), forState: .Normal)
        callBtn?.frame  =   CGRectMake(UIScreen.mainScreen().bounds.size.width - 60, 0, 60, 44)
        kView!.addSubview(callBtn!)
        callBtn?.tag    =   1
        
        nameLbl                 =   UILabel(frame: CGRectMake(60,0, UIScreen.mainScreen().bounds.size.width - 60 - 70 , 44))
        nameLbl!.textColor      =   UIColor.blackColor()
        nameLbl!.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        nameLbl!.textAlignment  =   .Left
        kView1!.addSubview(nameLbl!)
        
//        let descLbl2            =   UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width - 65 ,1, 55 , 16))
//        descLbl2.text           =   "CALL TIME"
//        descLbl2.textColor      =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
//        descLbl2.font           =   UIFont(name: Gillsans.Default.description, size: 11.0)
//        descLbl2.textAlignment  =   .Right
//        kView1!.addSubview(descLbl2)
        
        callSheetDate               =   UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width - 65 ,8, 55 , 14))
        callSheetDate!.textColor    =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        callSheetDate!.font         =   UIFont(name: Gillsans.Default.description, size: 11.0)
        callSheetDate!.textAlignment  =   .Right
        kView1!.addSubview(callSheetDate!)
        
        callSheetTime               =   UILabel(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width - 85 ,22, 75 , 14))
        callSheetTime!.textColor    =   UIColor.blackColor() //UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        callSheetTime!.font         =   UIFont(name: Gillsans.Default.description, size: 11.0)
        callSheetTime!.textAlignment  =   .Right
        kView1!.addSubview(callSheetTime!)
        
        let leftSwipe       =   UISwipeGestureRecognizer(target: self, action: #selector(CallsheetCell.leftSwipeGest))
        leftSwipe.direction =   .Left
        let rightSwipe      =   UISwipeGestureRecognizer(target: self, action: #selector(CallsheetCell.rightSwipeGest))
        rightSwipe.direction =   .Right
        self.contentView.addGestureRecognizer(leftSwipe)
        self.contentView.addGestureRecognizer(rightSwipe)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func leftSwipeGest () {
        if (self.isOpen == false)
        {
            delegate.cellOpened()
            self.isOpen     =   true
            UIView.animateWithDuration(0.20, animations: { () -> Void in
                self.kView1?.center.x       =    (self.kView1?.center.x)! - 120
                self.kView1?.backgroundColor =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            })
        }
    }
    func rightSwipeGest () {
        
        if (self.isOpen == true)
        {
            self.isOpen     =   false
            UIView.animateWithDuration(0.20, animations: { () -> Void in
                self.kView1?.center.x       =    (self.kView1?.center.x)! + 120
                self.kView1?.backgroundColor =   UIColor.whiteColor()
            })
        }
        
    }
}
class CallsheetView: UIView, UITableViewDelegate, UITableViewDataSource, CallsheetCellDelegate, MFMailComposeViewControllerDelegate {
    var tbleView: UITableView?
    var keysArray: NSArray =   NSArray()
    var castDet: NSDictionary =   NSDictionary()
    var detailsDict: NSDictionary?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var prodBook : CallSheet?
    var viewController : ProductionbookViewVC?
    
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
        tbleView?.registerClass(CallsheetCell.self, forCellReuseIdentifier: "CallsheetCell")
        self.addSubview(tbleView!)
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No callsheet found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        let kPBID: String   =  prodBook!._PB_Id as String
        let dict1: NSMutableDictionary   =  NSMutableDictionary(objects: [getUserID(), kPBID] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionbookId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Callsheet_GetConfirmedCrewArtist, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                    
                    if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                    {
                        isSuccess   =   true
                        
                        let kArr1       =   NSMutableArray()
                        let kdict2      =   NSMutableDictionary()
                        let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_UserName as String, ascending: true)
                        let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                        
                        let kDetailDict: NSMutableDictionary    =   NSMutableDictionary()
                        
                        for  kDictionary in sortedArray {
                            let callObj: callSheetObj    =   callSheetObj().setDetails(kDictionary as! NSDictionary)
                            
                            let key     =   callObj._PB_CastDesc
                            let castId  =   callObj._PB_CastId
                            let castCode    =  "\(callObj._PB_CastCd)"
                            if (kArr1.containsObject(key))
                            {
                                kDetailDict.objectForKey(key)?.addObject(callObj)
                            }
                            else
                            {
                                kArr1.addObject(key)
                                kdict2.setObject(["id":castId,"cd":castCode], forKey: key)
                              
                                kDetailDict.setObject(NSMutableArray(object: callObj), forKey: key)
                            }
                        }
                        
                        self.keysArray      =   NSArray(array: kArr1.sortedArrayUsingSelector(#selector(NSNumber.compare(_:))))
                        self.castDet        =   NSDictionary(dictionary: kdict2)
                        self.detailsDict    =   NSDictionary(dictionary: kDetailDict)
                    }
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.keysArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ((self.detailsDict?.objectForKey(self.keysArray.objectAtIndex(section)) as? NSArray)?.count)!
    }

    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
        let ktitle : NSString =   self.keysArray.objectAtIndex(section) as! String
     
        
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        
        let descLbl         =   UILabel(frame: CGRectMake(60,0, self.frame.size.width - 60 - 10 , 50))
        descLbl.textColor   =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 13.0)
        descLbl.textAlignment  =   .Left
        descLbl.text        =   ktitle.uppercaseString
        customView.addSubview(descLbl)
        
        
        let CiLbl : UILabel     =   UILabel(frame: CGRectMake(15, 10,  30, 30))
        CiLbl.text              =   ktitle.substringToIndex(2).uppercaseString
        CiLbl.textAlignment     =   NSTextAlignment.Center
        CiLbl.font              =   UIFont(name: Gillsans.Default.description, size: 14.0)
        CiLbl.textColor         =   UIColor.blackColor()
        CiLbl.layer.borderColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        CiLbl.layer.borderWidth =   1.0
        CiLbl.layer.cornerRadius    =   15
        customView.addSubview(CiLbl)
        
        let dict    =   self.castDet.objectForKey(ktitle)
        let kButton     =   CallsheetCrewButton(type: .Custom)
        kButton.castID  =   (dict as! Dictionary)["id"]
        kButton.castCode    =   (dict as! Dictionary)["cd"]
        kButton.setImage(UIImage(named: "add-yel.png"), forState: .Normal)
        kButton.addTarget(self, action: #selector(CallsheetView.addCrewTapped(_:)), forControlEvents: .TouchUpInside)
        kButton.frame   =   CGRectMake(self.frame.size.width - 40,15, 30 , 30)
//        customView.addSubview(kButton)
        
        return customView
    }
    
    func addCrewTapped(sender : CallsheetCrewButton) {
        let optionsView     =   CallaheetAddArtistVC()
        optionsView.viewController  =   viewController
        optionsView.prevSelected    =   NSArray(object: "")
        optionsView.pbFromDate     =   prodBook!._PB_FromDt as String
        optionsView.pbToDate     =   prodBook!._PB_ToDt as String
        optionsView.pbName     =   prodBook!._ProjectName as String
        optionsView.productionBookId    =   prodBook!._PB_Id as String
        optionsView.castingId   =   sender.castID!
        optionsView.castingCode =   sender.castCode!
        viewController!.navigationController?.pushViewController(optionsView, animated: true)
    }
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return  44.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CallsheetCell  =   (tableView.dequeueReusableCellWithIdentifier("CallsheetCell") as? CallsheetCell)!
        cell.selectionStyle     =   .None
        cell.delegate           =   self
        var callDetail : callSheetObj?
        
        let key =   self.keysArray.objectAtIndex(indexPath.section)
        let kArr  =   self.detailsDict?.objectForKey(key) as? NSArray
        callDetail  =   kArr?.objectAtIndex(indexPath.row) as? callSheetObj
        
        
        cell.nameLbl!.text          =   callDetail!._UserName.uppercaseString
        if (callDetail!._ScheduleDate.isEqualToString("") == false)
        {
            cell.callSheetDate!.text    =   (dateForDisplay(callDetail!._ScheduleDate, returnFormat: "dd MMM yy") as String).uppercaseString
            cell.callSheetTime!.text    =   callDetail!._CallTime.uppercaseString
        }
        cell.mailBtn?.addTarget(self, action: #selector(CallsheetView.mailOrCallBtnTapped(_:)), forControlEvents: .TouchUpInside)
        cell.mailBtn?.callObj       =   callDetail
        cell.callBtn?.addTarget(self, action: #selector(CallsheetView.mailOrCallBtnTapped(_:)), forControlEvents: .TouchUpInside)
        cell.callBtn?.callObj       =   callDetail
        
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
    
    func cellOpened () {
        
        let cells =   tbleView?.visibleCells
        
        for cell in cells! {
            (cell as? CallsheetCell)?.rightSwipeGest()
        }
    }
    
    func mailOrCallBtnTapped (sender:CallsheetButton) {
        if (sender.tag == 0)
        {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
            mailComposerVC.setToRecipients([(sender.callObj?._UserEmail)! as String])

            if MFMailComposeViewController.canSendMail() {
                GetAppDelegate().window?.rootViewController!.presentViewController(mailComposerVC, animated: true, completion: nil)
            } else {
              //  ShowAlert("Your device could not send e-mail.  Please check e-mail configuration and try again.")
            }
        }
        else
        {
            let url:NSURL = NSURL(string: "tel://\((sender.callObj?._UserPhone)!)")!
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}


class TravelView: UIView, UITableViewDelegate, UITableViewDataSource {
    var tbleView: UITableView?
    var keysArray: NSArray =   NSArray()
    var detailsDict: NSDictionary?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var prodBook : CallSheet?
    var viewController : UIViewController?
    var icalBtn : UIButton?
    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
    }
    func iCalTapped (sender : UIButton) {
        
        let alertController = UIAlertController(title: kLS_App_Name, message: "Do you want to add events to calendar?", preferredStyle: .Alert)
        let calcelAction = UIAlertAction(title: "CANCEL", style: .Default, handler: { (action) -> Void in
            
        })
        alertController.addAction(calcelAction)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let eventStore = EKEventStore()
            let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
            
            switch (status)
            {
            case EKAuthorizationStatus.NotDetermined:
                // This happens on first-run
                eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
                    (accessGranted: Bool, error: NSError?) in
                    if accessGranted == true {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.addAllEvents(eventStore)
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), {
                            ShowAlert("Calendar access denied.")
                        })
                    }
                })
            case EKAuthorizationStatus.Authorized:
                // Things are in line with being able to show the calendars in the table view
                dispatch_async(dispatch_get_main_queue(), {
                    self.addAllEvents(eventStore)
                })
                
            case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied:
                // We need to help them give us permission
                dispatch_async(dispatch_get_main_queue(), {
                    ShowAlert("Calendar access denied.")
                })
            }
        })
        alertController.addAction(okAction)
        self.viewController!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func addAllEvents (kEventStore: EKEventStore) {
        var isSuccess = false
        for kKey in self.keysArray {
            for travEvent in (self.detailsDict?.objectForKey(kKey) as? NSArray)! {
               
                let travelObj   =   travEvent.objectForKey("obj") as? TravelObj
                if(travEvent.objectForKey("type")?.isEqualToString("From") == true)
                {
                    let kDate   =   travelObj?._fromDate
                    let kTime   =   travelObj?._fromTime.uppercaseString
                    let kfinDate   =   getScheduleDateFromString("\(kDate!) \(kTime!)".uppercaseString)
                    if (NSDate().isLessThanDate(kfinDate))
                    {
                        isSuccess   =   true
                        let event:EKEvent = EKEvent(eventStore: kEventStore)
                        let alarm       =   EKAlarm()
                        let kDate       =   kfinDate
                        let kHalfDate   =   kfinDate.addHours(-0.5)
                        event.title     =   prodBook!._ProjectName.uppercaseString + "- Travel"
                        if (event.title == "")
                        {
                            event.title =   "LENSPiRE EVENT"
                        }
                        
                        if (travelObj?._categoryId.uppercaseString == "FLIG")
                        {
                            
                            event.notes    =   "Departs " + ((travelObj?.kFromFlight)! as String) + "\n\n" + "\((travelObj?._notes)!)".capitalizedString
                        }
                        else if (travelObj?._categoryId.uppercaseString == "CAR")
                        {
                            
                            event.notes    =   "pick up  \((travelObj?.kFromCar)!)" + "\n\n" + "\((travelObj?._notes)!)".capitalizedString
                        }
                        else
                        {
                            event.notes    =    (travelObj?.kDesc1.capitalizedString)! + "\n\n" + "\((travelObj?._notes)!)".capitalizedString
                        }
                        
                        event.startDate =   kHalfDate
                        event.endDate   =   kDate
                        
                        if (kHalfDate.isGreaterThanDate(NSDate()))
                        {
                            event.alarms    =   [alarm]
                        }
                        event.calendar  =   kEventStore.defaultCalendarForNewEvents
                        do {
                            try kEventStore.saveEvent(event, span: EKSpan.ThisEvent)
                            
                        }
                        catch {
                        }
                        
                    }
                }
            }
        }
        
        if (isSuccess)
        {
            ShowAlert("Events has been added to calendar.")
        }
        else
        {
            ShowAlert("No upcoming events are available.")
        }
    }

    func loadDetails () {
        
        tbleView    =   UITableView(frame: CGRectMake(0, 0, self.frame.size.width,self.frame.size.height), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        self.addSubview(tbleView!)
        
        icalBtn         =   UIButton(type: .Custom)
        icalBtn!.setImage(UIImage(named: "ical.png"), forState: .Normal)
        icalBtn!.frame       =   CGRectMake(self.frame.size.width - 44, 0, 40, 50)
        icalBtn!.addTarget(self, action: #selector(ScheduleView.iCalTapped(_:)), forControlEvents: .TouchUpInside)
        self.addSubview(icalBtn!)
        icalBtn!.hidden =   true
        
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No travel detail found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        noLbl.hidden    =   true
        
        if (self.kArtistID == "")
        {
            self.kArtistID  =   getUserID() as String
        }
        
        let kPBID: String   =  prodBook!._PB_Id as String
        let dict1: NSMutableDictionary   =
        NSMutableDictionary(objects: [getUserID(), kPBID , self.kArtistID, "1"] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionBookId,kLS_CP_ArtistId,kLS_CP_ShareType])
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Callsheet_GetUserItineraryDetails, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                var isSuccess : Bool =    false
                if  (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if ( kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        let kArr: AnyObject?   =   result.objectForKey(kLS_CP_result)
                        
                        
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                        {
                            isSuccess   =   true
                            
                            let kArr: AnyObject?   =   result .objectForKey(kLS_CP_result)
                            if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true)
                            {
                                
                                let kKeysArr: NSMutableArray            =   NSMutableArray()
                                let kDetailDict: NSMutableDictionary    =   NSMutableDictionary()
                                
                                for  kDictionary in (kArr as? NSArray)!{
                                    let travelObj: TravelObj    =   TravelObj().setDetails(kDictionary as! NSDictionary)
                                    
                                    let key =   dateForDisplay(travelObj._fromDate, returnFormat: "eee MM/dd")
                                    let kdate   =   getScheduleDateFromString(travelObj._fromDate.uppercaseString + " " + travelObj._fromTime.uppercaseString)
                                    if (kKeysArr.containsObject(key))
                                    {
                                        
                                        kDetailDict.objectForKey(key)?.addObject(["type" : "From","sortKey":kdate,"obj":travelObj])
                                        
                                        let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: "sortKey", ascending: true)
                                        let sortedArray: NSArray = NSArray(array: kDetailDict.objectForKey(key) as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                                        kDetailDict.setObject(NSMutableArray(array: sortedArray), forKey: key)

                                    }
                                    else
                                    {
                                        kKeysArr.addObject(key)
                                        kDetailDict.setObject(NSMutableArray(object: ["type" : "From","sortKey":kdate,"obj":travelObj]), forKey: key)
                                    }
                                }
                                
                                for  kDictionary in (kArr as? NSArray)!{
                                    let travelObj: TravelObj    =   TravelObj().setDetails(kDictionary as! NSDictionary)
                                    
                                    if (travelObj._categoryId.isEqualToString("HTEL") == true) {
                                        let key =   dateForDisplay(travelObj._toDate, returnFormat: "eee MM/dd")
                                        let kdate   =   getScheduleDateFromString(travelObj._toDate.uppercaseString + " " + travelObj._fromTime.uppercaseString)
                                        if (kKeysArr.containsObject(key))
                                        {
                                            
                                            kDetailDict.objectForKey(key)?.addObject(["type" : "To","sortKey":kdate,"obj":travelObj])
                                            
                                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: "sortKey", ascending: true)
                                            let sortedArray: NSArray = NSArray(array: kDetailDict.objectForKey(key) as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                                            kDetailDict.setObject(NSMutableArray(array: sortedArray), forKey: key)
                                            
                                        }
                                        else
                                        {
                                            kKeysArr.addObject(key)
                                            kDetailDict.setObject(NSMutableArray(object: ["type" : "To","sortKey":kdate,"obj":travelObj]), forKey: key)
                                        }
                                    }
                                }

                         
                                self.keysArray      =   NSArray(array: kKeysArr)
                                self.detailsDict    =   NSDictionary(dictionary: kDetailDict)
                                self.loadedIndexes  =   NSMutableArray()
                            }
                        }
                    }
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
  
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        icalBtn!.hidden     =   false
        let frame: CGRect = CGRectMake(0, 0, self.frame.size.width, 50)
        
        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        if (section == 0) {
            let descLbl         =   UILabel(frame: CGRectMake(20,0, self.frame.size.width - 40 - 10 , 50))
            descLbl.textColor   =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
            descLbl.textAlignment  =   .Left
            customView.addSubview(descLbl)
        
                if (self.kArtistName.trim() == "")
                {
                    descLbl.text       =   "YOUR TRAVEL ITINERARY"
                }
                else
                {
                    descLbl.text       =   self.kArtistName.uppercaseString + "'S" + " TRAVEL ITINERARY"
                }
        }
        else {
        
        let descLbl         =   UILabel(frame: CGRectMake(40,0, self.frame.size.width - 50 , 50))
        descLbl.text        =   (self.keysArray.objectAtIndex(section - 1) as? String)?.uppercaseString
        descLbl.textColor   =   UIColor.blackColor()
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        customView.addSubview(descLbl)
            
        }
        if (section != 0) {
            let imageView   =   UIImageView(frame: CGRectMake(14, 19, 12, 12))
            imageView.backgroundColor   =   UIColor.yellowColor()
            imageView.layer.cornerRadius    =   6.0
            imageView.layer.borderWidth     =   2.0
            imageView.layer.borderColor     =   UIColor.blackColor().CGColor
            customView.addSubview(imageView)
            
            if (section != 1)
            {
                let imageView1   =   UIImageView(frame: CGRectMake(19.5, 0, 1, 18))
                imageView1.backgroundColor  =   UIColor.blackColor()
                customView.addSubview(imageView1)
            }
            
            let imageView2   =   UIImageView(frame: CGRectMake(19.5, 32, 1, 18))
            imageView2.backgroundColor  =   UIColor.blackColor()
            customView.addSubview(imageView2)
        }
        return customView
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return  0
        }
        let kDict       =   self.detailsDict?.objectForKey(self.keysArray.objectAtIndex(indexPath.section - 1))?.objectAtIndex(indexPath.row)
        let travelObj   =   kDict?.objectForKey("obj") as? TravelObj
        
        var kHeight1 =   travelObj?.kDesc1Height > 30.0 ? (travelObj?.kDesc1Height)! + 6.0 : 30.0
        var kHeight2 =   travelObj?.kDesc2Height > 30.0 ? (travelObj?.kDesc2Height)! + 6.0 : 30.0
        var kHeight3 : CGFloat =   travelObj?.kDesc3Height > 0.0 ? 30.0 : 0.0
      
        
        if (travelObj?._categoryId.isEqualToString("HTEL") == true) {
            let type   =   kDict?.objectForKey("type") as? String
            if (type == "From") {
                kHeight2    =   0
                if (kHeight3 == 0.0) {
                    kHeight1 =   travelObj?.kDesc1Height > 50.0 ? (travelObj?.kDesc1Height)! + 6.0 : 50.0
                }
            }
            else  {
                kHeight1    =   0
                kHeight3    =   0
                kHeight2    =   travelObj?.kDesc2Height > 50.0 ? (travelObj?.kDesc2Height)! + 6.0 : 50.0
            }
        }
        return  kHeight1 + kHeight2 + kHeight3 + 6
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (self.keysArray.count == 0) {
            return 0
        }
        return self.keysArray.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        if (section == 0) {
            return 0
        }
        return (self.detailsDict?.objectForKey(self.keysArray.objectAtIndex(section - 1))?.count)!
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ScheduleCell   =   (tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell)!
        cell.selectionStyle     =   .None
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        if (indexPath.section == 0) {
            return cell
        }
        
        let kDict       =   self.detailsDict?.objectForKey(self.keysArray.objectAtIndex(indexPath.section - 1))?.objectAtIndex(indexPath.row)
        let travelObj   =   kDict?.objectForKey("obj") as? TravelObj
        var kHeight1 =   travelObj?.kDesc1Height > 30.0 ? (travelObj?.kDesc1Height)! + 6.0 : 30.0
        var kHeight2 =   travelObj?.kDesc2Height > 30.0 ? (travelObj?.kDesc2Height)! + 6.0 : 30.0
        var kHeight3 : CGFloat =   travelObj?.kDesc3Height > 0.0 ? 30.0 : 0.0
        if (travelObj?._categoryId.isEqualToString("HTEL") == true) {
            let type   =   kDict?.objectForKey("type") as? String
            if (type == "From") {
                kHeight2    =   0
                if (kHeight3 == 0.0) {
                    kHeight1 =   travelObj?.kDesc1Height > 50.0 ? (travelObj?.kDesc1Height)! + 6.0 : 50.0
                }
            }
            else  {
                kHeight1    =   0
                kHeight3    =   0
                kHeight2    =   travelObj?.kDesc2Height > 50.0 ? (travelObj?.kDesc2Height)! + 6.0 : 50.0
            }
        }
        let imageView1   =   UIImageView(frame: CGRectMake(35, 0, self.frame.size.width - 45, kHeight1 + kHeight2 + kHeight3 + 6))
        imageView1.backgroundColor  =   UIColor(red: 0.956, green: 0.956, blue: 0.956, alpha: 1)
        cell.addSubview(imageView1)
        
        let imageView2   =   UIImageView(frame: CGRectMake(19.5, 0, 1, kHeight1 + kHeight2 + kHeight3 + 6))
        imageView2.backgroundColor  =   UIColor.blackColor()
        cell.addSubview(imageView2)
        
        let imageView   =   UIImageView(frame: CGRectMake(43, 10, 20, 20))
      
        cell.addSubview(imageView)
        
        let descLbl         =   UILabel(frame: CGRectMake(70,3, self.frame.size.width - 55 - 70 , kHeight1))
        descLbl.textColor   =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        
        let descLbl2        =   UILabel(frame: CGRectMake(70,kHeight1 + 3, self.frame.size.width - 55 - 70 , kHeight2))
        descLbl2.textColor  =   UIColor.blackColor()//UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1)//UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl2.font       =   UIFont(name: Gillsans.Default.description, size: 14.0)
        descLbl2.textAlignment  =   .Left
        descLbl2.numberOfLines  =   0
        cell.addSubview(descLbl2)
        
        let descLbl3        =   UILabel(frame: CGRectMake(70,kHeight1 + kHeight2 + 3, self.frame.size.width - 55 - 70  , kHeight3))
        descLbl3.textColor  =   UIColor.blackColor()
        descLbl3.font       =   UIFont(name: Gillsans.Default.description, size: 14.0)
        descLbl3.textAlignment  =   .Left
        descLbl3.text       =   "Attachment"
        cell.addSubview(descLbl3)
        
        if (travelObj?._categoryId.uppercaseString == "FLIG")
        {
            imageView.image =   UIImage(named: "flight.png")
            
            descLbl.text    =   (travelObj?.kDesc1)! as String
            descLbl2.text   =   (travelObj?.kDesc2)! as String
            
            if ((travelObj?.kFromLoc)!.uppercaseString != "")
            {
                let scheBtn         =   TravelButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, 3, 30, kHeight1)
                scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
                scheBtn.kLatLang    =   (travelObj?.kFromLoc)!
                scheBtn.ktitle      =   "Departs from " + "\((travelObj?.kFromFlight)!)"
                scheBtn.kSubTitle   =   "At " + ((travelObj?._fromTime.uppercaseString)!)
            }
            
            if ((travelObj?.kToLoc)!.uppercaseString != "")
            {
                let scheBtn         =   TravelButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, kHeight1 + 3, 30, kHeight2)
                scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
                scheBtn.kLatLang    =   (travelObj?.kToLoc)!
                scheBtn.ktitle      =   "Arrives at " + "\((travelObj?.kToFlight)!)"
                scheBtn.kSubTitle   =   "At " + ((travelObj?._toTime.uppercaseString)!)
            }
        }
        else if (travelObj?._categoryId.uppercaseString == "CAR")
        {
            imageView.image =   UIImage(named: "car.png")
            
            descLbl.text    =   (travelObj?.kDesc1)! as String
            descLbl2.text   =   (travelObj?.kDesc2)! as String
            
         
            if ((travelObj?.kFromLoc)!.uppercaseString != "")
            {
                let scheBtn         =   TravelButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, 3, 30, kHeight1)
                scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
                scheBtn.kLatLang    =   (travelObj?.kFromLoc)!
                scheBtn.ktitle      =   "Car Pick Up"
                scheBtn.kSubTitle   =   "\((travelObj?.kFromCar)!) At \((travelObj?._fromTime.uppercaseString)!)"
            }
            
            if ((travelObj?.kToLoc)!.uppercaseString != "")
            {
                let scheBtn         =   TravelButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, kHeight1 + 3, 30, kHeight2)
                scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
                scheBtn.kLatLang    =   (travelObj?.kToLoc)!
                scheBtn.ktitle      =   "Car Drop Off"
                scheBtn.kSubTitle   =   (travelObj?.kToCar)! as String
            }
        }
        else
        {
            imageView.image =   UIImage(named: "hotel.png")
            if(kDict?.objectForKey("type")?.isEqualToString("From") == true)
            {
                descLbl.text    =    (travelObj?.kDesc1)! as String
                descLbl3.text   =  "Attachment"
        
                if ((travelObj?.kFromLoc)!.uppercaseString != "")
                {
                    let scheBtn         =   TravelButton(type: .Custom)
                    scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                    scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, 3, 30, kHeight1)
                    scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                    cell.addSubview(scheBtn)
                    scheBtn.kLatLang    =   (travelObj?.kFromLoc)!
                    scheBtn.ktitle      =   "Check in"
                    scheBtn.kSubTitle   =   (travelObj?.kDesc1)! as String
                }
            }
            else
            {
                descLbl2.text    =   (travelObj?.kDesc2)! as String
                
                if ((travelObj?.kFromLoc)!.uppercaseString != "")
                {
                    let scheBtn         =   TravelButton(type: .Custom)
                    scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                    scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, 3, 30, kHeight2)
                    scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                    cell.addSubview(scheBtn)
                    scheBtn.kLatLang    =   (travelObj?.kFromLoc)!
                    scheBtn.ktitle      =   "Check Out"
                    scheBtn.kSubTitle   =   (travelObj?.kDesc2)! as String
                }
            }
            
        }
        let type   =   kDict?.objectForKey("type") as? String
        if (type == "From") {
    
            if ((travelObj?._attachmentUrl)!.uppercaseString != "")
            {
                let scheBtn         =   AttachmentButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "attachment.png"), forState: .Normal)
                scheBtn.attachmentUrl   =   travelObj?._attachmentUrl as? String
                scheBtn.kTitle      =   "Attachment".uppercaseString
                scheBtn.frame       =   CGRectMake(self.frame.size.width - 45, kHeight1 + kHeight2 + 3, 30, kHeight3)
                scheBtn.addTarget(self, action: #selector(TravelView.viewAttachmentTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
            }
        }
        let sepImg      =   UIImageView(frame: CGRectMake(80, kHeight1 + kHeight2 + kHeight3 + 5, self.frame.size.width - 95, 1))
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
    
    func viewAttachmentTapped (sender: AttachmentButton) {
        let attachmntVC =   AttachmentView()
        attachmntVC.kURLString  =   sender.attachmentUrl!
        attachmntVC.kTitle   =   sender.kTitle!
        self.viewController!.presentViewController(UINavigationController(rootViewController: attachmntVC), animated: false) { () -> Void in
            
        }
        addTransitionEffect()
    }
    
    func locateTapped (sender: TravelButton) {
        let mapDisp         =   MapDisplayView()
        mapDisp.kTitle      =   sender.ktitle
        mapDisp.kSubtitle   =   sender.kSubTitle
        if (sender.kLatLang.isEqualToString("") == false)
        {
            mapDisp.kLat        =   sender.kLatLang.componentsSeparatedByString(",")[0]
            mapDisp.kLang       =   sender.kLatLang.componentsSeparatedByString(",")[1]
        }
        
        self.viewController?.navigationController?.pushViewController(mapDisp, animated: true)
    }
    
}

class PBDetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tbleView: UITableView?
    var detailsDict: NSDictionary?
    var loadedIndexes : NSMutableArray  =   NSMutableArray()
    var prodBook : CallSheet?
    var tempDetails : NSArray       =   NSArray(object: "")
    var details : NSArray           =   NSArray(object: "")
    var shootTempDetails : NSArray       =   NSArray(object: "")
    var shootDetails : NSArray           =   NSArray(object: "")
    var locationDetails : NSArray   =   NSArray()
    var attachmentDetails : NSArray =   NSArray()
    var tempLocationDetails : NSArray   =   NSArray()
    var tempAttachmentDetails : NSArray =   NSArray()
    var noOfSections    =   0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(ProductionbookViewVC.backBtnTapped), forControlEvents: .TouchUpInside)
        let aBarButtonItem1  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem1, animated: true)
        
        self.title      =   "DETAILS"
        loadDetails()
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func loadDetails () {
        
        tbleView    =   UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height - 64), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        self.view.addSubview(tbleView!)
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No detail found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        
        let kPBID: String   =  prodBook!._PB_Id as String
        let dict1: NSMutableDictionary   =
        NSMutableDictionary(objects: [getUserID(), kPBID ] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionBookId])
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Callsheet_GetScheduleLocationsHotels, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    self.noOfSections               =       4
                    let attachments: AnyObject?     =   result.objectForKey(kLS_CP_Attachments)
//                    let hotels: AnyObject?          =   result.objectForKey(kLS_CP_Hotels)
                    let locations: AnyObject?       =   result.objectForKey(kLS_CP_Locations)
                    
                    
                    if (attachments?.isKindOfClass(NSNull) == false && attachments?.isKindOfClass(NSDictionary) == true )
                    {
                        let kArr: AnyObject?   =   attachments!.objectForKey(kLS_CP_result)
                        
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                        {
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_actualFileName as String, ascending: true)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                            let kMutArr     =   NSMutableArray()
                            for kDic in sortedArray
                            {
                                let attObj: AttachmentObj =  AttachmentObj().setDetails(kDic as! NSDictionary)
                                kMutArr.addObject(attObj)
                            }
                            
                            self.attachmentDetails      =   NSArray(array: kMutArr)
                            self.tempAttachmentDetails  =   NSArray(array: kMutArr)
                        }
                    }
                    
//                    if (hotels?.isKindOfClass(NSNull) == false && hotels?.isKindOfClass(NSDictionary) == true )
//                    {
//                        let kArr: AnyObject?   =   hotels!.objectForKey(kLS_CP_result)
//                        
//                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
//                        {
//                            
//                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_hotel as String, ascending: true)
//                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
//                            let kMutArr     =   NSMutableArray()
//                            for kDic in sortedArray
//                            {
//                                let locObj: TravelObj =  TravelObj().setDetails(kDic as! NSDictionary)
//                                kMutArr.addObject(locObj)
//                            }
//                            
//                            self.locationDetails        =   NSArray(array: kMutArr)
//                            self.tempLocationDetails    =   NSArray(array: kMutArr)
//                        }
//                    }
                    
                    if (locations?.isKindOfClass(NSNull) == false && locations?.isKindOfClass(NSDictionary) == true )
                    {
                        let kArr: AnyObject?   =   locations!.objectForKey(kLS_CP_result)
                        
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true )
                        {
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_location as String, ascending: true)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                            let kMutArr     =   NSMutableArray()
                            for kDic in sortedArray
                            {
                                let locObj: LocationObj =  LocationObj().setDetails(kDic as! NSDictionary)
                                kMutArr.addObject(locObj)
                            }
                            
                            kMutArr.addObjectsFromArray(self.locationDetails as [AnyObject])
                            self.locationDetails        =   NSArray(array: kMutArr)
                            self.tempLocationDetails    =   NSArray(array: kMutArr)
                        }
                    }
                    
                }
                else
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
   
        return 50.0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame: CGRect = CGRectMake(0, 0, self.view.frame.size.width, 50)

        let customView:UIView   = UIView(frame: frame)
        customView.backgroundColor  =   UIColor.whiteColor()
        
        let descLbl         =   UILabel(frame: CGRectMake(65,0, self.view.frame.size.width - 65 - 10 , 50))
        descLbl.textColor   =   UIColor.blackColor()
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        customView.addSubview(descLbl)
        
        
        let imageView       =   UIImageView(frame: CGRectMake(20, 10, 30, 30))
        customView.addSubview(imageView)
        customView.tag      =   section
        
        let kButton         =   UIButton(type: .Custom)
        kButton.setImage(UIImage(named: "up.png"), forState: .Normal)
        kButton.setImage(UIImage(named: "down.png"), forState: .Selected)
        kButton.frame       =   CGRectMake(self.view.frame.size.width - 60, 0, 60, 50)
        kButton.selected    =   true
        customView.addSubview(kButton)
        kButton.userInteractionEnabled  =   false
        kButton.tag         =   99
        
        if (section == 0)
        {
            descLbl.text    =   self.prodBook?._ProjectName.uppercaseString
            imageView.image =   UIImage(named: "calendar.png")
            if (details.count == 0)
            {
                kButton.selected    =   false
            }
        }
        else if (section == 1)
        {
            descLbl.text    =   "LOCATION/CALL TIME"
            imageView.image =   UIImage(named: "location.png")
            if (tempLocationDetails.count == 0)
            {
                kButton.selected    =   false
            }
        }
        else if (section == 2)
        {
            descLbl.text    =   "ATTACHMENTS"
            imageView.image =   UIImage(named: "attachments.png")
            if (tempAttachmentDetails.count == 0)
            {
                kButton.selected    =   false
            }
        }
        else if (section == 3)
        {
            descLbl.text    =   "SHOOT NOTES"
            imageView.image =   UIImage(named: "screen.png")
        }
        
        customView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PBDetailsView.tapGestAction(_:))))
        
        return customView
    }
    
    func tapGestAction (sender : UIGestureRecognizer) {
        let kButton =   sender.view?.viewWithTag(99) as? UIButton
        self.tbleView!.beginUpdates()
        if(kButton?.selected == true)
        {
            kButton?.selected   =   false
            
            if (sender.view?.tag == 0)
            {
                tempDetails =   NSArray()
                if (self.tbleView?.numberOfRowsInSection(0) == 1)
                {
                    self.tbleView?.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
                }
            }
            else if (sender.view?.tag == 1)
            {
                let kArr    =   NSMutableArray()
                tempLocationDetails =   NSArray()
                if ( self.tbleView?.numberOfRowsInSection(1) > 0)
                {
                    for var i = 0 ; i < self.tbleView?.numberOfRowsInSection(1) ; i += 1 {
                        kArr.addObject(NSIndexPath(forRow: i, inSection: 1))
                    }
                    self.tbleView?.deleteRowsAtIndexPaths((kArr as? [NSIndexPath])!, withRowAnimation: .Automatic)
                }
                
            }
            else if (sender.view?.tag == 2)
            {
                let kArr    =   NSMutableArray()
                tempAttachmentDetails =   NSArray()
                if ( self.tbleView?.numberOfRowsInSection(2) > 0)
                {
                    for var i = 0 ; i < self.tbleView?.numberOfRowsInSection(2) ; i += 1 {
                        kArr.addObject(NSIndexPath(forRow: i, inSection: 2))
                    }
                    
                    self.tbleView?.deleteRowsAtIndexPaths((kArr as? [NSIndexPath])!, withRowAnimation: .Automatic)
                }
                
            }
            else if (sender.view?.tag == 3)
            {
                shootTempDetails =   NSArray()
                if (self.tbleView?.numberOfRowsInSection(3) == 1)
                {
                    self.tbleView?.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 3)], withRowAnimation: .Automatic)
                }
            }
            
        }
        else
        {
            kButton?.selected   =   true
            if (sender.view?.tag == 0)
            {
                tempDetails =   NSArray(object: "")
                self.tbleView?.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
            }
            else if (sender.view?.tag == 1)
            {
                let kArr    =   NSMutableArray()
                tempLocationDetails =   NSArray(array: self.locationDetails)
                for i in 0  ..< tempLocationDetails.count  {
                    kArr.addObject(NSIndexPath(forRow: i, inSection: 1))
                }
                self.tbleView?.insertRowsAtIndexPaths((kArr as? [NSIndexPath])!, withRowAnimation: .Automatic)

            }
            else if (sender.view?.tag == 2)
            {
                let kArr    =   NSMutableArray()
                tempAttachmentDetails =   NSArray(array: self.attachmentDetails)
                for i in 0  ..< tempAttachmentDetails.count  {
                    kArr.addObject(NSIndexPath(forRow: i, inSection: 2))
                }
                self.tbleView?.insertRowsAtIndexPaths((kArr as? [NSIndexPath])!, withRowAnimation: .Automatic)
            }
            else if (sender.view?.tag == 3)
            {
                shootTempDetails =   NSArray(object: "")
                self.tbleView?.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 3)], withRowAnimation: .Automatic)
            }
        }
        
        self.tbleView!.endUpdates()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section == 0)
        {
            return 250.0
        }
        else if (indexPath.section == 3)
        {
            let height = heightForView(self.prodBook!._ShootNotes as String, font: UIFont(name: Gillsans.Default.description, size: 14.0)!, width: self.view.frame.size.width - 80 - 45 )
            
            if (height > 50.0)
            {
                return height + 10
            }
        }
        return  50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return  noOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0)
        {
            return self.tempDetails.count
        }
        else if (section == 1)
        {
            return self.tempLocationDetails.count
        }
        else if (section == 2)
        {
            return self.tempAttachmentDetails.count
        }
        else if (section == 3)
        {
            return self.shootTempDetails.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ScheduleCell   =   (tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell)!
        cell.selectionStyle     =   .None
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        if (indexPath.section == 0)
        {
            var kStrtY : CGFloat    =   5.0
            
            for i in 0 ..< 4 {
                
                let descLbl         =   UILabel(frame: CGRectMake(80,kStrtY, self.view.frame.size.width - 80 - 10 , 25))
                descLbl.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
                descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
                descLbl.textAlignment  =   .Left
                cell.addSubview(descLbl)
                let descLbl2        =   UILabel(frame: CGRectMake(80,kStrtY + 25.0, self.view.frame.size.width - 80 - 10 , 25))
                descLbl2.textColor  =   UIColor.blackColor()
                descLbl2.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
                descLbl2.textAlignment  =   .Left
                cell.addSubview(descLbl2)
                
                kStrtY      =   kStrtY + 10.0 + 50.0
                
                if (i == 0)
                {
                    descLbl.text    =   "CLIENT"
                    descLbl2.text   =   self.prodBook?._BrandName.uppercaseString
                }
                if (i == 1)
                {
                    descLbl.text    =   "SHOOT DATES"
                    descLbl2.text   =   "\(dateForDisplay((self.prodBook?._PB_FromDt)!, returnFormat: "MM/dd").uppercaseString) - \(dateForDisplay((self.prodBook?._PB_ToDt)!, returnFormat: "MM/dd").uppercaseString)"
                }
                if (i == 2)
                {
                    descLbl.text    =   "JOB NUMBER"
                    descLbl2.text   =   self.prodBook?._JobNumber.uppercaseString
                }
                if (i == 3)
                {
                    descLbl.text    =   "AGENCY"
                    descLbl2.text   =   self.prodBook?._AgencyName.uppercaseString
                }
            }
        }
        else
        {
            if (indexPath.section == 1)
            {
                let descLbl         =   UILabel(frame: CGRectMake(80,5, self.view.frame.size.width - 80 - 45 , 20))
                descLbl.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
                descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
                descLbl.textAlignment   =   .Left
                cell.addSubview(descLbl)
                
                let descLbl1         =   UILabel(frame: CGRectMake(80,25, self.view.frame.size.width - 80 - 45 , 20))
                descLbl1.textColor   =   UIColor.blackColor()
                descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
                descLbl1.textAlignment   =   .Left
                cell.addSubview(descLbl1)
                
                let locObj : AnyObject =   self.tempLocationDetails.objectAtIndex(indexPath.row)
                if (locObj.isKindOfClass(LocationObj))
                {
                    descLbl.text    =   (dateForDisplay((locObj as? LocationObj)!._scheduleDate, returnFormat: "MM/dd") as String).uppercaseString+" "+(locObj as? LocationObj)!._scheduleTime.uppercaseString
                    descLbl1.text    =   (locObj as? LocationObj)!._location.uppercaseString
                    
                    let scheBtn         =   InfoDetailButton(type: .Custom)
                    scheBtn.setImage(UIImage(named: "locate.png"), forState: .Normal)
                    scheBtn.locObj     =  locObj as? LocationObj
                    scheBtn.frame       =   CGRectMake(self.view.frame.size.width - 40, 0, 30, 50)
                    scheBtn.addTarget(self, action: #selector(ScheduleView.locateTapped(_:)), forControlEvents: .TouchUpInside)
                    cell.addSubview(scheBtn)
                }
               
//                if (locObj.isKindOfClass(TravelObj))
//                {
//                    descLbl.text    =   (locObj as? TravelObj)!._hotel.uppercaseString
//                }
            }
            else if (indexPath.section == 2)
            {
                let descLbl         =   UILabel(frame: CGRectMake(80,0, self.view.frame.size.width - 80 - 45 , 50))
                descLbl.textColor   =   UIColor.blackColor()
                descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
                descLbl.textAlignment   =   .Left
                descLbl.numberOfLines   =   0
                cell.addSubview(descLbl)
                let attObj  =   self.tempAttachmentDetails.objectAtIndex(indexPath.row) as? AttachmentObj
                descLbl.text    =   attObj?._actualFileName.uppercaseString
                
                let scheBtn         =   AttachmentButton(type: .Custom)
                scheBtn.setImage(UIImage(named: "download.png"), forState: .Normal)
                scheBtn.attachmentUrl   =   attObj?._attachmentURL as? String
                scheBtn.kTitle      =   attObj?._actualFileName.uppercaseString
                scheBtn.frame       =   CGRectMake(self.view.frame.size.width - 40, 0, 30, 50)
                scheBtn.addTarget(self, action: #selector(PBDetailsView.downloadTapped(_:)), forControlEvents: .TouchUpInside)
                cell.addSubview(scheBtn)
            }
            else if (indexPath.section == 3)
            {
                let descLbl         =   UILabel(frame: CGRectMake(80,0, self.view.frame.size.width - 80 - 45 , 50))
                descLbl.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
                descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 14.0)
                descLbl.textAlignment   =   .Left
                descLbl.numberOfLines   =   0
                cell.addSubview(descLbl)
                descLbl.text    =   self.prodBook!._ShootNotes as String
                
                if (self.prodBook!._ShootNotes.isEqualToString("")){
                    descLbl.text    = "No shoot note available."
                    descLbl.textAlignment   =   .Center
                }
                
                let height = heightForView(self.prodBook!._ShootNotes as String, font: UIFont(name: Gillsans.Default.description, size: 14.0)!, width: self.view.frame.size.width - 80 - 45 )
                
                if (height > 50.0)
                {
                    descLbl.frame.size.height   =   height + 10
                }
            }
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
        if (indexPath.section == 2)
        {
            let attObj  =   self.tempAttachmentDetails.objectAtIndex(indexPath.row) as? AttachmentObj
            
            let attachmntVC =   AttachmentView()
            attachmntVC.kURLString  =   (attObj?._attachmentURL as? String)!
            attachmntVC.kTitle   =   (attObj?._actualFileName.uppercaseString)!
            self.presentViewController(UINavigationController(rootViewController: attachmntVC), animated: false) { () -> Void in
                
            }
            addTransitionEffect()
        }
    }
    
    func locateTapped (sender: InfoDetailButton) {
        let mapDisp         =   MapDisplayView()
        mapDisp.kTitle      =   (dateForDisplay(sender.locObj!._scheduleDate, returnFormat: "MM/dd") as String).uppercaseString+" "+sender.locObj!._scheduleTime.uppercaseString
        mapDisp.kSubtitle   =   sender.locObj!._location as String
        if (sender.locObj!._latlng.isEqualToString("") == false)
        {
        mapDisp.kLat        =   sender.locObj!._latlng.componentsSeparatedByString(",")[0]
        mapDisp.kLang       =   sender.locObj!._latlng.componentsSeparatedByString(",")[1]
        }
            self.navigationController?.pushViewController(mapDisp, animated: true)
    }
    
    func downloadTapped (sender: AttachmentButton) {
        let attachmntVC =   AttachmentView()
        attachmntVC.kURLString  =   sender.attachmentUrl!
        attachmntVC.kTitle   =   sender.kTitle!
        self.presentViewController(UINavigationController(rootViewController: attachmntVC), animated: false) { () -> Void in
            
        }
        addTransitionEffect()
    }
}

class MapPopoverView: UIView , MKMapViewDelegate {
    
    var kView : UIView?
    var mapView: MKMapView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        let kTransperentImgView =   UIImageView(frame: CGRectMake(0,0,self.frame.size.width,self.frame.size.height))
        kTransperentImgView.backgroundColor =   UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(kTransperentImgView)
        
        kView   =   UIView(frame: CGRectMake(0,0,self.frame.size.width - 20 , self.frame.size.height - 120))
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
        closeBtn.addTarget(self, action: #selector(MapPopoverView.closeBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        kView!.addSubview(closeBtn)
        
        mapView     =   MKMapView(frame: CGRectMake(3, 46, kView!.frame.size.width  - 6, kView!.frame.size.height - 46 - 3))
        kView?.addSubview(mapView!)
        
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
    func closeBtnTapped () {
        
        UIView.animateWithDuration(0.20, animations: { () -> Void in
            self.alpha    =   0
            }) { (iscompleted) -> Void in
                self.removeFromSuperview()
        }
    }
}


class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class AttachmentView : UIViewController,UIWebViewDelegate{
    
    
    var kURLString   : String    =   ""
    var kTitle      :   String  =   ""
    var processView : ImageLoadProcessView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.clearColor()
        
        
        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(AttachmentView.doneBtnTapped))
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        
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
        
        
        let webV:UIWebView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
     webV.scalesPageToFit   =   true
            webV.loadRequest(NSURLRequest(URL: NSURL(string: kURLString)!))
            webV.delegate = self
            self.view.addSubview(webV)
    }
    
    func webViewDidStartLoad(webView : UIWebView) {
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height))
        self.view.addSubview(processView!)
    }
    
    func webViewDidFinishLoad(webView : UIWebView) {
        self.processView?.removeFromSuperview()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Webview fail with error \(error)")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func doneBtnTapped () {
        self.dismissViewControllerAnimated(false) { () -> Void in
            
        }
    }
    
}
