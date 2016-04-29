//
//  Login.swift
//  Lenspire
//
//  Created by Thulasi on 27/07/15.
//  Copyright (c) 2015 Nesh. All rights reserved.
//

import Foundation
import UIKit

class PasswordViewController: UIViewController , UITextFieldDelegate, FeedObjDelegate {
    
    var _textFldHeight: CGFloat?
    var _textFldMargin: CGFloat?
    var _textFldsGap: CGFloat?
    var _viewWidth: CGFloat?
    var _viewHeight: CGFloat?
    var passwordTxtFld: UITextField?
    var passwordContainer : UIView?
    var chkBtn : UIButton?
    var remPwdContainer : UIView?
    var loginBtn : UIButton?
    var forgotPwdBtn : UIButton?
    var email : String  =   ""
    var descLbl : UILabel?
    
    func feedImageDownloadReqFinished () {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: "Pattern~Login")
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        aButton.addTarget(self, action: #selector(PasswordViewController.backBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        
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
        
        
        _viewWidth  =   self.view.frame.size.width
        _viewHeight =   self.view.frame.size.height
        
        _textFldHeight   =   30.0
        _textFldMargin   =   30.0
        _textFldsGap     =   20.0
        
        let kColor1     =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        let kColor2     =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        
        
        descLbl         =   UILabel(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl?.text   =   "Enter your password to login"
        descLbl?.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        kStart  =   kStart + 50
        
        passwordContainer  =   UIView(frame: CGRectMake(_textFldMargin!, kStart, _viewWidth! - (2 * _textFldMargin!), _textFldHeight!))
        self.view.addSubview(passwordContainer!)
        
        passwordTxtFld              =   UITextField(frame: CGRectMake(0,0,(passwordContainer?.frame.size.width )! -  50.0,(passwordContainer?.frame.size.height)!))
        passwordTxtFld!.delegate    =   self
        passwordTxtFld?.placeholder         =   "Password"
        passwordTxtFld?.textAlignment       =   .Center
        passwordTxtFld?.secureTextEntry     =   true
        passwordTxtFld?.font                =   UIFont(name: Gillsans.Default.description, size: 15.0)
        passwordContainer!.addSubview(passwordTxtFld!)
        
        let kImgView1        =   UIImageView(frame: CGRectMake(0,_textFldHeight!,(passwordContainer?.frame.size.width )!,1.0))
        kImgView1.backgroundColor    =   kColor1
        passwordContainer!.addSubview(kImgView1)
        
        let showHideBtn     =   UIButton(type: UIButtonType.Custom)
        showHideBtn.frame   =   CGRectMake((passwordContainer?.frame.size.width )! - 45, 0, 45, _textFldHeight!)
        showHideBtn.setTitle("SHOW", forState: UIControlState.Normal)
        showHideBtn.setTitle("HIDE", forState: UIControlState.Selected)
        showHideBtn.setTitleColor(kColor2, forState: UIControlState.Normal)
        showHideBtn.setTitleColor(kColor2, forState: UIControlState.Selected)
        showHideBtn.titleLabel?.font    =   UIFont(name: Gillsans.Default.description, size: 13.0)
        showHideBtn.addTarget(self, action: #selector(PasswordViewController.showHideBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        passwordContainer?.addSubview(showHideBtn)
        
        kStart  =   kStart + _textFldHeight!
        
        remPwdContainer     =   UIView(frame: CGRectMake(_textFldMargin!, kStart, _viewWidth! - (2 * _textFldMargin!), _textFldHeight! + 20.0))
        self.view.addSubview(remPwdContainer!)
        
        let width   =   widthForView("Remember Password", font: UIFont(name: Gillsans.Italic.description, size: 15.0)!)
        let remLbl          =   UILabel(frame: CGRectMake(((remPwdContainer?.frame.size.width)! / 2.0) - (width / 2.0) + 15, 0, width, (remPwdContainer?.frame.size.height)!))
        remLbl.text         =   "Remember Password"
        remLbl.textColor    =   kColor2
        remLbl.font         =   UIFont(name: Gillsans.Italic.description, size: 15.0)
        remLbl.textAlignment  =   .Center
        remPwdContainer!.addSubview(remLbl)
        
        chkBtn          =   UIButton(type: UIButtonType.Custom)
        chkBtn!.frame   =   CGRectMake( (((remPwdContainer?.frame.size.width)! / 2.0) - (width / 2.0)) - 30.0, 0, (remPwdContainer?.frame.size.height)!, (remPwdContainer?.frame.size.height)!)
        chkBtn!.setImage(UIImage(named:"checkbox.png"), forState: .Selected)
        chkBtn!.setImage(UIImage(named:"uncheck.png"), forState: .Normal)
        chkBtn?.userInteractionEnabled  =   false
        remPwdContainer?.addSubview(chkBtn!)
        
//        let kImgView2   =   UIImageView(frame: CGRectMake( (remPwdContainer?.frame.size.width)! - 154.0, 0,  154.0, (remPwdContainer?.frame.size.height)!))
//        kImgView2.userInteractionEnabled    =   true
//        remPwdContainer?.addSubview(kImgView2)
        
        remPwdContainer!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PasswordViewController.rememberPwdTapped)))
        
        kStart  =   kStart + _textFldHeight! + 20.0
        
        
        loginBtn     =   UIButton(type: UIButtonType.Custom)
        loginBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        loginBtn!.setImage(getButtonImage("LOGIN", kWidth: 160.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        loginBtn!.addTarget(self, action: #selector(PasswordViewController.loginBtnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginBtn!)
        loginBtn!.center.x  = self.view.center.x
        loginBtn?.enabled   =   false
        
        let kFont1  =   UIFont(name: Gillsans.Default.description, size: 15.0)
        
        let attrs = [
            NSFontAttributeName : kFont1!,
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSUnderlineStyleAttributeName : 1]
        
        let forgotPwdText   = NSMutableAttributedString(string:"Forgot Password?", attributes:attrs)
        
        kStart  =   kStart + _textFldHeight! + 10.0
        
        forgotPwdBtn     =   UIButton(type: UIButtonType.Custom)
        forgotPwdBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        forgotPwdBtn!.setAttributedTitle(forgotPwdText, forState: .Normal)
        forgotPwdBtn!.addTarget(self, action: #selector(PasswordViewController.forgotPwdBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(forgotPwdBtn!)
        forgotPwdBtn!.center.x  = self.view.frame.size.width * 0.5
        
        
        
        let kNum    =   NSUserDefaults.standardUserDefaults().objectForKey("kIsRemPwd")
        
        if ((kNum?.isKindOfClass(NSNull) == false) && (kNum?.boolValue == true) )
        {
            chkBtn!.selected        =   true
            passwordTxtFld?.text    =   NSUserDefaults.standardUserDefaults().objectForKey("kPwd") as? String
            loginBtn?.enabled       =   true
        }
        //        loginTxtFld?.text           =   "Sathya.ram@neshinc.com"
        //        passwordTxtFld?.text        =   "123456"
        
        
        let kLbl    =   UILabel(frame: CGRectMake(0,self.view.frame.size.height - 40 , self.view.frame.size.width , 40))
        kLbl.textColor  =   UIColor.blackColor()
        kLbl.font   =   UIFont(name: Gillsans.Default.description, size: 13)
        kLbl.textAlignment  =   .Center
        kLbl.textColor  =   UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        kLbl.text   =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        self.view.addSubview(kLbl)
        
        passwordTxtFld?.becomeFirstResponder()
        
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func rememberPwdTapped () {
        
        chkBtn!.selected =   !chkBtn!.selected
    }
    func showHideBtnTapped (sender: UIButton) {
        if(sender.selected)
        {
            passwordTxtFld?.secureTextEntry     =   true
        }
        else
        {
            passwordTxtFld?.secureTextEntry     =   false
        }
        passwordTxtFld?.becomeFirstResponder()
        sender.selected =   !sender.selected
        
    }
    
    func loginBtnTapped (sender: UIButton) {
        
        if(forgotPwdBtn!.selected)
        {
            MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
        }
        else
        {
            if(chkBtn!.selected)
            {
                saveUserNameAndPwd(email, kPwd: (passwordTxtFld?.text)!)
                saveRememberPwd(NSNumber(bool: true))
            }
            else
            {
                saveUserNameAndPwd("", kPwd:"")
                saveRememberPwd(NSNumber(bool: false))
            }
            
            loginAction()
        }
    }
    
    
    func forgotPwdBtnTapped () {
        self.navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    
    func loginAction () {
        self.view.endEditing(true)
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [email,passwordTxtFld!.text!,"on"] , forKeys: [kLS_CP_j_username,kLS_CP_j_password,kLS_CP_rememberme])
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
                        SharedAppController().loadHomeView()
                        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        if (newString == "") {
            self.loginBtn?.enabled  =   false
        }
        else {
            self.loginBtn?.enabled  =   true
        }
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}


