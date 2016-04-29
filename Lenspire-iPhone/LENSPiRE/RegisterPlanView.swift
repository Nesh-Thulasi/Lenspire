//
//  RegisterPlanView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 24/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class RegisterPlanView: UIViewController , UITextFieldDelegate , FeedObjDelegate
{
    var descLbl : UILabel?
    var email : String  =   ""
    var userId : String =   ""
    var jAuth : String  =   ""
    var customView : CustomPlanView!
    var customView1 : CustomPlanView!
    var customView2 : CustomPlanView!
    var password : String   =   ""
    func feedImageDownloadReqFinished () {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        self.navigationController?.navigationBarHidden  =   true
        self.automaticallyAdjustsScrollViewInsets   =   false
        
        let kBGView    =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        kBGView.image  =   UIImage(named: "bg.png")
        kBGView.contentMode    =   .ScaleAspectFill
        kBGView.layer.masksToBounds =   true
        self.view.addSubview(kBGView)
        
        let aButton     =   UIButton(frame: CGRectMake(0, 20, 50, 50))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(RegisterPlanView.backBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 30, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.view.addSubview(kImgView)
        kImgView.center.x   =   self.view.frame.size.width / 2.0
        
        let descLbl1    =   UILabel(frame: CGRectMake(30.0, 120, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl1.text   =   "ONE MORE TO GO".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.view.addSubview(descLbl1)
        
        var kStart : CGFloat    =   150.0
        
        let str =   "Please select a plan to start using Lenspire"
        
        let height = heightForView(str, font: UIFont(name: Gillsans.Default.description, size: 15.0)!, width: self.view.frame.size.width - (2 * 30.0))
        
        descLbl         =   UILabel(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), height ))
        descLbl?.text   =   str
        descLbl?.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        kStart  =   kStart + height + 30
        
        customView  =   CustomPlanView.instanceFromNib()
        customView.frame    =   CGRectMake(0.0, kStart, 200, 64.0)
        customView.priceLbl.text    =   "$40"
        customView.titleLbl.text    =   "BASIC"
        customView.titleLbl.frame   =   CGRectMake(customView.priceLbl.frame.origin.x + widthForView("$40 ", font: UIFont(name: Gillsans.Default.description, size: 30.0)!), customView.titleLbl.frame.origin.y, customView.titleLbl.frame.size.width, customView.titleLbl.frame.size.height)
        customView.infoBtn.addTarget(self, action: #selector(RegisterPlanView.infoBtnTapped(_:)), forControlEvents: .TouchUpInside)
        customView.infoBtn.tag      =   1
        customView.viewBtn.addTarget(self, action: #selector(RegisterPlanView.viewBtnTapped(_:)), forControlEvents: .TouchUpInside)
        customView.viewBtn.tag      =   1
        self.view.addSubview(customView)
        customView.center.x   =   self.view.frame.size.width / 2.0
        
        kStart  =   kStart + 64.0 + 30.0
        
        customView1  =   CustomPlanView.instanceFromNib()
        customView1.frame    =   CGRectMake(0.0, kStart, 200, 64.0)
        customView1.priceLbl.text    =   "$95"
        customView1.titleLbl.text    =   "PRO"
        customView1.titleLbl.frame   =   CGRectMake(customView1.priceLbl.frame.origin.x + widthForView("$95 ", font: UIFont(name: Gillsans.Default.description, size: 30.0)!), customView1.titleLbl.frame.origin.y, customView1.titleLbl.frame.size.width, customView1.titleLbl.frame.size.height)
        customView1.infoBtn.addTarget(self, action: #selector(RegisterPlanView.infoBtnTapped(_:)), forControlEvents: .TouchUpInside)
        customView1.infoBtn.tag      =   2
        customView1.viewBtn.addTarget(self, action: #selector(RegisterPlanView.viewBtnTapped(_:)), forControlEvents: .TouchUpInside)
        customView1.viewBtn.tag      =   2
        self.view.addSubview(customView1)
        customView1.center.x   =   self.view.frame.size.width / 2.0
        
        kStart  =   kStart + 64.0 + 30.0
        
        customView2  =   CustomPlanView.instanceFromNib()
        customView2.frame    =   CGRectMake(0.0, kStart, 200, 64.0)
        customView2.priceLbl.text    =   "$140"
        customView2.titleLbl.text    =   "VIP"
        customView2.titleLbl.frame   =   CGRectMake(customView2.priceLbl.frame.origin.x + widthForView("$140 ", font: UIFont(name: Gillsans.Default.description, size: 30.0)!), customView2.titleLbl.frame.origin.y, customView2.titleLbl.frame.size.width, customView2.titleLbl.frame.size.height)
        customView2.infoBtn.addTarget(self, action: #selector(RegisterPlanView.infoBtnTapped(_:)), forControlEvents: .TouchUpInside)
        customView2.infoBtn.tag      =   3
        customView2.viewBtn.addTarget(self, action: #selector(RegisterPlanView.viewBtnTapped(_:)), forControlEvents: .TouchUpInside)
        customView2.viewBtn.tag      =   3
        self.view.addSubview(customView2)
        customView2.center.x   =   self.view.frame.size.width / 2.0
        
        kStart  =   kStart + 64.0 + 30.0
        
        
        let kLbl    =   UILabel(frame: CGRectMake(0,self.view.frame.size.height - 40 , self.view.frame.size.width , 40))
        kLbl.textColor  =   UIColor.blackColor()
        kLbl.font   =   UIFont(name: Gillsans.Default.description, size: 13)
        kLbl.textAlignment  =   .Center
        kLbl.textColor  =   UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        kLbl.text   =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        self.view.addSubview(kLbl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }

    func infoBtnTapped (sender : UIButton) {
        
    }
    
    func viewBtnTapped ( sender : UIButton) {
        customView.bgBtn.selected   =   false
        customView1.bgBtn.selected  =   false
        customView2.bgBtn.selected  =   false
        
        if (sender.tag == 1)
        {
            customView.bgBtn.selected   =   true
        }
        if (sender.tag == 2)
        {
            customView1.bgBtn.selected   =   true
        }
        if (sender.tag == 3)
        {
            customView2.bgBtn.selected   =   true
        }
        let contactAddedAlert = UIAlertController(title: "Do you want to continue with this plan!",
            message: nil, preferredStyle: .Alert)
        contactAddedAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            self.confirmPlan(sender.tag)
                }))
        contactAddedAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(contactAddedAlert, animated: true, completion: nil)
        
    }
    
    func confirmPlan (kTag : Int) {
        
        self.view.endEditing(true)
        
            let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
            GetAppDelegate().window?.addSubview(maskView)
            
            let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [ userId,email,"\(kTag)",getDateAfterNintyDays(),jAuth, "1"] , forKeys: [kLS_CP_userId,kLS_CP_email,kLS_CP_planId,kLS_CP_expiryDate,kLS_CP_jauthId,kLS_CP_trailUsedStatus])
            
            ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_registration_savePlanDetail, parm: dict, completion: { result , desc , code in
                maskView.removeFromSuperview()
                if ( code == 99)
                {
                    print("\(result)")
                    if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                    {
                        let kArray2 : NSArray =   result.objectForKey(kLS_CP_status) as! NSArray
                        if (kArray2.count > 0 && (kArray2.objectAtIndex(0) as! NSString).isEqualToString(kLS_CP_success as String))
                        {
                            self.loginAction()
                        }
                        else
                        {
                            MessageAlertView().showMessage(kLS_Err_Msg, kColor : kLS_FailedMsgColor)
                        }
                    }
                    else
                    {
                        MessageAlertView().showMessage(kLS_Err_Msg, kColor : kLS_FailedMsgColor)
                    }
                }
                else
                {
                    MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                }
            })
    }

    func loginAction () {
        self.view.endEditing(true)
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [email,password] , forKeys: [kLS_CP_j_username,kLS_CP_j_password])
        let method: NSString            =   kLS_CM_Login
        
        ServiceWrapper(frame: self.view.frame).postToCloud(method, parm: dict, completion: { result , desc , code in
            
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    
                    var kDict: AnyObject?   =   result.objectForKey(kLS_CP_result)
                    if ((kDict?.isKindOfClass(NSString) == true) )
                    {
                        ShowAlert((kDict as? String)!)
                    }
                    else
                    {
                        
                        kDict   =   (kDict as! NSArray ).objectAtIndex(0) as! NSDictionary
                        GetAppDelegate().loginDetails   =   LoginDetails().setDetails(kDict as! NSDictionary, kDelegate: self)
                        saveUserID(kDict!.objectForKey(kLS_CP_userId) as! NSString)
                        saveAuthToken(kDict!.objectForKey(kLS_CP_authorizationToken) as! NSString)
                        SharedAppController().loadHomeViewFromRegistration()
                        
                        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [(GetAppDelegate().loginDetails?._userId)!,GetAppDelegate().devToken,"IOS"] , forKeys: [kLS_CP_UserId,kLS_CP_DeviceId,kLS_CP_DeviceType])
                        ServiceWrapper(frame: self.view.frame).postToCloud(kLS_CM_UserProfile_SaveDeviceInfo, parm: dict1, completion: { result , desc , code in
                            
                            print(result)
                        })
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

    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}