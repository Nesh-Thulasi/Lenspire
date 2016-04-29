//
//  LoginProcess.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 09/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class EmailViewController: UIViewController , UITextFieldDelegate
{
    var emailTxtFld: UITextField?
    var emailContainer : UIView?
    var nextBtn : UIButton?
    var descLbl : UILabel?
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
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 30, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.view.addSubview(kImgView)
        kImgView.center.x   =   self.view.frame.size.width / 2.0
        
        let descLbl1         =   UILabel(frame: CGRectMake(30.0, 120, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl1.text   =   "Hello!".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.view.addSubview(descLbl1)
        
        var kStart : CGFloat    =   150.0
        
        
        descLbl         =   UILabel(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl?.text   =   "Enter your email address"
        descLbl?.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        kStart  =   kStart + 50
        
        emailContainer  =   UIView(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 30.0))
        self.view.addSubview(emailContainer!)
        
        emailTxtFld                 =   UITextField(frame: CGRectMake(0,0,(emailContainer?.frame.size.width )!,(emailContainer?.frame.size.height)!))
        emailTxtFld!.delegate       =   self
        emailTxtFld?.placeholder        =   "Email"
        emailTxtFld?.textAlignment  =   .Center
        emailTxtFld?.keyboardType   =   UIKeyboardType.EmailAddress
        emailTxtFld?.autocorrectionType =   .No
        emailTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        emailContainer!.addSubview(emailTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,30.0,(emailContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        emailContainer!.addSubview(kImgView2)
        
        
        kStart  =   kStart + 40.0 + 20.0
        
        
        nextBtn     =   UIButton(type: UIButtonType.Custom)
        nextBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        nextBtn!.setImage(getButtonImage("NEXT", kWidth: 160.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        nextBtn!.addTarget(self, action: #selector(EmailViewController.nextBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextBtn!)
        nextBtn!.center.x  = self.view.center.x
        self.nextBtn!.enabled       =   false
        
        let kNum    =   NSUserDefaults.standardUserDefaults().objectForKey("kIsRemPwd")
        if ((kNum?.isKindOfClass(NSNull) == false) && (kNum?.boolValue == true) )
        {
            emailTxtFld?.text       =   NSUserDefaults.standardUserDefaults().objectForKey("kUsrName") as? String
            self.nextBtn!.enabled     =   true
        }
        
        let kLbl    =   UILabel(frame: CGRectMake(0,self.view.frame.size.height - 40 , self.view.frame.size.width , 40))
        kLbl.textColor  =   UIColor.blackColor()
        kLbl.font   =   UIFont(name: Gillsans.Default.description, size: 13)
        kLbl.textAlignment  =   .Center
        kLbl.textColor  =   UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        kLbl.text   =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        self.view.addSubview(kLbl)
        
        emailTxtFld?.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func nextBtnTapped () {
        self.view.endEditing(true)
        
    
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [emailTxtFld!.text!] , forKeys: [kLS_CP_email])
        
        ServiceWrapper(frame: self.view.frame).postToCloud(kLS_CM_registration_checkEmailAvailablilty, parm: dict, completion: { result , desc , code in
            
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                {
                    let kArray : NSArray =   result.objectForKey(kLS_CP_status) as! NSArray
                    
                    if (kArray.count > 0 && (kArray.objectAtIndex(0) as! NSString).isEqualToString(kLS_CP_success as String))
                    {
                        let kArray1 : NSArray =   result.objectForKey(kLS_CP_data) as! NSArray
                        
                        if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_ACTIVE as String))
                        {
                            let passwordView    =   PasswordViewController()
                            passwordView.email  =   (self.emailTxtFld?.text)!
                            self.navigationController?.pushViewController(passwordView, animated: true)
                        }
                        else if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_NODATA as String))
                        {
                            let kArray2 : NSArray =   result.objectForKey(kLS_CP_Page) as! NSArray
                            if (kArray2.count > 0 && (kArray2.objectAtIndex(0) as! NSString).isEqualToString("DomainPage"))
                            {
                                let ApplyMem    =   ApplyMembershipVC()
                                ApplyMem.email  =   (self.emailTxtFld?.text)!
                                ApplyMem.orgName  =   ((result.objectForKey(kLS_CP_OrgName) as! NSArray).objectAtIndex(0) as! NSString) as String
                                ApplyMem.orgId  =   ((result.objectForKey(kLS_CP_OrgId) as! NSArray).objectAtIndex(0) as! NSString) as String
                                ApplyMem.viewType   =   3
                                self.navigationController?.pushViewController(ApplyMem, animated: true)
                            }
                            else {
                                let ApplyMem    =   SelectAccountTypeViewController()
                                ApplyMem.email  =   (self.emailTxtFld?.text)!
                                self.navigationController?.pushViewController(ApplyMem, animated: true)
                            }
                        }
                        else if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_RDY_SIGN as String))
                        {
                            let passwordView    =   EnterCodeViewController()
                            passwordView.email  =   (self.emailTxtFld?.text)!
                            
                            print("UserId = " + (((result.objectForKey(kLS_CP_UserId) as! NSArray).objectAtIndex(0) as! NSString) as String) as String)
                            passwordView.userID =   ((result.objectForKey(kLS_CP_UserId) as! NSArray).objectAtIndex(0) as! NSString) as String
                            self.navigationController?.pushViewController(passwordView, animated: true)

                        }
                        else if (kArray1.count > 0 && ((kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_INACTIVE as String) || (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_PENDING as String) || (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_REJ_SIGN as String) || (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_DELETED as String)))
                        {
                            let kArray2 : NSArray =   result.objectForKey(kLS_CP_DataMsg) as! NSArray
                            
                            if (kArray2.count > 0)
                            {
                                ShowAlert((kArray2.objectAtIndex(0) as! NSString) as String)
                            }
                            else
                            {
                                if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_INACTIVE as String))
                                {
                                    ShowAlert("Account is inactive.")
                                }
                                else if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_PENDING as String))
                                {
                                    ShowAlert("Membership is waiting for administrator approval.")
                                }
                                else if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_REJ_SIGN as String))
                                {
                                    ShowAlert("Membership application is rejected by administrator.")
                                }
                                else if (kArray1.count > 0 && (kArray1.objectAtIndex(0) as! NSString).isEqualToString(kLS_Status_DELETED as String))
                                {
                                    ShowAlert("Account is deleted.")
                                }
                            }
                            
                        }
                        else {
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
                    ShowAlert(kLS_Err_Msg)
                }
            }
            else
            {
                ShowAlert(desc)
            }
        })

    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if (isValidEmail(newString))
        {
            self.nextBtn!.enabled     =   true
        }
        else
        {
            self.nextBtn!.enabled       =   false
        }
        return  newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}