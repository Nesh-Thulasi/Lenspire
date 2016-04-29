//
//  ApplyMembership.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 09/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class ApplyMembershipVC: UIViewController, UITextFieldDelegate
{
    var scrollView: UIScrollView?
    var organizationTxtFld: UITextField?
    var organizationContainer : UIView?
    var firtNameTxtFld: UITextField?
    var firtNameContainer : UIView?
    var lastNameTxtFld: UITextField?
    var lastNameContainer : UIView?
    var emailTxtFld: UITextField?
    var emailContainer : UIView?
    var phoneTxtFld: UITextField?
    var phoneContainer : UIView?
    var primaryroleTxtFld: UITextField?
    var primaryroleContainer : UIView?
    var missionTxtFld: UITextField?
    var missionContainer : UIView?
    var selectedPrimaryRoleId : NSString    =   ""
    var applyBtn : UIButton?
    var email : String  =   ""
    var orgName : String  =   ""
    var orgId : String  =   ""
    var viewType : Int  =   1
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    func callRegistration(kMethod : String, dict : NSMutableDictionary) {
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        GetAppDelegate().window?.addSubview(maskView)
        ServiceWrapper(frame: CGRectZero).postToCloud(kMethod, parm: dict, completion: { result , desc , code in
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
                        self.navigationController?.popToRootViewControllerAnimated(true)  
                        ShowAlert("Your request for membership has been registered. You will receive an email with the signup link after your request is approved.")
                        
                    }
                }
                if (isSuccess == false)
                {
                    MessageAlertView().showMessage("Apply for membership failed.", kColor : kLS_FailedMsgColor)
                }
            }
            else
            {
                
                MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                print(desc)
            }
        })
        
    }
    
    func applyBtnTapped () {
        
        self.view.endEditing(true)
        
        if (validateFields()){
            
            var dict2: NSMutableDictionary   = NSMutableDictionary()
            if (viewType == 1) {
                dict2   =    NSMutableDictionary(objects: [(self.firtNameTxtFld?.text)!.trim(),(self.lastNameTxtFld?.text)!.trim(),(self.emailTxtFld?.text)!.trim(),(self.phoneTxtFld?.text)!.trim(),selectedPrimaryRoleId,(self.missionTxtFld?.text)!.trim()] , forKeys: [kLS_CP_firstName,kLS_CP_lastName,kLS_CP_email,kLS_CP_phoneNo,kLS_CP_speciality,kLS_CP_mission])
                
                callRegistration(kLS_CM_registration_SaveJoinMember as String, dict: dict2)
            }
            else if (viewType == 2) {
                dict2   =    NSMutableDictionary(objects: [(self.firtNameTxtFld?.text)!.trim(),(self.lastNameTxtFld?.text)!.trim(),(self.emailTxtFld?.text)!.trim(),(self.phoneTxtFld?.text)!.trim(),selectedPrimaryRoleId,(self.missionTxtFld?.text)!.trim(),(self.organizationTxtFld?.text)!.trim()] , forKeys: [kLS_CP_firstName,kLS_CP_lastName,kLS_CP_email,kLS_CP_phone,kLS_CP_speciality,kLS_CP_mission,kLS_CP_orgName])
                let dict1   =    NSMutableDictionary(objects: [ (self.organizationTxtFld?.text)!.trim()] , forKeys: [kLS_CP_orgName])
                
                let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
                GetAppDelegate().window?.addSubview(maskView)
                ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_company_checkOrgNameAvailablilty, parm: dict1, completion: { result , desc , code in
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
                                
                                self.callRegistration(kLS_CM_company_SaveCompany as String, dict: dict2)
                            }
                        }
                        if (isSuccess == false)
                        {
                            MessageAlertView().showMessage("Organization name already taken. Please try new one.", kColor : kLS_FailedMsgColor)
                            self.organizationTxtFld?.becomeFirstResponder()
                        }
                    }
                    else
                    {
                        MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                        print(desc)
                    }
                })
                
            }
            else if (viewType == 3) {
                dict2   =    NSMutableDictionary(objects: [(self.firtNameTxtFld?.text)!.trim(),(self.lastNameTxtFld?.text)!.trim(),(self.emailTxtFld?.text)!.trim(),(self.phoneTxtFld?.text)!.trim(),selectedPrimaryRoleId,(self.missionTxtFld?.text)!.trim(),(self.organizationTxtFld?.text)!.trim(),self.orgId] , forKeys: [kLS_CP_firstName,kLS_CP_lastName,kLS_CP_email,kLS_CP_phoneNo,kLS_CP_speciality,kLS_CP_mission,kLS_CP_orgName,kLS_CP_orgId])
                callRegistration(kLS_CM_registration_SaveMember as String, dict: dict2)
            }
        }
    
    

    }
    func validateFields () -> Bool {
        self.view.endEditing(true)
        
        if (self.viewType == 2)
        {
            if (organizationTxtFld?.text!.trim() == "")
            {
                organizationTxtFld?.becomeFirstResponder()
                MessageAlertView().showMessage("Organization Name is required.", kColor: UIColor.blackColor())
                return false
            }
        }
        if (firtNameTxtFld?.text!.trim() == "")
        {
            firtNameTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("First Name is required.", kColor: UIColor.blackColor())
            return false
        }
        if (lastNameTxtFld?.text!.trim() == "")
        {
            lastNameTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Last Name is required.", kColor: UIColor.blackColor())
            return false
        }
        if (phoneTxtFld?.text!.trim() == "")
        {
            phoneTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Cell number is required.", kColor: UIColor.blackColor())
            return false
        }
        if (selectedPrimaryRoleId == "")
        {
            primaryroleTxtFld?.becomeFirstResponder()
            MessageAlertView().showMessage("Primary role is required.", kColor: UIColor.blackColor())
            return false
        }
        return true
    }
    
    func tapGestAction () {
        self.view.endEditing(true)
        self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        self.navigationController?.navigationBarHidden  =   true
        self.automaticallyAdjustsScrollViewInsets   =   false
        
        self.scrollView =   UIScrollView(frame: CGRectMake(0,20,self.view.frame.size.width,self.view.frame.size.height - 20))
        self.view.addSubview(self.scrollView!)
        
        let kBGView    =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        kBGView.image  =   UIImage(named: "bg.png")
        kBGView.userInteractionEnabled =   true
        kBGView.contentMode    =   .ScaleAspectFill
        kBGView.layer.masksToBounds =   true
        kBGView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ApplyMembershipVC.tapGestAction)))
        self.scrollView!.addSubview(kBGView)
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 50, 50))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(ApplyMembershipVC.backBtnTapped), forControlEvents: .TouchUpInside)
        self.scrollView!.addSubview(aButton)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 10, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.scrollView!.addSubview(kImgView)
        kImgView.center.x   =   self.scrollView!.frame.size.width / 2.0
        
        
        let descLbl         =   UILabel(frame: CGRectMake(30.0, 80, self.scrollView!.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl.text   =   "Become a"
        descLbl.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.numberOfLines  =   0
        descLbl.textAlignment  =   .Center
        self.scrollView!.addSubview(descLbl)
        
        var kStrtY : CGFloat    =   110.0
        
        
        let descLbl1         =   UILabel(frame: CGRectMake(30.0, kStrtY, self.scrollView!.frame.size.width - (2 * 30.0), 40.0 ))
        descLbl1.text   =   "Member!".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.scrollView!.addSubview(descLbl1)
        
        
        kStrtY  =   kStrtY + 60
        
        
        if (self.viewType == 2 || self.viewType == 3) {
            organizationContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
            self.scrollView?.addSubview(organizationContainer!)
            
            organizationTxtFld              =   UITextField(frame: CGRectMake(0,10,(organizationContainer?.frame.size.width )!,30))
            organizationTxtFld!.delegate    =   self
            organizationTxtFld?.placeholder =   "organization".capitalizedString
            organizationTxtFld?.textAlignment  =   .Left
            organizationTxtFld?.autocapitalizationType  =   .AllCharacters
            organizationTxtFld?.keyboardType    =   UIKeyboardType.Default
            organizationTxtFld?.textAlignment   =   .Center
            organizationTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
            organizationContainer!.addSubview(organizationTxtFld!)
            
            let kImgView1        =   UIImageView(frame: CGRectMake(0,(organizationContainer?.frame.size.height )! - 1,(organizationContainer?.frame.size.width )!,1.0))
            kImgView1.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            organizationContainer!.addSubview(kImgView1)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            if (self.viewType == 3) {
                organizationTxtFld?.text    =   self.orgName
                organizationTxtFld?.textColor  =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
                organizationTxtFld?.enabled    =   false
            }
            
        }
        firtNameContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.scrollView?.addSubview(firtNameContainer!)
        
        
        firtNameTxtFld              =   UITextField(frame: CGRectMake(0,10,(firtNameContainer?.frame.size.width )!,30))
        firtNameTxtFld!.delegate    =   self
        firtNameTxtFld?.placeholder =   "first name".capitalizedString
        firtNameTxtFld?.textAlignment  =   .Left
        firtNameTxtFld?.autocapitalizationType  =   .AllCharacters
        firtNameTxtFld?.keyboardType    =   UIKeyboardType.Default
        firtNameTxtFld?.textAlignment   =   .Center
        firtNameTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        firtNameContainer!.addSubview(firtNameTxtFld!)
        
        let kImgView1        =   UIImageView(frame: CGRectMake(0,(firtNameContainer?.frame.size.height )! - 1,(firtNameContainer?.frame.size.width )!,1.0))
        kImgView1.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        firtNameContainer!.addSubview(kImgView1)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        lastNameContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.scrollView?.addSubview(lastNameContainer!)
        
   
        lastNameTxtFld              =   UITextField(frame: CGRectMake(0,10,(lastNameContainer?.frame.size.width )!,30))
        lastNameTxtFld!.delegate    =   self
        lastNameTxtFld?.placeholder =   "LAST NAME".capitalizedString
        lastNameTxtFld?.textAlignment  =   .Left
        lastNameTxtFld?.autocapitalizationType  =   .AllCharacters
        lastNameTxtFld?.keyboardType    =   UIKeyboardType.Default
        lastNameTxtFld?.text        =   ""
        lastNameTxtFld?.textAlignment   =   .Center
        lastNameTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        lastNameContainer!.addSubview(lastNameTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,(lastNameContainer?.frame.size.height )! - 1,(lastNameContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        lastNameContainer!.addSubview(kImgView2)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        
        emailContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.scrollView?.addSubview(emailContainer!)
        

        emailTxtFld              =   UITextField(frame: CGRectMake(0,10,(emailContainer?.frame.size.width )!,30))
        emailTxtFld!.delegate    =   self
        emailTxtFld?.placeholder =   "email".capitalizedString
        emailTxtFld?.textAlignment  =   .Left
        emailTxtFld?.autocapitalizationType  =   .AllCharacters
        emailTxtFld?.keyboardType    =   UIKeyboardType.Default
        emailTxtFld?.textColor  =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        emailTxtFld?.enabled    =   false
        emailTxtFld?.text        =   email
        emailTxtFld?.textAlignment  =   .Center
        emailTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        emailContainer!.addSubview(emailTxtFld!)
        
        let kImgView5        =   UIImageView(frame: CGRectMake(0,(emailContainer?.frame.size.height )! - 1,(emailContainer?.frame.size.width )!,1.0))
        kImgView5.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        emailContainer!.addSubview(kImgView5)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        phoneContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.scrollView?.addSubview(phoneContainer!)

        
        phoneTxtFld              =   UITextField(frame: CGRectMake(0,10,(phoneContainer?.frame.size.width )!,30))
        phoneTxtFld!.delegate    =   self
        phoneTxtFld?.placeholder =   "cell number".capitalizedString
        phoneTxtFld?.textAlignment  =   .Left
        phoneTxtFld?.autocapitalizationType  =   .AllCharacters
        phoneTxtFld?.keyboardType    =   UIKeyboardType.NumbersAndPunctuation
        phoneTxtFld?.text        =   ""
        phoneTxtFld?.textAlignment  =   .Center
        phoneTxtFld?.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        phoneContainer!.addSubview(phoneTxtFld!)
        
        let kImgView6        =   UIImageView(frame: CGRectMake(0,(phoneContainer?.frame.size.height )! - 1,(phoneContainer?.frame.size.width )!,1.0))
        kImgView6.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        phoneContainer!.addSubview(kImgView6)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        
        primaryroleContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.scrollView?.addSubview(primaryroleContainer!)
        
        
        primaryroleTxtFld                 =   UITextField(frame: CGRectMake(0,10,(primaryroleContainer?.frame.size.width )!,30))
        primaryroleTxtFld!.delegate       =   self
        primaryroleTxtFld?.placeholder    =   "PRIMARY ROLE".capitalizedString
        primaryroleTxtFld?.textAlignment  =   .Left
        primaryroleTxtFld?.autocapitalizationType =   .AllCharacters
        primaryroleTxtFld?.textAlignment    =   .Center
        primaryroleTxtFld?.keyboardType   =   UIKeyboardType.Default
        primaryroleTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        primaryroleContainer!.addSubview(primaryroleTxtFld!)
        
        let kImgView7        =   UIImageView(frame: CGRectMake(0,(primaryroleContainer?.frame.size.height )! - 1,(primaryroleContainer?.frame.size.width )!,1.0))
        kImgView7.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        primaryroleContainer!.addSubview(kImgView7)
        
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        missionContainer  =   UIView(frame: CGRectMake(20, kStrtY, self.view.frame.size.width - 40, 40))
        self.scrollView?.addSubview(missionContainer!)
        
        
        missionTxtFld                 =   UITextField(frame: CGRectMake(0,10,(missionContainer?.frame.size.width )!,30))
        missionTxtFld!.delegate       =   self
        missionTxtFld?.placeholder    =   "mission (optional)".capitalizedString
        missionTxtFld?.textAlignment  =   .Left
        missionTxtFld?.autocapitalizationType =   .AllCharacters
        missionTxtFld?.keyboardType   =   UIKeyboardType.Default
        missionTxtFld?.textAlignment    =   .Center
        missionTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        missionContainer!.addSubview(missionTxtFld!)
        
        let kImgView8        =   UIImageView(frame: CGRectMake(0,(missionContainer?.frame.size.height )! - 1,(missionContainer?.frame.size.width )!,1.0))
        kImgView8.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        missionContainer!.addSubview(kImgView8)
        
        kStrtY      =   kStrtY + 40.0 + 30.0
        
        
        applyBtn     =   UIButton(type: UIButtonType.Custom)
        applyBtn!.frame   =   CGRectMake(0, kStrtY, 200, 40.0)
        applyBtn!.setImage(getButtonImage("Apply membership", kWidth: 200.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        applyBtn!.addTarget(self, action: #selector(ApplyMembershipVC.applyBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView!.addSubview(applyBtn!)
        applyBtn!.center.x  = self.view.center.x
        
        kStrtY      =   kStrtY + 40.0 + 30.0
        self.scrollView?.contentSize =   CGSizeMake(self.view.frame.size.width, kStrtY)
        
        if (self.viewType == 1 || self.viewType == 3) {
            self.firtNameTxtFld?.becomeFirstResponder()
        }
        else {
            organizationTxtFld?.becomeFirstResponder()
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBarHidden  =   true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField == primaryroleTxtFld)
        {
            let optionsView     =   SignupPrimeryRoles()
            optionsView.kTitle  =   "Select primary role"
            optionsView.prevSelected    =   NSArray(object: self.selectedPrimaryRoleId)
            self.navigationController?.pushViewController(optionsView, animated: true)
            
            optionsView.getSelectedObjectDetails(completion: { (objects) -> () in
                if (objects.count > 0)
                {
                    let specObj: SpecialityObj      =   (objects.objectAtIndex(0) as? SpecialityObj)!
                    self.selectedPrimaryRoleId      =  specObj._specialityCd
                    self.primaryroleTxtFld?.text    =   specObj._specialityDesc.uppercaseString
                    self.missionTxtFld?.becomeFirstResponder()
                }
            })
            return false
        }
        
        let rect : CGRect    =   textField.convertRect(textField.frame, toView: scrollView!)
        let kFocusPoint : CGFloat =   200
        if (rect.origin.y > kFocusPoint)
        {
            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if (textField == phoneTxtFld) {
            
            if (isPhoneValid(newString))
            {
                return  newLength <= 15
            }
            else
            {
                return false
            }
            
            if (newLength == 1)
            {
                textField.text  =   "+" + string
                return false
            }
        }
        
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (self.viewType == 2)
        {
            if (textField == organizationTxtFld)
            {
                firtNameTxtFld?.becomeFirstResponder()
                return true
            }
        }
      
        if (textField == firtNameTxtFld)
        {
            lastNameTxtFld?.becomeFirstResponder()
        }
        else if (textField == lastNameTxtFld)
        {
            phoneTxtFld?.becomeFirstResponder()
        }
        else if (textField == phoneTxtFld)
        {
            primaryroleTxtFld?.becomeFirstResponder()
        }
        
        if (textField == missionTxtFld) {
            textField.resignFirstResponder()
            self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
        }
        textField.resignFirstResponder()
        return true
    }
    
}

class SignupPrimeryRoles: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var specObjects : NSArray   =   NSArray()
    var tempObjects : NSArray   =   NSArray()
    var tbleView: UITableView?
    var kWidth : CGFloat?
    var isSingleSelection : Bool  =   true
    var selectedObjects : NSMutableArray    =   NSMutableArray()
    var prevSelected    =   NSArray()
    var kTitle: NSString    =   ""
    var kRoleID : NSString  =   ""
    var kPrimRoleId : NSString  =   ""
    var searchBar: UISearchBar!
    var completionHandler : ((NSArray) -> ())!
    
    func backBtnTapped () {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func doneBtnTapped () {
        
        completionHandler(NSArray(array: selectedObjects))
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBarHidden  =   false
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        self.navigationController?.navigationBarHidden  =   true
        self.automaticallyAdjustsScrollViewInsets   =   false
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let aBarButtonItem  =   UIBarButtonItem(title: "CANCEL", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ApplyMembershipVC.backBtnTapped))//UIBarButtonItem(customView: aButton)
        aBarButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!], forState: UIControlState.Normal)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let disabledAtt =   [NSForegroundColorAttributeName: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        
        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(SignupPrimeryRoles.doneBtnTapped))
        aBarButtonItem1.setTitleTextAttributes(disabledAtt, forState: UIControlState.Disabled)
        aBarButtonItem1.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        self.navigationItem.rightBarButtonItem?.enabled     =   false
        
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
        
        searchBar   =   UISearchBar(frame: CGRectMake(0, 64, self.view.frame.size.width, 44))
        searchBar.delegate = self
        searchBar.returnKeyType =   UIReturnKeyType.Done
        searchBar.enablesReturnKeyAutomatically =   false
        searchBar.placeholder   =   "Search"
        self.view.addSubview(searchBar)
        searchBar.hidden    =   true
        
        tbleView    =   UITableView(frame: CGRectMake(0, 64 + 44, self.view.frame.size.width, self.view.frame.size.height - 64 - 44), style: UITableViewStyle.Plain)
        tbleView?.delegate      =   self
        tbleView?.dataSource    =   self
        tbleView?.separatorStyle    =   .None
        tbleView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "LandProdCell")
        tbleView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(tbleView!)
        
        loadPrimaryRoles()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
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
        
        let predicate : NSPredicate =   NSPredicate(format: "SELF._specialityDesc contains[c] %@", argumentArray: [searchText])
        self.specObjects    =   tempObjects.filteredArrayUsingPredicate(predicate)
        
        
        self.tbleView?.reloadData()
        
    }
    
    func loadPrimaryRoles () {
        
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No detail found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        
        var indexPath   =   NSIndexPath(forRow: 0, inSection: 0)
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [""] , forKeys: [kLS_CP_UserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_registration_GetRole, parm: dict1, completion: { result , desc , code in
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
                                self.searchBar.hidden   =   false
                                let specObj : SpecialityObj   =   SpecialityObj().setDetails(kDict as! NSDictionary)
                                
                                kTempArr.addObject(specObj)
                                
                                for speObj in self.prevSelected {
                                    
                                    if ((speObj as? NSString)?.isEqualToString(specObj._specialityCd as String) == true)
                                    {
                                        self.selectedObjects.addObject(specObj)
                                        
                                    }
                                }
                            }
                            
                            self.specObjects    =   NSArray(array: kTempArr)
                            self.tempObjects    =   NSArray(array: kTempArr)
                            if(self.selectedObjects.count > 0 )
                            {
                                let kIjndnk =   self.specObjects.indexOfObject(self.selectedObjects.objectAtIndex(0))
                                indexPath   =   NSIndexPath(forRow: kIjndnk, inSection: 0)
                            }
                        }
                        
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
            if(self.selectedObjects.count > 0 )
            {
                self.tbleView?.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.None)
            }
            
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
        
        
        let specObj : SpecialityObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        
        
        if (isSingleSelection == true)
        {
            if (self.selectedObjects.containsObject(specObj))
            {
                cell.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
            else
            {
                cell.backgroundColor = UIColor.whiteColor()
            }
            
        }
        else
        {
            let imageView   =   UIImageView(frame: CGRectMake(self.view.frame.size.width - 30, 13, 15, 15))
            
            cell.addSubview(imageView)
            
            if (self.selectedObjects.containsObject(specObj))
            {
                imageView.image =   UIImage(named: "checked_checkbox.png")
            }
            else
            {
                imageView.image =   UIImage(named: "unchecked_checkbox.png")
            }
        }
        
        let descLbl        =   UILabel(frame: CGRectMake(20,0, self.view.frame.size.width - 55 , 40))
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        
        
        descLbl.text       =   specObj._specialityDesc.uppercaseString
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        let specObj : SpecialityObj   =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        
        self.selectedObjects.removeAllObjects()
        self.selectedObjects.addObject(specObj)
        tableView.reloadData()
    }
    
    func getSelectedObjectDetails (completion handler : (objects : NSArray) -> ()) {
        completionHandler   =   handler
    }
    
}