//
//  CreateProductionBook.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 24/12/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation
protocol CreateProducitonBookVCDelegate
{
    func productionbookCreated()
}
class CreateProducitonBookVC: UIViewController, UITextFieldDelegate, UITextViewDelegate
{
    var scrollView: UIScrollView?
    var prodBookNameTxtFld: UITextField?
    var prodBookNameContainer : UIView?
    var jobNumberTxtFld: UITextField?
    var jobNumberContainer : UIView?
    var shootDateFromTxtFld: UITextField?
    var shootDateFromContainer : UIView?
    var shootDateToTxtFld: UITextField?
    var shootDateToContainer : UIView?
    var clientTxtFld: UITextField?
    var clientContainer : UIView?
    var agencyTxtFld: UITextField?
    var agencyContainer : UIView?
    var shootNotesTxtView: UITextView?
    var shootNotesPlaceHolderLbl : UILabel?
    var shootNotesContainer : UIView?
    var billingInfoTxtView: UITextView?
    var billingInfoContainer : UIView?
    var billingInfoPlaceHolderLbl : UILabel?
    var usageDatesTxtFld: UITextField?
    var usageDatesContainer : UIView?
    var usageFromTxtFld: UITextField?
    var usageFromContainer : UIView?
    var usageToTxtFld: UITextField?
    var usageToContainer : UIView?
    var delegate  : CreateProducitonBookVCDelegate!   =   nil
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func sendRequestToCreate () {
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        GetAppDelegate().window?.addSubview(maskView)
        var usageFromDate   =   ""
        var usageToDate     =   ""
        if ((self.usageFromTxtFld?.text)!.trim() != "")
        {
            usageFromDate   =   productionbookCreateDate((self.usageFromTxtFld?.text)!.trim()) as String
        }
        
        if ((self.usageToTxtFld?.text)!.trim() != "")
        {
            usageToDate   =   productionbookCreateDate((self.usageToTxtFld?.text)!.trim()) as String
        }
        let dict2: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),(self.prodBookNameTxtFld?.text)!.trim(),(self.jobNumberTxtFld?.text)!.trim(), productionbookCreateDate( (self.shootDateFromTxtFld?.text)!.trim()),productionbookCreateDate((self.shootDateToTxtFld?.text)!.trim()),(self.clientTxtFld?.text)!.trim(),(self.agencyTxtFld?.text)!.trim(),(self.shootNotesTxtView?.text)!.trim(),(self.billingInfoTxtView?.text)!.trim(),(self.usageDatesTxtFld?.text)!.trim(),usageFromDate,usageToDate] , forKeys: [kLS_CP_UserId,kLS_CP_ProjectName,kLS_CP_JobNumber,kLS_CP_ShootFromDate,kLS_CP_ShootToDate,kLS_CP_BrandName,kLS_CP_AgencyName,kLS_CP_ShootNotes,kLS_CP_BillingInfo,kLS_CP_UsageTerms,kLS_CP_UsageFromDate,kLS_CP_UsageToDate])
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ProductionBook_CreateProductionBook, parm: dict2, completion: { result , desc , code in
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        isSuccess   =   true
                        MessageAlertView().showMessage("Production book created successfully.", kColor : kLS_SuccessMsgColor)
                        
                        self.delegate.productionbookCreated()
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                if (isSuccess == false)
                {
                    MessageAlertView().showMessage("Creating production book failed.", kColor : kLS_FailedMsgColor)
                }
            }
            else
            {
                
                MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                print(desc)
            }
        })
        
    }
    func createBtnTapped () {
        
        if (validateFields()){
            
            let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),(prodBookNameTxtFld?.text)!.trim()] , forKeys: [kLS_CP_UserId,kLS_CP_ProjectName])
            
            let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
            GetAppDelegate().window?.addSubview(maskView)
            
            ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ProductionBook_CheckProductionBookExists, parm: dict1, completion: { result , desc , code in
                maskView.removeFromSuperview()
                if ( code == 99)
                {
                    if (Int(result as! NSNumber) == 0)
                    {
                        self.sendRequestToCreate()
                    }
                    else
                    {
                        MessageAlertView().showMessage("Production Book with same name already exists.", kColor :kLS_FailedMsgColor)
                    }
                    
                    print(result)
                }
                else
                {
                    MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                    print(desc)
                }
            })
        }
    }
    
    func validateFields () -> Bool {
        self.view.endEditing(true)
        if (prodBookNameTxtFld?.text!.trim() == "")
        {
            prodBookNameTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Book Name is required.", kColor: UIColor.blackColor())
            return false
        }
        if (jobNumberTxtFld?.text!.trim() == "")
        {
            jobNumberTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Job Number is required.", kColor: UIColor.blackColor())
            return false
        }
        if (shootDateFromTxtFld?.text!.trim() == "")
        {
            shootDateFromTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Shoot start date is required.", kColor: UIColor.blackColor())
            return false
        }
        if (shootDateToTxtFld?.text!.trim() == "")
        {
            shootDateToTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Shoot end date is required.", kColor: UIColor.blackColor())
            return false
        }
        if (clientTxtFld?.text!.trim() == "")
        {
            clientTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Client Name is required.", kColor: UIColor.blackColor())
            return false
        }
        if (agencyTxtFld?.text!.trim() == "")
        {
            agencyTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Agency Name is required.", kColor: UIColor.blackColor())
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   =   UIColor.whiteColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreateProducitonBookVC.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(CreateProducitonBookVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let disabledAtt =   [NSForegroundColorAttributeName: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let aBarButtonItem1  =   UIBarButtonItem(title: "CREATE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CreateProducitonBookVC.createBtnTapped))
        aBarButtonItem1.setTitleTextAttributes(disabledAtt, forState: UIControlState.Disabled)
        aBarButtonItem1.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        self.navigationItem.rightBarButtonItem?.enabled     =   false
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "production book".uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
        
        self.scrollView =   UIScrollView(frame: CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height - 64))
        self.view.addSubview(self.scrollView!)
        var kStrtY : CGFloat    =   20.0
        
        prodBookNameContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(prodBookNameContainer!)
        
        let descLbl1         =   UILabel(frame: CGRectMake(0,0, (prodBookNameContainer?.frame.size.width )! , 20))
        descLbl1.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl1.textAlignment   =   .Left
        descLbl1.text        =   "BOOK NAME"
        prodBookNameContainer!.addSubview(descLbl1)
        
        prodBookNameTxtFld              =   UITextField(frame: CGRectMake(0,20,(prodBookNameContainer?.frame.size.width )!,20))
        prodBookNameTxtFld!.delegate    =   self
        prodBookNameTxtFld?.placeholder =   "BOOK NAME"
        prodBookNameTxtFld?.textAlignment  =   .Left
        prodBookNameTxtFld?.autocapitalizationType  =   .AllCharacters
        prodBookNameTxtFld?.keyboardType    =   UIKeyboardType.Default
        prodBookNameTxtFld?.text        =   ""
        prodBookNameTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        prodBookNameContainer!.addSubview(prodBookNameTxtFld!)
        
        let kImgView1        =   UIImageView(frame: CGRectMake(0,(prodBookNameContainer?.frame.size.height )! - 1,(prodBookNameContainer?.frame.size.width )!,1.0))
        kImgView1.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        prodBookNameContainer!.addSubview(kImgView1)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        jobNumberContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(jobNumberContainer!)
        
        let descLbl2         =   UILabel(frame: CGRectMake(0,0, (jobNumberContainer?.frame.size.width )! , 20))
        descLbl2.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl2.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl2.textAlignment   =   .Left
        descLbl2.text        =   "JOB NUMBER"
        jobNumberContainer!.addSubview(descLbl2)
        
        jobNumberTxtFld              =   UITextField(frame: CGRectMake(0,20,(jobNumberContainer?.frame.size.width )!,20))
        jobNumberTxtFld!.delegate    =   self
        jobNumberTxtFld?.placeholder =   "JOB NUMBER"
        jobNumberTxtFld?.textAlignment  =   .Left
        jobNumberTxtFld?.autocapitalizationType  =   .AllCharacters
        jobNumberTxtFld?.keyboardType    =   UIKeyboardType.Default
        jobNumberTxtFld?.text        =   ""
        jobNumberTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        jobNumberContainer!.addSubview(jobNumberTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,(jobNumberContainer?.frame.size.height )! - 1,(jobNumberContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        jobNumberContainer!.addSubview(kImgView2)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        shootDateFromContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(shootDateFromContainer!)
        
        let descLbl3         =   UILabel(frame: CGRectMake(0,0, (shootDateFromContainer?.frame.size.width )! , 20))
        descLbl3.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl3.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl3.textAlignment   =   .Left
        descLbl3.text        =   "SHOOT DATE(From)"
        shootDateFromContainer!.addSubview(descLbl3)
        
        shootDateFromTxtFld              =   UITextField(frame: CGRectMake(0,20,(shootDateFromContainer?.frame.size.width )!,20))
        shootDateFromTxtFld!.delegate    =   self
        shootDateFromTxtFld?.placeholder =   "Start date".uppercaseString
        shootDateFromTxtFld?.textAlignment  =   .Left
        shootDateFromTxtFld?.autocapitalizationType  =   .AllCharacters
        shootDateFromTxtFld?.keyboardType    =   UIKeyboardType.Default
        shootDateFromTxtFld?.text        =   ""
        shootDateFromTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        shootDateFromContainer!.addSubview(shootDateFromTxtFld!)
        
        let calView1         =   UIImageView(frame: CGRectMake((shootDateFromContainer?.frame.size.width)! - 20, 22, 16, 16))
        calView1.image      =   UIImage(named: "calendar1.png")
        shootDateFromContainer!.addSubview(calView1)
        
        let kImgView3        =   UIImageView(frame: CGRectMake(0,(shootDateFromContainer?.frame.size.height )! - 1,(shootDateFromContainer?.frame.size.width )!,1.0))
        kImgView3.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        shootDateFromContainer!.addSubview(kImgView3)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        shootDateToContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(shootDateToContainer!)
        
        let descLbl4         =   UILabel(frame: CGRectMake(0,0, (shootDateToContainer?.frame.size.width )! , 20))
        descLbl4.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl4.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl4.textAlignment   =   .Left
        descLbl4.text        =   "SHOOT DATE(To)"
        shootDateToContainer!.addSubview(descLbl4)
        
        shootDateToTxtFld              =   UITextField(frame: CGRectMake(0,20,(shootDateToContainer?.frame.size.width )!,20))
        shootDateToTxtFld!.delegate    =   self
        shootDateToTxtFld?.placeholder =   "end date".uppercaseString
        shootDateToTxtFld?.textAlignment  =   .Left
        shootDateToTxtFld?.autocapitalizationType  =   .AllCharacters
        shootDateToTxtFld?.keyboardType    =   UIKeyboardType.Default
        shootDateToTxtFld?.text        =   ""
        shootDateToTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        shootDateToContainer!.addSubview(shootDateToTxtFld!)
        
        let calView2         =   UIImageView(frame: CGRectMake((shootDateToContainer?.frame.size.width)! - 20, 22, 16, 16))
        calView2.image      =   UIImage(named: "calendar1.png")
        shootDateToContainer!.addSubview(calView2)
        
        let kImgView4        =   UIImageView(frame: CGRectMake(0,(shootDateToContainer?.frame.size.height )! - 1,(shootDateToContainer?.frame.size.width )!,1.0))
        kImgView4.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        shootDateToContainer!.addSubview(kImgView4)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        clientContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(clientContainer!)
        
        let descLbl5         =   UILabel(frame: CGRectMake(0,0, (clientContainer?.frame.size.width )! , 20))
        descLbl5.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl5.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl5.textAlignment   =   .Left
        descLbl5.text        =   "CLIENT"
        clientContainer!.addSubview(descLbl5)
        
        clientTxtFld              =   UITextField(frame: CGRectMake(0,20,(clientContainer?.frame.size.width )!,20))
        clientTxtFld!.delegate    =   self
        clientTxtFld?.placeholder =   "CLIENT"
        clientTxtFld?.textAlignment  =   .Left
        clientTxtFld?.autocapitalizationType  =   .AllCharacters
        clientTxtFld?.keyboardType    =   UIKeyboardType.Default
        clientTxtFld?.text        =   ""
        clientTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        clientContainer!.addSubview(clientTxtFld!)
        
        let kImgView5        =   UIImageView(frame: CGRectMake(0,(clientContainer?.frame.size.height )! - 1,(clientContainer?.frame.size.width )!,1.0))
        kImgView5.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        clientContainer!.addSubview(kImgView5)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        agencyContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(agencyContainer!)
        
        let descLbl6         =   UILabel(frame: CGRectMake(0,0, (agencyContainer?.frame.size.width )! , 20))
        descLbl6.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl6.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl6.textAlignment   =   .Left
        descLbl6.text        =   "AGENCY"
        agencyContainer!.addSubview(descLbl6)
        
        agencyTxtFld              =   UITextField(frame: CGRectMake(0,20,(agencyContainer?.frame.size.width )!,20))
        agencyTxtFld!.delegate    =   self
        agencyTxtFld?.placeholder =   "AGENCY"
        agencyTxtFld?.textAlignment  =   .Left
        agencyTxtFld?.autocapitalizationType  =   .AllCharacters
        agencyTxtFld?.keyboardType    =   UIKeyboardType.Default
        agencyTxtFld?.text        =   ""
        agencyTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        agencyContainer!.addSubview(agencyTxtFld!)
        
        let kImgView6        =   UIImageView(frame: CGRectMake(0,(agencyContainer?.frame.size.height )! - 1,(agencyContainer?.frame.size.width )!,1.0))
        kImgView6.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        agencyContainer!.addSubview(kImgView6)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        
        shootNotesContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 60))
        self.scrollView?.addSubview(shootNotesContainer!)
        
        let descLbl7         =   UILabel(frame: CGRectMake(0,0, (shootNotesContainer?.frame.size.width )! , 20))
        descLbl7.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl7.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl7.textAlignment   =   .Left
        descLbl7.text        =   "shoot Notes".uppercaseString
        shootNotesContainer!.addSubview(descLbl7)
        
        
        shootNotesPlaceHolderLbl    =   UILabel(frame: CGRectMake(0, 26, (shootNotesContainer?.frame.size.width )!,20))
        shootNotesPlaceHolderLbl!.backgroundColor    =   UIColor.clearColor()
        shootNotesPlaceHolderLbl!.text   =   "shoot notes".uppercaseString
        shootNotesPlaceHolderLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        shootNotesPlaceHolderLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        shootNotesContainer!.addSubview(shootNotesPlaceHolderLbl!)
        
        shootNotesTxtView              =   UITextView(frame: CGRectMake(-4,20,(shootNotesContainer?.frame.size.width )!,40))
        shootNotesTxtView!.delegate    =   self
        shootNotesTxtView?.textAlignment  =   .Left
        shootNotesTxtView?.autocapitalizationType  =   .AllCharacters
        shootNotesTxtView?.keyboardType    =   UIKeyboardType.Default
        shootNotesTxtView?.text        =   ""
        shootNotesTxtView!.backgroundColor       =   UIColor.clearColor()
        shootNotesTxtView!.autocorrectionType    =   UITextAutocorrectionType.No
        shootNotesTxtView?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        shootNotesContainer!.addSubview(shootNotesTxtView!)
        
        let kImgView7        =   UIImageView(frame: CGRectMake(0,(shootNotesContainer?.frame.size.height )! - 1,(shootNotesContainer?.frame.size.width )!,1.0))
        kImgView7.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        shootNotesContainer!.addSubview(kImgView7)
        
        kStrtY      =   kStrtY + 60.0 + 20.0
        
        billingInfoContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 60))
        self.scrollView?.addSubview(billingInfoContainer!)
        
        let descLbl8         =   UILabel(frame: CGRectMake(0,0, (billingInfoContainer?.frame.size.width )! , 20))
        descLbl8.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl8.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl8.textAlignment   =   .Left
        descLbl8.text        =   "billing Info".uppercaseString
        billingInfoContainer!.addSubview(descLbl8)
        
        billingInfoPlaceHolderLbl    =   UILabel(frame: CGRectMake(0, 26, (billingInfoContainer?.frame.size.width )!,20))
        billingInfoPlaceHolderLbl!.backgroundColor    =   UIColor.clearColor()
        billingInfoPlaceHolderLbl!.text   =   "billing info".uppercaseString
        billingInfoPlaceHolderLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        billingInfoPlaceHolderLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        billingInfoContainer!.addSubview(billingInfoPlaceHolderLbl!)
        
        billingInfoTxtView              =   UITextView(frame: CGRectMake(-4,20,(billingInfoContainer?.frame.size.width )!,40))
        billingInfoTxtView!.delegate    =   self
        billingInfoTxtView?.textAlignment  =   .Left
        billingInfoTxtView?.autocapitalizationType  =   .AllCharacters
        billingInfoTxtView?.keyboardType    =   UIKeyboardType.Default
        billingInfoTxtView?.text        =   ""
        billingInfoTxtView!.backgroundColor       =   UIColor.clearColor()
        billingInfoTxtView!.autocorrectionType    =   UITextAutocorrectionType.No
        billingInfoTxtView?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        billingInfoContainer!.addSubview(billingInfoTxtView!)
        
        let kImgView8        =   UIImageView(frame: CGRectMake(0,(billingInfoContainer?.frame.size.height )! - 1,(billingInfoContainer?.frame.size.width )!,1.0))
        kImgView8.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        billingInfoContainer!.addSubview(kImgView8)
        
        kStrtY      =   kStrtY + 60.0 + 20.0
        
        usageDatesContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(usageDatesContainer!)
        
        let descLbl9         =   UILabel(frame: CGRectMake(0,0, (usageDatesContainer?.frame.size.width )! , 20))
        descLbl9.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl9.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl9.textAlignment   =   .Left
        descLbl9.text        =   "usage dates (optional)".uppercaseString
        usageDatesContainer!.addSubview(descLbl9)
        
        usageDatesTxtFld              =   UITextField(frame: CGRectMake(0,20,(usageDatesContainer?.frame.size.width )!,20))
        usageDatesTxtFld!.delegate    =   self
        usageDatesTxtFld?.placeholder =   "TERMS".uppercaseString
        usageDatesTxtFld?.textAlignment  =   .Left
        usageDatesTxtFld?.autocapitalizationType  =   .AllCharacters
        usageDatesTxtFld?.keyboardType    =   UIKeyboardType.Default
        usageDatesTxtFld?.text        =   ""
        usageDatesTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        usageDatesContainer!.addSubview(usageDatesTxtFld!)
        
        let kImgView9        =   UIImageView(frame: CGRectMake(0,(usageDatesContainer?.frame.size.height )! - 1,(usageDatesContainer?.frame.size.width )!,1.0))
        kImgView9.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        usageDatesContainer!.addSubview(kImgView9)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        usageFromContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(usageFromContainer!)
        
        let descLbl10         =   UILabel(frame: CGRectMake(0,0, (usageFromContainer?.frame.size.width )! , 20))
        descLbl10.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl10.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl10.textAlignment   =   .Left
        descLbl10.text        =   "usage from".uppercaseString
        usageFromContainer!.addSubview(descLbl10)
        
        usageFromTxtFld              =   UITextField(frame: CGRectMake(0,20,(usageFromContainer?.frame.size.width )!,20))
        usageFromTxtFld!.delegate    =   self
        usageFromTxtFld?.placeholder =   "Start date".uppercaseString
        usageFromTxtFld?.textAlignment  =   .Left
        usageFromTxtFld?.autocapitalizationType  =   .AllCharacters
        usageFromTxtFld?.keyboardType    =   UIKeyboardType.Default
        usageFromTxtFld?.text        =   ""
        usageFromTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        usageFromContainer!.addSubview(usageFromTxtFld!)
        
        let calView3         =   UIImageView(frame: CGRectMake((usageFromContainer?.frame.size.width)! - 20, 22, 16, 16))
        calView3.image      =   UIImage(named: "calendar1.png")
        usageFromContainer!.addSubview(calView3)
        
        let kImgView10        =   UIImageView(frame: CGRectMake(0,(usageFromContainer?.frame.size.height )! - 1,(usageFromContainer?.frame.size.width )!,1.0))
        kImgView10.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        usageFromContainer!.addSubview(kImgView10)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        usageToContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        self.scrollView?.addSubview(usageToContainer!)
        
        let descLbl11         =   UILabel(frame: CGRectMake(0,0, (usageToContainer?.frame.size.width )! , 20))
        descLbl11.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl11.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl11.textAlignment   =   .Left
        descLbl11.text        =   "usage to".uppercaseString
        usageToContainer!.addSubview(descLbl11)
        
        usageToTxtFld              =   UITextField(frame: CGRectMake(0,20,(usageToContainer?.frame.size.width )!,20))
        usageToTxtFld!.delegate    =   self
        usageToTxtFld?.placeholder =   "end date".uppercaseString
        usageToTxtFld?.textAlignment  =   .Left
        usageToTxtFld?.autocapitalizationType  =   .AllCharacters
        usageToTxtFld?.keyboardType    =   UIKeyboardType.Default
        usageToTxtFld?.text        =   ""
        usageToTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        usageToContainer!.addSubview(usageToTxtFld!)
        
        let calView4         =   UIImageView(frame: CGRectMake((usageToContainer?.frame.size.width)! - 20, 22, 16, 16))
        calView4.image      =   UIImage(named: "calendar1.png")
        usageToContainer!.addSubview(calView4)
        
        let kImgView11        =   UIImageView(frame: CGRectMake(0,(usageToContainer?.frame.size.height )! - 1,(usageToContainer?.frame.size.width )!,1.0))
        kImgView11.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        usageToContainer!.addSubview(kImgView11)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        
        let kImgView0    =   UIImageView(frame: CGRectMake(25, 20, 30, 30))
        kImgView0.userInteractionEnabled =   true
        kImgView0.contentMode    =   .ScaleAspectFit
        kImgView0.image  =   UIImage(named: "news.png")
        self.scrollView?.addSubview(kImgView0)
        
        
         self.scrollView?.contentSize =   CGSizeMake(self.view.frame.size.width, kStrtY)
        if (kStrtY > self.scrollView?.frame.size.height)
        {
            let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kStrtY - 60))
            imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            self.scrollView?.addSubview(imgView)
        }
        else
        {
            let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, (self.scrollView?.frame.size.height)! - 60))
            imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            self.scrollView?.addSubview(imgView)
        }
        self.scrollView?.contentSize =   CGSizeMake(self.view.frame.size.width, kStrtY)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if let swRange = textView.text.rangeFromNSRange(range) {
            let newString = textView.text.stringByReplacingCharactersInRange(swRange, withString: text)
            
            if (NSString(string: "").isEqualToString(newString) == true)
            {
                if (textView == shootNotesTxtView)
                {
                    shootNotesPlaceHolderLbl?.hidden  =  false
                }
                else if (textView == billingInfoTxtView)
                {
                    billingInfoPlaceHolderLbl?.hidden  =  false
                }
            }
            else
            {
                if (textView == shootNotesTxtView)
                {
                    shootNotesPlaceHolderLbl?.hidden  =  true
                }
                else if (textView == billingInfoTxtView)
                {
                    billingInfoPlaceHolderLbl?.hidden  =  true
                }
            }
        }
        
        
        return true
    }

    func textViewDidBeginEditing(textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        let rect : CGRect    =   textView.convertRect(textView.frame, toView: scrollView!)
        let kFocusPoint : CGFloat =   150
        if (rect.origin.y > kFocusPoint)
        {
            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
        }
    }
    
//    func textFieldDidBeginEditing(textField: UITextField) {
//        
//        self.navigationItem.rightBarButtonItem?.enabled     =   true
//        let rect : CGRect    =   textField.convertRect(textField.frame, toView: scrollView!)
//        let kFocusPoint : CGFloat =   150
//        if (rect.origin.y > kFocusPoint)
//        {
//            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
//        }
//    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField == shootDateFromTxtFld || textField == shootDateToTxtFld || textField == usageFromTxtFld || textField == usageToTxtFld)
        {
            self.view.endEditing(true)
            self.navigationItem.rightBarButtonItem?.enabled     =   true
            let rect : CGRect    =   textField.convertRect(textField.frame, toView: scrollView!)
            let kFocusPoint : CGFloat =   150
            if (rect.origin.y > kFocusPoint)
            {
                scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
            }
        }
        
        
        if (textField == shootDateFromTxtFld)
        {
            DatePickerView().loadDatePicker("shoot start date", kSelectedDate: NSDate(), kMinDate: NSDate(), kMaxDate: NSDate(timeIntervalSinceNow: 60*60*24*365*30), isTimePicker: false, completion: { (date) -> () in
                textField.text  =   dateStringForDisplay(date, returnFormat: "MM/dd/yyyy") as String
            })
            
            return false
        }
        else if (textField == shootDateToTxtFld)
        {
            DatePickerView().loadDatePicker("shoot end date", kSelectedDate: NSDate(), kMinDate: NSDate(), kMaxDate: NSDate(timeIntervalSinceNow: 60*60*24*365*30), isTimePicker: false,completion: { (date) -> () in
                textField.text  =   dateStringForDisplay(date, returnFormat: "MM/dd/yyyy") as String
            })
            
            return false
        }
        else if (textField == usageFromTxtFld)
        {
            DatePickerView().loadDatePicker("usage start date", kSelectedDate: NSDate(), kMinDate: NSDate(), kMaxDate: NSDate(timeIntervalSinceNow: 60*60*24*365*30), isTimePicker: false,completion: { (date) -> () in
                textField.text  =   dateStringForDisplay(date, returnFormat: "MM/dd/yyyy") as String
            })
            return false
        }
        else if (textField == usageToTxtFld)
        {
            DatePickerView().loadDatePicker("usage end date", kSelectedDate: NSDate(), kMinDate: NSDate(), kMaxDate: NSDate(timeIntervalSinceNow: 60*60*24*365*30), isTimePicker: false,completion: { (date) -> () in
                textField.text  =   dateStringForDisplay(date, returnFormat: "MM/dd/yyyy") as String
            })
            return false
        }
        
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        let rect : CGRect    =   textField.convertRect(textField.frame, toView: scrollView!)
        let kFocusPoint : CGFloat =   150
        if (rect.origin.y > kFocusPoint)
        {
            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == prodBookNameTxtFld)
        {
            jobNumberTxtFld?.becomeFirstResponder()
        }
        else if (textField == clientTxtFld)
        {
            agencyTxtFld?.becomeFirstResponder()
        }
        else if (textField == agencyTxtFld)
        {
            shootNotesTxtView?.becomeFirstResponder()
        }
        else if (textField == usageDatesTxtFld)
        {
            usageFromTxtFld?.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        return true
    }

}


class DatePickerView : UIView {
    
    var kTempView1 : UIView =   UIView()
    var completionHandler : ((NSDate) -> ())!
    var selectedDate : NSDate?
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadDatePicker (kTitle:String, kSelectedDate: NSDate, kMinDate: NSDate, kMaxDate: NSDate, isTimePicker: Bool, completion : (NSDate) -> ()) {
        GetAppDelegate().window?.addSubview(self)
        self.completionHandler  =   completion
        selectedDate    =   kSelectedDate
        
        let kTempView   =   UIView (frame: self.frame)
        kTempView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DatePickerView.viewTapped)))
        self.addSubview(kTempView)
        
        kTempView1  =   UIView (frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 254))
        kTempView1.backgroundColor  =   UIColor.whiteColor()
        self.addSubview(kTempView1)
        
        
        let datePicker  : UIDatePicker  =   UIDatePicker(frame: CGRectMake(0, 14, UIScreen.mainScreen().bounds.size.width, 270))
        datePicker.datePickerMode       =   .Date
        datePicker.date             =   kSelectedDate
        datePicker.maximumDate      =   kMaxDate
        datePicker.minimumDate      =   kMinDate
        datePicker.addTarget(self, action: #selector(DatePickerView.dateChanged(_:)), forControlEvents: .ValueChanged)
       
        if (isTimePicker)
        {
            datePicker.datePickerMode = .Time
            datePicker.locale = NSLocale(localeIdentifier: "en_US")
        }
            kTempView1.addSubview(datePicker)
        
        
        let kToolBar  =   UIToolbar(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.size.width,44))

        let normAtt1     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE  ", style: UIBarButtonItemStyle.Done, target: self, action: #selector(DatePickerView.doneBtnTapped))
        aBarButtonItem1.setTitleTextAttributes(normAtt1, forState: UIControlState.Normal)
        
        
        let flexibleSpace =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace , target: self, action: nil)
        
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let aBarButtonItem  =   UIBarButtonItem(title: "  CANCEL", style: UIBarButtonItemStyle.Done, target: self, action: #selector(DatePickerView.cancelBtnTapped))
        aBarButtonItem.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        kToolBar.setItems([aBarButtonItem,flexibleSpace,aBarButtonItem1], animated: true)
        kTempView1.addSubview(kToolBar)
        
        let descLbl        =   UILabel(frame:  CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 44))
        descLbl.text       =   kTitle.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView1.addSubview(descLbl)
        
        
        UIView.animateWithDuration(0.30) { () -> Void in
            self.kTempView1.frame    =   CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 254, UIScreen.mainScreen().bounds.size.width, 254)
        }
        
    }
    
    func dateChanged (picker:UIDatePicker) {
        selectedDate    =   picker.date
    }
    
    func viewTapped () {
        removeView()
    }
    
    func doneBtnTapped () {
        self.completionHandler(selectedDate!)
        removeView()
    }
    
    func cancelBtnTapped () {
       removeView()
    }
    
    func removeView () {
        UIView.animateWithDuration(0.30, animations: { () -> Void in
            self.kTempView1.frame    =   CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, 254)
            }) { (isCompleted) -> Void in
                self.removeFromSuperview()
        }
    }
}


class CreateScheduleVC: UIViewController, UITextFieldDelegate, UITextViewDelegate , OptionsControllerDelegate
{
    var scrollView: UIScrollView?
    var _fldHeight: CGFloat?
    var _fldMargin: CGFloat?
    var _fldsGap: CGFloat?
    var _viewWidth: CGFloat?
    var _viewHeight: CGFloat?
    var _bottomViewHeight: CGFloat?
    var viewController : ProductionbookViewVC?
    var selectTimeLbl : UILabel?
    var selectTimeBtn : UIButton?
    var selectLocationLbl : UILabel?
    var selectLocationBtn : UIButton?
    var selectCrewBtn : UIButton?
    var selectCrewLbl : UILabel?
    var addAttBtn : UIButton?
    var addAttLbl : UILabel?
    var notesTxtView: UITextView?
    var placeHolderLbl : UILabel?
    var eventNameTxtFiled : UITextField?
    
    var isEditMode : Bool   =   false
    var scheduleEvent : ScheduleEvent!
    
    var itineraryId : NSString  =   ""
    var pbDate : NSString       =   ""
    var productionBookId : NSString =   ""
    var scheduleId : NSString   =   ""
    var selectedCrewIds : String    =   ""
    var locationDesc : NSString     =   ""
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    func selectedObjects (kArray : NSArray, kViewType: Int) {
        print(kArray)
        
        
        if (kArray.count > 0) {
            let kMutArray   =   NSMutableArray()
            let kIdsArray   =   NSMutableArray()
            for confArtObj in kArray {
                
                kMutArray.addObject(((confArtObj as? ConfirmedArtistObj)?._UserName)!)
                kIdsArray.addObject(((confArtObj as? ConfirmedArtistObj)?._ArtistId)!)
            }
            
            selectCrewLbl?.text =   kMutArray.componentsJoinedByString(", ")
            selectCrewLbl?.textColor    =   UIColor.blackColor()
            selectedCrewIds     =   kIdsArray.componentsJoinedByString(",")
        }
        else
        {
            selectCrewLbl?.text =   "select crew".uppercaseString
            selectCrewLbl?.textColor    =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            selectedCrewIds     =   ""
            
        }
    }
    
    func updateBtnTapped () {
        if (eventNameTxtFiled?.text?.trim() == "") {
            MessageAlertView().showMessage("Specify event name", kColor: kLS_FailedMsgColor)
            return
        }
        
        if (selectTimeLbl!.text   ==   "SELECT TIME".uppercaseString) {
            
            MessageAlertView().showMessage("Select time", kColor: kLS_FailedMsgColor)
            return
        }
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        GetAppDelegate().window?.addSubview(maskView)
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [scheduleEvent._scheduleId, getUserID(),productionBookId,(eventNameTxtFiled?.text)!,selectedCrewIds,locationDesc,"",(notesTxtView?.text)!,(selectTimeLbl?.text)!] , forKeys: [kLS_CP_scheduleId,kLS_CP_userId,kLS_CP_productionBookId,kLS_CP_scheduleAction,kLS_CP_scheduleCrew,kLS_CP_scheduleLocation,kLS_CP_scheduleLocationId,kLS_CP_scheduleNotes,kLS_CP_scheduleTime])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Schedule_UpdateScheduleEvent, parm: dict1, completion: { result , desc , code in
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        isSuccess   =   true
                        MessageAlertView().showMessage("Schedule updated successfully.", kColor : kLS_SuccessMsgColor)
                        
                        self.viewController?.scheduleCreated()
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                if (isSuccess == false)
                {
                    MessageAlertView().showMessage("Updating schedule failed.", kColor : kLS_FailedMsgColor)
                }
            }
            else
            {
                
                MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                print(desc)
            }
        })

    }
    func doneBtnTapped () {

        if (eventNameTxtFiled?.text?.trim() == "") {
            MessageAlertView().showMessage("Specify event name", kColor: kLS_FailedMsgColor)
            return
        }
        
        if (selectTimeLbl!.text   ==   "SELECT TIME".uppercaseString) {
            
            MessageAlertView().showMessage("Select time", kColor: kLS_FailedMsgColor)
            return
        }
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        GetAppDelegate().window?.addSubview(maskView)
    
         let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),productionBookId,(eventNameTxtFiled?.text)!,selectedCrewIds,pbDate,locationDesc,(notesTxtView?.text)!,(selectTimeLbl?.text)!] , forKeys: [kLS_CP_userId,kLS_CP_productionBookId,kLS_CP_scheduleAction,kLS_CP_scheduleCrew,kLS_CP_scheduleDate,kLS_CP_scheduleLocation,kLS_CP_scheduleNotes,kLS_CP_scheduleTime])
      
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Schedule_CreateScheduleEvent, parm: dict1, completion: { result , desc , code in
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print(result)
                
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        isSuccess   =   true
                        MessageAlertView().showMessage("Schedule created successfully.", kColor : kLS_SuccessMsgColor)
                        
                        self.viewController?.scheduleCreated()
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
                if (isSuccess == false)
                {
                    MessageAlertView().showMessage("Creating schedule failed.", kColor : kLS_FailedMsgColor)
                }
            }
            else
            {
                
                MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                print(desc)
            }
        })

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _viewWidth  =   self.view.frame.size.width
        _viewHeight =   self.view.frame.size.height
        
        _fldHeight   =   30.0
        _fldMargin   =   15.0
        _fldsGap     =   20.0
        _bottomViewHeight   =   40.0
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreateProducitonBookVC.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "CREATE SCHEDULE"
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
        aButton.addTarget(self, action: #selector(CreateProducitonBookVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        //Set scrollView
        
        let disabledAtt =   [NSForegroundColorAttributeName: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        if (isEditMode){
            let aBarButtonItem1  =   UIBarButtonItem(title: "UPDATE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(CreateScheduleVC.updateBtnTapped))
            aBarButtonItem1.setTitleTextAttributes(disabledAtt, forState: UIControlState.Disabled)
            aBarButtonItem1.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
            self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        }
        else {
        let aBarButtonItem1  =   UIBarButtonItem(title: "CREATE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(DatePickerView.doneBtnTapped))
        aBarButtonItem1.setTitleTextAttributes(disabledAtt, forState: UIControlState.Disabled)
        aBarButtonItem1.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        }
        scrollView  =   UIScrollView(frame: CGRectMake(0, 0, _viewWidth!, _viewHeight! - _bottomViewHeight!))
        self.view.addSubview(scrollView!)
        //Set First two picker selectors
        
        
        let tempImgView :   UIImageView =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64))
        //     tempImgView.image   =   UIImage(CGImage: (storyObj?._thumbImg.CGImage)!).convertToGrayScale()
        tempImgView.contentMode = UIViewContentMode.ScaleAspectFit
        tempImgView.alpha   =   0.1
        tempImgView.userInteractionEnabled  =   true
        tempImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreateScheduleVC.tapAction)))
        scrollView?.addSubview(tempImgView)
        
        var kStartPoint: CGFloat    =    20
        

        let kView1: UIView  =   UIView(frame: CGRectMake(_fldMargin!, kStartPoint, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        scrollView?.addSubview(kView1)
        kView1.layer.borderWidth  =   1.0
        kView1.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        kView1.layer.cornerRadius =   3.0
        
        eventNameTxtFiled   =   UITextField(frame:CGRectMake(10,0,kView1.frame.size.width - 20 , kView1.frame.size.height))
        eventNameTxtFiled?.placeholder  =   "Enter event name".uppercaseString
        eventNameTxtFiled?.font     =   UIFont(name: Gillsans.Default.description, size: 15.0)
        kView1.addSubview(eventNameTxtFiled!)
        
        kStartPoint =   kStartPoint + _fldHeight! + _fldsGap!
        
        let kView2: UIView  =   UIView(frame: CGRectMake(_fldMargin!, kStartPoint, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        scrollView?.addSubview(kView2)
        selectTimeLbl    =   UILabel(frame: CGRectMake(10, 0, kView2.frame.size.width - 30, kView2.frame.size.height))
        selectTimeLbl!.backgroundColor    =   UIColor.clearColor()
        selectTimeLbl!.text   =   "SELECT TIME".uppercaseString
        selectTimeLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        selectTimeLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView2.addSubview(selectTimeLbl!)
        
        let arrowImg2      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg2.image    =   UIImage(named: "arrow.png")
        kView2.addSubview(arrowImg2)
        arrowImg2.center.x   =   kView2.frame.size.width - 15.0
        arrowImg2.center.y   =   kView2.frame.size.height / 2.0
        
        selectTimeBtn     =   UIButton(type: UIButtonType.Custom)
        selectTimeBtn!.frame      =   CGRectMake(0, 0, kView2.frame.size.width, kView2.frame.size.height)
        selectTimeBtn!.backgroundColor    =   UIColor.clearColor()
        selectTimeBtn!.layer.borderWidth  =   1.0
        selectTimeBtn!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        selectTimeBtn!.layer.cornerRadius =   3.0
        selectTimeBtn!.addTarget(self, action: #selector(CreateScheduleVC.selectTimeBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        kView2.addSubview(selectTimeBtn!)
        
        kStartPoint =   kStartPoint + _fldHeight! + _fldsGap!
        
        let kView3: UIView  =   UIView(frame: CGRectMake(_fldMargin!, kStartPoint, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        scrollView?.addSubview(kView3)
        
        selectLocationLbl    =   UILabel(frame: CGRectMake(10, 0, kView3.frame.size.width - 30, kView3.frame.size.height))
        selectLocationLbl!.backgroundColor    =   UIColor.clearColor()
        selectLocationLbl!.text   =   "SELECT location".uppercaseString
        selectLocationLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        selectLocationLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView3.addSubview(selectLocationLbl!)
        
        let arrowImg3      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg3.image    =   UIImage(named: "arrow.png")
        kView3.addSubview(arrowImg3)
        arrowImg3.center.x   =   kView3.frame.size.width - 15.0
        arrowImg3.center.y   =   kView3.frame.size.height / 2.0
        
        selectLocationBtn     =   UIButton(type: UIButtonType.Custom)
        selectLocationBtn!.frame      =   CGRectMake(0, 0, kView3.frame.size.width, kView3.frame.size.height)
        selectLocationBtn!.backgroundColor    =   UIColor.clearColor()
        selectLocationBtn!.layer.borderWidth  =   1.0
        selectLocationBtn!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        selectLocationBtn!.layer.cornerRadius =   3.0
        selectLocationBtn!.addTarget(self, action: #selector(CreateScheduleVC.selectLocationBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        kView3.addSubview(selectLocationBtn!)
        
        kStartPoint =   kStartPoint + _fldHeight! + _fldsGap!
        
        let kView4: UIView   =   UIView(frame: CGRectMake(_fldMargin!,  kStartPoint, (_viewWidth! - (2 * _fldMargin!)), _fldHeight! * 2))
        scrollView?.addSubview(kView4)
        
        placeHolderLbl    =   UILabel(frame: CGRectMake(10, 0, kView4.frame.size.width - 30,
            _fldHeight!))
        placeHolderLbl!.backgroundColor    =   UIColor.clearColor()
        placeHolderLbl!.text   =   "Notes".uppercaseString
        placeHolderLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        placeHolderLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView4.addSubview(placeHolderLbl!)
        
        notesTxtView                       =   UITextView(frame: CGRectMake(0, 0, (_viewWidth! - (2 * _fldMargin!)), _fldHeight! * 2))
        notesTxtView!.delegate             =   self
        notesTxtView!.layer.borderColor    =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        notesTxtView!.layer.cornerRadius    =   3.0
        notesTxtView!.layer.borderWidth    =   1.0
        notesTxtView!.font                  =   UIFont(name: Gillsans.Default.description, size: 15.0)
        notesTxtView!.backgroundColor       =   UIColor.clearColor()
        notesTxtView!.autocorrectionType    =   UITextAutocorrectionType.No
        //    notesTxtView?.userInteractionEnabled    =   false
        kView4.addSubview(notesTxtView!)

        kStartPoint =   kStartPoint + _fldHeight! * 2 + _fldsGap!
        
        let kView5: UIView  =   UIView(frame: CGRectMake(_fldMargin!, kStartPoint, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        scrollView?.addSubview(kView5)
        
        selectCrewLbl    =   UILabel(frame: CGRectMake(10, 0, kView5.frame.size.width - 30, kView5.frame.size.height))
        selectCrewLbl!.backgroundColor    =   UIColor.clearColor()
        selectCrewLbl!.text   =   "SELECT crew".uppercaseString
        selectCrewLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        selectCrewLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView5.addSubview(selectCrewLbl!)
        
        let arrowImg5      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg5.image    =   UIImage(named: "arrow.png")
        kView5.addSubview(arrowImg5)
        arrowImg5.center.x   =   kView5.frame.size.width - 15.0
        arrowImg5.center.y   =   kView5.frame.size.height / 2.0
        
        selectCrewBtn     =   UIButton(type: UIButtonType.Custom)
        selectCrewBtn!.frame      =   CGRectMake(0, 0, kView5.frame.size.width, kView5.frame.size.height)
        selectCrewBtn!.backgroundColor    =   UIColor.clearColor()
        selectCrewBtn!.layer.borderWidth  =   1.0
        selectCrewBtn!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        selectCrewBtn!.layer.cornerRadius =   3.0
        selectCrewBtn!.addTarget(self, action: #selector(CreateScheduleVC.selectCrewBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        kView5.addSubview(selectCrewBtn!)
        
        kStartPoint =   kStartPoint + _fldHeight! + _fldsGap!
        
        let kView6: UIView  =   UIView(frame: CGRectMake(_fldMargin!, kStartPoint, _viewWidth! - (2 * _fldMargin!), _fldHeight!))
        scrollView?.addSubview(kView6)
        
        addAttLbl    =   UILabel(frame: CGRectMake(10, 0, kView6.frame.size.width - 30, kView6.frame.size.height))
        addAttLbl!.backgroundColor    =   UIColor.clearColor()
        addAttLbl!.text   =   "add attachment".uppercaseString
        addAttLbl!.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        addAttLbl!.textColor  =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        kView6.addSubview(addAttLbl!)
        
        let arrowImg6      =   UIImageView(frame: CGRectMake(0 , 0 , 10 , 10))
        arrowImg6.image    =   UIImage(named: "arrow.png")
        kView6.addSubview(arrowImg6)
        arrowImg6.center.x   =   kView6.frame.size.width - 15.0
        arrowImg6.center.y   =   kView6.frame.size.height / 2.0
        
        addAttBtn     =   UIButton(type: UIButtonType.Custom)
        addAttBtn!.frame      =   CGRectMake(0, 0, kView6.frame.size.width, kView6.frame.size.height)
        addAttBtn!.backgroundColor    =   UIColor.clearColor()
        addAttBtn!.layer.borderWidth  =   1.0
        addAttBtn!.layer.borderColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1).CGColor
        addAttBtn!.layer.cornerRadius =   3.0
        addAttBtn!.addTarget(self, action: #selector(CreateScheduleVC.addAttBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        kView6.addSubview(addAttBtn!)
        
        
        if (isEditMode) {
            eventNameTxtFiled?.text     =   scheduleEvent._scheduleAction.uppercaseString
            self.selectTimeLbl?.text    =   scheduleEvent._scheduleTime.uppercaseString
            self.selectTimeLbl?.textColor    =   UIColor.blackColor()
            self.selectLocationLbl?.text    =   scheduleEvent._locationName.uppercaseString
            locationDesc            =   scheduleEvent._locationName
            self.selectLocationLbl?.textColor    =   UIColor.blackColor()
            self.notesTxtView?.text     =   scheduleEvent._scheduleNotes.uppercaseString
            self.placeHolderLbl?.hidden  =  true
            
            selectCrewLbl?.text =   scheduleEvent._artistUserName as String
            selectedCrewIds     =   scheduleEvent._artistCrew as String
            
            if (selectCrewLbl?.text == "") {
                
            }
            else
            {
                 selectCrewLbl?.textColor    =   UIColor.blackColor()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func selectTimeBtnTapped (sender : UIButton) {
        self.view.endEditing(true)
        DatePickerView().loadDatePicker("select time", kSelectedDate: NSDate().daybeginning(), kMinDate: NSDate().daybeginning(), kMaxDate: NSDate().dayEndings(), isTimePicker: true, completion: { (date) -> () in
            let text  =   dateStringForDisplay(date, returnFormat: "hh:mm a") as String
            self.selectTimeLbl?.text =   text
            self.selectTimeLbl?.textColor    =   UIColor.blackColor()
        })
    }
    func selectLocationBtnTapped (sender : UIButton) {
        let placesVc    =   GooglePlacesVC()
        placesVc.getLocationCompletion { (location) -> () in
            self.locationDesc        =   location
            self.selectLocationLbl?.text    =   location
            self.selectLocationLbl?.textColor    =   UIColor.blackColor()
        }
        self.navigationController?.pushViewController(placesVc, animated: true)
    }
    func selectCrewBtnTapped (sender : UIButton) {
        let optionsView     =   OptionsController()
        optionsView.kTitle  =   "Select Crew".uppercaseString
        optionsView.prevSelected    =   NSArray(object: selectedCrewIds)
        optionsView.delegate    =   self
        optionsView.viewType    =   5
        optionsView.pbDate     =   self.pbDate
        optionsView.productionBookId    =   self.productionBookId
        optionsView.isSingleSelection   =   false
        self.navigationController?.pushViewController(optionsView, animated: true)
    }
    func addAttBtnTapped (sender: UIButton) {
        MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
    }
    func tapAction () {
        self.view.endEditing(true)
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
                placeHolderLbl?.hidden  =  true
            }
        }
        
        return true
    }
    func textViewDidBeginEditing(textView: UITextView) {
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        let rect : CGRect    =   textView.convertRect(textView.frame, toView: scrollView!)
        let kFocusPoint : CGFloat =   150
        if (rect.origin.y > kFocusPoint)
        {
            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
        }
    }
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        let rect : CGRect    =   textField.convertRect(textField.frame, toView: scrollView!)
        let kFocusPoint : CGFloat =   150
        if (rect.origin.y > kFocusPoint)
        {
            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
        }
        return true
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
//        if (textField == prodBookNameTxtFld)
//        {
//            jobNumberTxtFld?.becomeFirstResponder()
//        }
//        else if (textField == clientTxtFld)
//        {
//            agencyTxtFld?.becomeFirstResponder()
//        }

        
        textField.resignFirstResponder()
        return true
    }
    
}



class CallaheetAddArtistVC: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var specObjects : NSArray   =   NSArray()
    var tempObjects : NSArray   =   NSArray()
    var tbleView: UITableView?
    var kWidth : CGFloat?
    var selectedObjects : NSMutableArray    =   NSMutableArray()
    var prevSelected    =   NSArray()
   
    var searchBar: UISearchBar!
    
    var pbFromDate : NSString   =   ""
    var pbToDate : NSString     =   ""
    var pbName : NSString     =   ""
    var productionBookId : NSString =   ""
    var castingId : NSString    =   ""
    var castingCode : NSString  =   ""
    var viewController : ProductionbookViewVC?
    func backBtnTapped () {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func doneBtnTapped () {
        
        if (selectedObjects.count > 0) {
            let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
            let specObj    =   (selectedObjects.objectAtIndex(0) as? PBuserListObj)!
            let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),productionBookId,castingId,specObj._userId,specObj._email,specObj._enabledStatus,(specObj._firstName as String) + " " + (specObj._lastName as String),(GetAppDelegate().loginDetails?._email)!,pbFromDate,pbToDate,pbName,((GetAppDelegate().loginDetails?._firstName)! as String) + " " + ((GetAppDelegate().loginDetails?._lastName)! as String)] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionbookId,kLS_CP_CastingId,kLS_CP_CastingUserId,kLS_CP_ArtistEmail,kLS_CP_ArtistEnabled,kLS_CP_ArtistName,kLS_CP_Email,kLS_CP_PB_FromDt,kLS_CP_PB_ToDt,kLS_CP_ProjectName,kLS_CP_UserName])
            ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ProductionBook_AddArtistToCrew, parm: dict1, completion: { result , desc , code in
               maskView.removeFromSuperview()
                print("\(result)")
                if ( code == 99)
                {
                }
                else
                {
                    if((desc as NSString).isKindOfClass(NSNull) == false)
                    {
                        MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                    }
                }
                self.viewController?.callsheetCrewAdded()
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(CreateProducitonBookVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let disabledAtt =   [NSForegroundColorAttributeName: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        
        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(DatePickerView.doneBtnTapped))
        aBarButtonItem1.setTitleTextAttributes(disabledAtt, forState: UIControlState.Disabled)
        aBarButtonItem1.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        self.navigationItem.rightBarButtonItem?.enabled     =   false
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "Add crew".uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
        searchBar   =   UISearchBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        searchBar.delegate = self
        searchBar.returnKeyType =   UIReturnKeyType.Done
        searchBar.enablesReturnKeyAutomatically =   false
        searchBar.placeholder   =   "Search"
        self.view.addSubview(searchBar)
        searchBar.hidden    =   true
        
        tbleView    =   UITableView(frame: CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 64 - 44), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
        tbleView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tbleView!)
       
        loadDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchText == "")
        {
            self.specObjects    =   NSArray(array: tempObjects)
            self.tbleView?.reloadData()
            return
        }
        
        
        let predicate : NSPredicate =   NSPredicate(format: "(SELF._firstName contains[c] %@) OR (SELF._lastName contains[c] %@)", argumentArray: [searchText,searchText])
        self.specObjects    =   tempObjects.filteredArrayUsingPredicate(predicate)
        
        self.tbleView?.reloadData()
        
    }
    
    func loadDetails () {
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No detail found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),productionBookId,castingId,castingCode] , forKeys: [kLS_CP_UserId,kLS_CP_ProductionbookId,kLS_CP_CastingId,kLS_CP_CastingCode])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_ProductionBook_GetProductionBookUserList, parm: dict1, completion: { result , desc , code in
            processView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    isSuccess   =   true
                    let kArr: AnyObject?   =   result .objectForKey(kLS_CP_result)
                    
                    if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSArray) == true)
                    {
                        let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_firstName as String, ascending: true)
                        let brandDescriptor1: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_lastName as String, ascending: true)
                        let sortDescriptors: NSArray =  NSArray(objects: brandDescriptor,brandDescriptor1)
                        let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                        
                        let kTempArr : NSMutableArray   =   NSMutableArray()
                        for kDict in sortedArray {
                            self.searchBar.hidden   =   false
                            let specObj : PBuserListObj   =   PBuserListObj().setDetails(kDict as! NSDictionary)
                            
                            kTempArr.addObject(specObj)
                            
                            
                            for speObj in self.prevSelected {
                                
                                if ((speObj as? NSString)?.isEqualToString(specObj._specialityCd as String) == true)
                                {
                                    kTempArr.removeObject(specObj)
                                    
                                }
                            }
                        }
                        
                        self.specObjects    =   NSArray(array: kTempArr)
                        self.tempObjects    =   NSArray(array: kTempArr)
                    }
                    
                    
                }
                if (isSuccess == false || self.specObjects.count == 0)
                {
                    noLbl.hidden    =   false
                    MessageAlertView().showMessage("No details found", kColor : kLS_FailedMsgColor)
                    self.navigationController?.popViewControllerAnimated(true)
                }
            }
            else
            {
                noLbl.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                    MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                }
                self.navigationController?.popViewControllerAnimated(true)
            }
            
            
            self.tbleView?.reloadData()
            
        })
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
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
        
        
        let specObj    =   (specObjects.objectAtIndex(indexPath.row) as? PBuserListObj)!
        
        
        if ( self.selectedObjects.containsObject(specObj))
        {
            cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        let descLbl        =   UILabel(frame: CGRectMake(20,5, self.view.frame.size.width - 30 , 25))
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        let descLbl1        =   UILabel(frame: CGRectMake(20,30, self.view.frame.size.width - 30 , 15))
        descLbl1.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl1.font            =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl1.textAlignment  =   .Left
        cell.addSubview(descLbl1)
       
        descLbl.text    =   specObj._firstName.uppercaseString + " " + specObj._lastName.uppercaseString
        descLbl1.text   =   specObj._email as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        let specObj    =   (specObjects.objectAtIndex(indexPath.row) as? PBuserListObj)!
        
     
                if (self.selectedObjects.containsObject(specObj))
                {
                    self.selectedObjects.removeObject(specObj)
                    self.navigationItem.rightBarButtonItem?.enabled     =   false
                }
                else
                {
                    self.selectedObjects.removeAllObjects()
                    self.selectedObjects.addObject(specObj)
                }
        
        tableView.reloadData()
    }
    
}

