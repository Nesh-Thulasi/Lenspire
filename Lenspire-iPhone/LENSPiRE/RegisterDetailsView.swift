//
//  RegisterDetailsView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 23/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class RegisterDetailsView: UIViewController, UITextFieldDelegate, UserDetailsObjDelegate
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
    var primaryroleTxtFld: UITextField?
    var primaryroleContainer : UIView?

    var selectedPrimaryRoleId : NSString    =   ""
    var applyBtn : UIButton?
    var email : String  =   ""
    var userId : String =   ""
    var jAuth : String  =   ""
    var password : String   =   ""
    
    var orgName : String  =   ""
    var orgId : String  =   ""
    var viewType : Int  =   1
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }

    
    func applyBtnTapped () {
        
        self.view.endEditing(true)
        
        if (validateFields()){
            let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
            GetAppDelegate().window?.addSubview(maskView)
            
            let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [ userId,emailTxtFld!.text!,firtNameTxtFld!.text!,lastNameTxtFld!.text!,selectedPrimaryRoleId,jAuth, "2"] , forKeys: [kLS_CP_userId,kLS_CP_email,kLS_CP_firstName,kLS_CP_lastName,kLS_CP_speciality,kLS_CP_jauthId,kLS_CP_step])
            
            ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_registration_saveUserDetails, parm: dict, completion: { result , desc , code in
                maskView.removeFromSuperview()
                if ( code == 99)
                {
                    print("\(result)")
                    if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                    {
                        
                        if (result.objectForKey(kLS_CP_status) as! NSString).isEqualToString(kLS_CP_success as String)
                        {
                            let passwordView    =   RegisterPlanView()
                            passwordView.email  =   self.email
                            passwordView.userId =   self.userId
                            passwordView.jAuth  =   self.jAuth
                            passwordView.password   =   self.password
                            self.navigationController?.pushViewController(passwordView, animated: true)
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
        kBGView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RegisterDetailsView.tapGestAction)))
        self.scrollView!.addSubview(kBGView)
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 50, 50))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(RegisterDetailsView.backBtnTapped), forControlEvents: .TouchUpInside)
        self.scrollView!.addSubview(aButton)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 10, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.scrollView!.addSubview(kImgView)
        kImgView.center.x   =   self.scrollView!.frame.size.width / 2.0
        
        
        let descLbl1    =   UILabel(frame: CGRectMake(30.0, 120, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl1.text   =   "ALMOST THERE!!".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.scrollView!.addSubview(descLbl1)
        
        var kStrtY : CGFloat    =   150.0
        
        let str =   "Now that we've got you secure. Let's make sure we have your info correct"
        
        let height = heightForView(str, font: UIFont(name: Gillsans.Default.description, size: 15.0)!, width: self.view.frame.size.width - (2 * 30.0))
        
        let descLbl         =   UILabel(frame: CGRectMake(30.0, kStrtY, self.view.frame.size.width - (2 * 30.0), height ))
        descLbl.text   =   str
        descLbl.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.numberOfLines  =   0
        descLbl.textAlignment  =   .Center
        self.scrollView!.addSubview(descLbl)
        
        kStrtY  =   kStrtY + height + 20
        
        
        
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
        
        kStrtY      =   kStrtY + 40.0 + 30.0
        
        applyBtn     =   UIButton(type: UIButtonType.Custom)
        applyBtn!.frame   =   CGRectMake(0, kStrtY, 160, 40.0)
        applyBtn!.setImage(getButtonImage("next", kWidth: 160.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        applyBtn!.addTarget(self, action: #selector(RegisterDetailsView.applyBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView!.addSubview(applyBtn!)
        applyBtn!.center.x  = self.view.center.x
        
        kStrtY      =   kStrtY + 40.0 + 30.0
        self.scrollView?.contentSize =   CGSizeMake(self.view.frame.size.width, kStrtY)
        
        loadProfile()
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
    
    func loadProfile () {
       
         let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [jAuth] , forKeys: [kLS_CP_userId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_registration_getUserDetails, parm: dict1, completion: { result , desc , code in

            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kString: NSString  =   result.objectForKey(kLS_CP_status) as! NSString
                    
                    if (kString.isKindOfClass(NSNull) == false && kString.isKindOfClass(NSString) == true && kString.isEqualToString(kLS_CP_success as String))
                    {
                        let kArr: AnyObject?   =   result .objectForKey(kLS_CP_result)
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSDictionary) == true)
                        {
                            isSuccess   =   true
                            let userDetails : UserDetailsObj    =   UserDetailsObj().setDetails(kArr  as! NSDictionary, kDelegate: self as UserDetailsObjDelegate)
                            
                            self.firtNameTxtFld?.text   =   userDetails._firstName as String
                            self.lastNameTxtFld?.text   =   userDetails._lastName as String
                            self.emailTxtFld?.text      =   userDetails._email as String
                            self.primaryroleTxtFld?.text    =   userDetails._specialitydesc as String
                            self.selectedPrimaryRoleId  =   userDetails._specialityCd
                            
                        }
                    }
                }
                if (isSuccess == false)
                {
                    self.navigationController?.popViewControllerAnimated(true)
                    ShowAlert(kLS_Err_Msg)
                }
            }
            else
            {
                self.navigationController?.popViewControllerAnimated(true)
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
    
    func ImageDownloadReqFinished () {
        
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
            primaryroleTxtFld?.becomeFirstResponder()
            self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}