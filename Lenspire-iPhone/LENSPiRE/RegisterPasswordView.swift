//
//  RegisterPasswordView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 23/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation


class RegisterPasswordView: UIViewController , UITextFieldDelegate
{
    var passwordTxtFld      : UITextField?
    var passwordContainer   : UIView?
    var confrimPasswordTxtFld: UITextField?
    var confirmPasswordContainer : UIView?
    var nextBtn : UIButton?
    var resendBtn : UIButton?
    var descLbl : UILabel?
    var email : String  =   ""
    var userId : String =   ""
    var jAuth : String  =   ""
    
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
        aButton.addTarget(self, action: #selector(RegisterPasswordView.backBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 30, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.view.addSubview(kImgView)
        kImgView.center.x   =   self.view.frame.size.width / 2.0
        
        let descLbl1    =   UILabel(frame: CGRectMake(30.0, 120, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl1.text   =   "You're in!!".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.view.addSubview(descLbl1)
        
        var kStart : CGFloat    =   150.0
        
        let str =   "First up, Let's get you secure. Choose a Lenspirational password (minimum 6 Characters, No Spaces)"
        
        let height = heightForView(str, font: UIFont(name: Gillsans.Default.description, size: 15.0)!, width: self.view.frame.size.width - (2 * 30.0))
        
        descLbl         =   UILabel(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), height ))
        descLbl?.text   =   str
        descLbl?.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        kStart  =   kStart + height + 20
        
        passwordContainer  =   UIView(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 30.0))
        self.view.addSubview(passwordContainer!)
        
        passwordTxtFld                 =   UITextField(frame: CGRectMake(0,0,(passwordContainer?.frame.size.width )!,(passwordContainer?.frame.size.height)!))
        passwordTxtFld!.delegate       =   self
        passwordTxtFld?.placeholder        =   "Set Password"
        passwordTxtFld?.textAlignment  =   .Center
        passwordTxtFld?.secureTextEntry =   true
        passwordTxtFld?.keyboardType   =   UIKeyboardType.EmailAddress
        passwordTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        passwordContainer!.addSubview(passwordTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,30.0,(passwordContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        passwordContainer!.addSubview(kImgView2)
        
        kStart  =   kStart + 30.0 + 20
        
        confirmPasswordContainer  =   UIView(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 30.0))
        self.view.addSubview(confirmPasswordContainer!)
        
        confrimPasswordTxtFld                 =   UITextField(frame: CGRectMake(0,0,(confirmPasswordContainer?.frame.size.width )!,(confirmPasswordContainer?.frame.size.height)!))
        confrimPasswordTxtFld!.delegate       =   self
        confrimPasswordTxtFld?.placeholder        =   "Let's make sure one more time"
        confrimPasswordTxtFld?.textAlignment  =   .Center
        confrimPasswordTxtFld?.secureTextEntry  =   true
        confrimPasswordTxtFld?.keyboardType   =   UIKeyboardType.EmailAddress
        confrimPasswordTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        confirmPasswordContainer!.addSubview(confrimPasswordTxtFld!)
        
        let kImgView3        =   UIImageView(frame: CGRectMake(0,30.0,(confirmPasswordContainer?.frame.size.width )!,1.0))
        kImgView3.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        confirmPasswordContainer!.addSubview(kImgView3)
        
        
        kStart  =   kStart + 40.0 + 20.0
        
        
        nextBtn     =   UIButton(type: UIButtonType.Custom)
        nextBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        nextBtn!.setImage(getButtonImage("WHAT'S NEXT", kWidth: 160.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        nextBtn!.addTarget(self, action: #selector(RegisterPasswordView.nextBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextBtn!)
        nextBtn!.center.x  = self.view.center.x
        self.nextBtn!.enabled       =   false
        

        
        let kLbl    =   UILabel(frame: CGRectMake(0,self.view.frame.size.height - 40 , self.view.frame.size.width , 40))
        kLbl.textColor  =   UIColor.blackColor()
        kLbl.font   =   UIFont(name: Gillsans.Default.description, size: 13)
        kLbl.textAlignment  =   .Center
        kLbl.textColor  =   UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        kLbl.text   =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        self.view.addSubview(kLbl)
        
        passwordTxtFld?.becomeFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func nextBtnTapped ()
    {
        if (passwordTxtFld?.text != confrimPasswordTxtFld?.text) {
            ShowAlert("Passwords doesn't match.")
            confrimPasswordTxtFld?.becomeFirstResponder()
            return
        }
        self.view.endEditing(true)
        
        let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
        
        let dict: NSMutableDictionary   =   NSMutableDictionary(objects: [ userId,passwordTxtFld!.text!,jAuth, "1"] , forKeys: [kLS_CP_userId,kLS_CP_password,kLS_CP_jauthId,kLS_CP_step])
        
        ServiceWrapper(frame: self.view.frame).postToCloud(kLS_CM_registration_saveUserInfo, parm: dict, completion: { result , desc , code in
            
            maskView.removeFromSuperview()
            if ( code == 99)
            {
                print("\(result)")
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0)
                {
                    
                    if (result.objectForKey(kLS_CP_status) as! NSString).isEqualToString(kLS_CP_success as String)
                    {
                        let passwordView    =   RegisterDetailsView()
                        passwordView.email  =   self.email
                        passwordView.userId =   self.userId
                        passwordView.jAuth  =   self.jAuth
                        passwordView.password   =   self.passwordTxtFld!.text!
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
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        if (textField == self.passwordTxtFld) {
            if (newString.characters.count >= 6) {
                self.nextBtn?.enabled   =   true
            }
            else {
                self.nextBtn?.enabled   =   false
            }
        }
        return  newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == passwordTxtFld)
        {
            confrimPasswordTxtFld?.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        return true
    }
}