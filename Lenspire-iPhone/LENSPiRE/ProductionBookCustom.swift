//
//  ProductionBookCustom.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 25/02/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class OutstandingConfirmationView: UIView , UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var kView : UIView?
    var objectsArr : NSArray    =   NSArray()
    var kTitle : String     =   ""
    var krole  :  String    =   "AGENT"
    var completionHandler : (() -> ())!
    var tbleView: UITableView?
    var selectedObjects : NSMutableArray    =   NSMutableArray()
    var confirmBtn : UIButton!
    var declineBtn : UIButton!
    var prodBook : CallSheet!
    var kPBID: String       =   ""
    var kPBname : String    =   ""
    var kOwnerId : String   =   ""
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func loadView () {
        
        let kTransperentImgView =   UIImageView(frame: CGRectMake(0,0,self.frame.size.width,self.frame.size.height))
        kTransperentImgView.backgroundColor =   UIColor(red: 1, green: 1, blue: 1, alpha: 0.85)
        self.addSubview(kTransperentImgView)
        
        kView   =   UIView()
        var minCount    =   5
        if (UIScreen.mainScreen().bounds.size.height < 500) {
            minCount    =   4
        }
        if (objectsArr.count < minCount) {
            kView?.frame    =   CGRectMake(0,0,self.frame.size.width - 60 , CGFloat(290 + (40 * objectsArr.count)))
        }
        else {
            kView?.frame    =   CGRectMake(0,0,self.frame.size.width - 60 , CGFloat(290 + (40 * minCount)))
        }
        kView!.backgroundColor   =   UIColor.whiteColor()
        self.addSubview(kView!)
        kView!.layer.cornerRadius    =   5.0
        
        kView!.center    =   kTransperentImgView.center
        
        let kImgHead    =   UIImageView(frame: CGRectMake(0, 6, 34, 34))
        kImgHead.image  =   UIImage(named: "lenspire-logo.png")
        kView?.layer.borderWidth    =   1.0
        kView?.layer.borderColor    =   UIColor.lightGrayColor().CGColor
        kView!.addSubview(kImgHead)
        kImgHead.center.x   =   kView!.frame.size.width / 2.0
        
        
        let closeBtn     = UIButton(type: UIButtonType.Custom)
        closeBtn.frame   =   CGRectMake(kView!.frame.size.width - 40, 5, 30, 30)
        closeBtn.setImage(UIImage(named: "cross.png"), forState: UIControlState.Normal)
        closeBtn.addTarget(self, action: #selector(OutstandingConfirmationView.closeBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        kView!.addSubview(closeBtn)
        
        let klbl    =   UILabel(frame: CGRectMake(0,50,kView!.frame.size.width,30))
        klbl.font   =   UIFont(name: Gillsans.Default.description, size: 18)
        klbl.text   =   "Confirm oustanding dates".uppercaseString
        klbl.textAlignment  =   .Center
        klbl.backgroundColor    =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        klbl.textColor  =   UIColor.blackColor()
        kView!.addSubview(klbl)
        
        
        let klbl1    =   UILabel(frame: CGRectMake(30,90,kView!.frame.size.width - 60,30))
        klbl1.font   =   UIFont(name: Gillsans.Default.description, size: 18)
        klbl1.text   =   prodBook._ProjectName as String
        klbl1.textAlignment  =   .Center
        klbl1.textColor  =   UIColor.blackColor()
        kView!.addSubview(klbl1)
        
        let klbl2    =   UILabel(frame: CGRectMake(30,120,kView!.frame.size.width - 60,30))
        klbl2.font   =   UIFont(name: Gillsans.Italic.description, size: 13)
        klbl2.text   =   krole
        klbl2.textAlignment  =   .Center
        klbl2.textColor  =   UIColor.grayColor()
        kView!.addSubview(klbl2)
        
        
        tbleView    =   UITableView(frame: CGRectMake(30, 160, kView!.frame.size.width - 60,kView!.frame.size.height - 160 - 130), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        kView!.addSubview(tbleView!)
        
        confirmBtn     =   UIButton(type: UIButtonType.Custom)
        confirmBtn.frame   =   CGRectMake(30, kView!.frame.size.height - 110, kView!.frame.size.width - 60, 35.0)
        confirmBtn.setImage(kGetButtonImage("CONFIRM", kWidth: (kView!.frame.size.width - 60) * 2.0, kHeight: 70.0, kFont: UIFont(name: Gillsans.Default.description, size: 32.0)!), forState: .Normal)
        confirmBtn.tag  =   2
        confirmBtn.addTarget(self, action: #selector(OutstandingConfirmationView.confirmDeclineBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        kView!.addSubview(confirmBtn)
        confirmBtn.center.x  =   kView!.frame.size.width / 2.0
        
        declineBtn     =   UIButton(type: UIButtonType.Custom)
        declineBtn.frame   =   CGRectMake(30, kView!.frame.size.height - 55, kView!.frame.size.width - 60, 35.0)
        declineBtn.setImage(kGetButtonImage("DECLINE", kWidth: (kView!.frame.size.width - 60) * 2.0, kHeight: 70.0, kFont: UIFont(name: Gillsans.Default.description, size: 32.0)!), forState: .Normal)
        declineBtn.tag  =   3
        declineBtn.addTarget(self, action: #selector(OutstandingConfirmationView.confirmDeclineBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        kView!.addSubview(declineBtn)
        declineBtn.center.x  =   kView!.frame.size.width / 2.0
        
        confirmBtn.enabled  =   false
        declineBtn.enabled  =   false
        
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
    func cmpltnHandler ( completion : () -> ()) {
        self.completionHandler          =   completion
    }
    
    func confirmDeclineBtnTapped (sender:UIButton) {
        kPBID       =   prodBook!._PB_Id as String
        kPBname     =   self.prodBook!._ProjectName as String
        kOwnerId    =   self.prodBook!._Owner_UserId as String
        
        let kAvaIDs =   NSMutableArray()
        let kDatesArr   =   NSMutableArray()
        for kObj in self.selectedObjects {
            kAvaIDs.addObject("\((kObj as! OutstandingConfirmDate)._PB_Artist_AvailabilityId)")
            kDatesArr.addObject(confirmOutstandingDateForDisplay((kObj as! OutstandingConfirmDate)._PB_Dt))
        }
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        let dict1: NSMutableDictionary   =
        NSMutableDictionary(objects: [getUserID(), kPBID ,  ((GetAppDelegate().loginDetails?._firstName)! as String) + " " + ((GetAppDelegate().loginDetails?._lastName)! as String),(GetAppDelegate().loginDetails?._email)!,kOwnerId,kPBname,"\(sender.tag)",kAvaIDs.componentsJoinedByString(","),kDatesArr.componentsJoinedByString(",")] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionbookId,kLS_CP_UserName,kLS_CP_Email,kLS_CP_OwnerId,kLS_CP_ProjectName,kLS_CP_StatusType,kLS_CP_AvailabilityIdList,kLS_CP_DatesList])
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Callsheet_AcceptdeclineConfirmDates, parm: dict1, completion: { result , desc , code in
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                if  (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if ( kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        
                        if (sender.tag == 2) {
                            MessageAlertView().showMessage("Selected outstanding dates accepted successfully.", kColor: UIColor.blackColor())
                        }
                        else {
                            MessageAlertView().showMessage("Selected outstanding dates declined successfully.", kColor: UIColor.blackColor())
                        }
                    }
                }
            }
            
            self.completionHandler()
            self.closeBtnTapped()
        })

    }
    
    func declineBtnTapped () {
    }
    func closeBtnTapped () {
        
        UIView.animateWithDuration(0.20, animations: { () -> Void in
            self.alpha    =   0
            }) { (iscompleted) -> Void in
                self.removeFromSuperview()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  40.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectsArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ScheduleCell   =   (tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell)!
        cell.selectionStyle     =   .None
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let oustandingObj : OutstandingConfirmDate    =   self.objectsArr.objectAtIndex(indexPath.row) as! OutstandingConfirmDate
        let descLbl         =   UILabel(frame: CGRectMake(60,0, kView!.frame.size.width - 40 - 60 , 40))
        descLbl.text        =   scheduleDetailDateForDisplay(oustandingObj._PB_Dt as String).uppercaseString
        descLbl.textColor   =   UIColor.blackColor()
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 13.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        let chkImg  =   UIImageView(frame: CGRectMake(0, 0, 20, 20))
        cell.addSubview(chkImg)
        chkImg.center.x     =   30
        chkImg.center.y     =   20
        if (self.selectedObjects.containsObject(oustandingObj)) {
            chkImg.image    =   UIImage(named: "yellow-round.png")
        }
        else {
            chkImg.image    =   UIImage(named: "white-round.png")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let oustandingObj : OutstandingConfirmDate    =   self.objectsArr.objectAtIndex(indexPath.row) as! OutstandingConfirmDate
        if (self.selectedObjects.containsObject(oustandingObj)) {
            self.selectedObjects.removeObject(oustandingObj)
        }
        else {
            self.selectedObjects.addObject(oustandingObj)
        }
        
        if (self.selectedObjects.count > 0) {
            confirmBtn.enabled  =   true
            declineBtn.enabled  =   true
        }
        else {
            confirmBtn.enabled  =   false
            declineBtn.enabled  =   false
        }
        tableView.reloadData()
    }
    
        
}
