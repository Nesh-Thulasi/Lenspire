//
//  LoginProcess.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 09/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class EnterCodeViewController: UIViewController , UITextFieldDelegate
{
    var codeTxtFld: UITextField?
    var codeContainer : UIView?
    var nextBtn : UIButton?
    var resendBtn : UIButton?
    var descLbl : UILabel?
    var email : String  =   ""
    var code : String   =   ""
    var isFromURL : Bool    =   false
    var userID : String =   ""
    
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
        aButton.addTarget(self, action: #selector(EnterCodeViewController.backBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 30, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.view.addSubview(kImgView)
        kImgView.center.x   =   self.view.frame.size.width / 2.0
        
        let descLbl1    =   UILabel(frame: CGRectMake(30.0, 120, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl1.text   =   "Hey!!".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.view.addSubview(descLbl1)
        
        var kStart : CGFloat    =   150.0
        
        let str =   "Please enter your signup verification code which is sent to your Email"
        
        let height = heightForView(str, font: UIFont(name: Gillsans.Default.description, size: 15.0)!, width: self.view.frame.size.width - (2 * 30.0))
        
        descLbl         =   UILabel(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), height ))
        descLbl?.text   =   str
        descLbl?.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        kStart  =   kStart + height + 20
        
        codeContainer  =   UIView(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 30.0))
        self.view.addSubview(codeContainer!)
        
        codeTxtFld                 =   UITextField(frame: CGRectMake(0,0,(codeContainer?.frame.size.width )!,(codeContainer?.frame.size.height)!))
        codeTxtFld!.delegate       =   self
        codeTxtFld?.placeholder        =   "Invite Code"
        codeTxtFld?.textAlignment  =   .Center
        codeTxtFld?.keyboardType   =   UIKeyboardType.EmailAddress
        codeTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        codeContainer!.addSubview(codeTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,30.0,(codeContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        codeContainer!.addSubview(kImgView2)
        
        
        kStart  =   kStart + 40.0 + 20.0
        
        
        nextBtn     =   UIButton(type: UIButtonType.Custom)
        nextBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        nextBtn!.setImage(getButtonImage("VERIFY", kWidth: 160.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        nextBtn!.addTarget(self, action: #selector(EnterCodeViewController.nextBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextBtn!)
        nextBtn!.center.x  = self.view.center.x
        self.nextBtn!.enabled       =   false
        
        let kFont1  =   UIFont(name: Gillsans.Default.description, size: 15.0)
        
        let attrs = [
            NSFontAttributeName : kFont1!,
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSUnderlineStyleAttributeName : 1]
        
        let forgotPwdText   = NSMutableAttributedString(string:"Resend verification", attributes:attrs)
        
        kStart  =   kStart + 30.0 + 10.0
        
        resendBtn     =   UIButton(type: UIButtonType.Custom)
        resendBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        resendBtn!.setAttributedTitle(forgotPwdText, forState: .Normal)
        resendBtn!.addTarget(self, action: #selector(EnterCodeViewController.resendBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(resendBtn!)
        resendBtn!.center.x  = self.view.frame.size.width * 0.5
        
        let kLbl    =   UILabel(frame: CGRectMake(0,self.view.frame.size.height - 40 , self.view.frame.size.width , 40))
        kLbl.textColor  =   UIColor.blackColor()
        kLbl.font   =   UIFont(name: Gillsans.Default.description, size: 13)
        kLbl.textAlignment  =   .Center
        kLbl.textColor  =   UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        kLbl.text   =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        self.view.addSubview(kLbl)
        
        if (isFromURL == true) {
            self.codeTxtFld?.text   =   code
            self.nextBtn?.enabled   =   true
            nextBtnTapped()
        }
        else {
            codeTxtFld?.becomeFirstResponder()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func resendBtnTapped ()
    {
        self.view.endEditing(true)
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [ userID,email] , forKeys: [kLS_CP_userId,kLS_CP_email])
       
        
        ServiceWrapper(frame: self.view.frame).postToCloud(kLS_CM_registration_resendIniviteCode, parm: dict, completion: { result , desc , code in
            
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                {
                    if (result.objectForKey(kLS_CP_status) as! NSString).isEqualToString(kLS_CP_success as String)
                    {
                        MessageAlertView().showMessage("Your verification code is resent. Check your inbox.", kColor : kLS_SuccessMsgColor)
                    }
                    else
                    {
                        MessageAlertView().showMessage("Resending verification code is failed.", kColor : kLS_FailedMsgColor)
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
    
    func backBtnTapped () {
        if (isFromURL == true) {
            SharedAppController().loadStartupView()
        }
        else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func nextBtnTapped ()
    {
        self.view.endEditing(true)
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [ userID,codeTxtFld!.text!] , forKeys: [kLS_CP_userId,kLS_CP_invitationCode])
         print(dict)
        
        ServiceWrapper(frame: self.view.frame).postToCloud(kLS_CM_registration_chkInvitationCode, parm: dict, completion: { result , desc , code in
            
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                {
                    
                    if (result.objectForKey(kLS_CP_status) as! NSString).isEqualToString(kLS_CP_success as String)
                    {
                        let passwordView    =   RegisterPasswordView()
                        passwordView.email  =   self.email
                        passwordView.userId =   self.userID
                        passwordView.jAuth  =   (result.objectForKey(kLS_CP_data) as! NSString).componentsSeparatedByString("ju_auth=").last!
                        self.navigationController?.pushViewController(passwordView, animated: true)
                    }
                    else if (result.objectForKey(kLS_CP_status) as! NSString).isEqualToString("invalid")
                    {
                        MessageAlertView().showMessage("The invite code is invalid.", kColor : kLS_FailedMsgColor)
                    }
                    else
                    {
                        MessageAlertView().showMessage("The invite code does not match the code sent to you.", kColor : kLS_FailedMsgColor)
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
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        
        if (newString.characters.count >= 6) {
            self.nextBtn?.enabled   =   true
        }
        else {
            self.nextBtn?.enabled   =   false
        }
        return  newLength <= 6
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}