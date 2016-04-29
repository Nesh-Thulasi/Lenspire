//
//  Login.swift
//  Lenspire
//
//  Created by Thulasi on 27/07/15.
//  Copyright (c) 2015 Nesh. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController , UITextFieldDelegate {
    
    var _textFldHeight: CGFloat?
    var _textFldMargin: CGFloat?
    var _textFldsGap: CGFloat?
    var _viewWidth: CGFloat?
    var _viewHeight: CGFloat?
    var loginTxtFld: UITextField?
    var loginContainer : UIView?
    var descLbl : UILabel?
    var loginBtn : UIButton?
    
    
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
        aButton.addTarget(self, action: #selector(ForgotPasswordViewController.backBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 30, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.view.addSubview(kImgView)
        kImgView.center.x   =   self.view.frame.size.width / 2.0
        
        let descLbl1         =   UILabel(frame: CGRectMake(30.0, 120, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl1.text   =   "Forgot password?".uppercaseString
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
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let str =   "Enter your email address below, and we will send you an email with instructions and a link to reset your password."
        
        let height = heightForView(str, font: UIFont(name: Gillsans.Default.description, size: 15.0)!, width: _viewWidth! - (2 * _textFldMargin!))
        
        descLbl         =   UILabel(frame: CGRectMake(_textFldMargin!, kStart, _viewWidth! - (2 * _textFldMargin!), height))
        descLbl?.text   =   str
        descLbl?.textColor  =   UIColor.blackColor()
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        kStart  =   kStart + height + 20.0
        
        loginContainer  =   UIView(frame: CGRectMake(_textFldMargin!, kStart, _viewWidth! - (2 * _textFldMargin!), _textFldHeight!))
        self.view.addSubview(loginContainer!)
        
        loginTxtFld                 =   UITextField(frame: CGRectMake(0,0,(loginContainer?.frame.size.width )!,(loginContainer?.frame.size.height)!))
        loginTxtFld!.delegate       =   self
        loginTxtFld?.placeholder    =   "Email"
        loginTxtFld?.textAlignment  =   .Center
        loginTxtFld?.keyboardType   =   UIKeyboardType.EmailAddress
        loginTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        loginContainer!.addSubview(loginTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,_textFldHeight!,(loginContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   kColor1
        loginContainer!.addSubview(kImgView2)
        
        kStart  =   kStart + 40 + 20
        
        
        
        loginBtn     =   UIButton(type: UIButtonType.Custom)
        loginBtn!.frame   =   CGRectMake(0, kStart, 160, 40.0)
        loginBtn!.setImage(getButtonImage("SUBMIT", kWidth: 160.0 * 2.0, kHeight: 80.0, kFont: UIFont(name: Gillsans.Default.description, size: 38.0)!), forState: .Normal)
        loginBtn!.addTarget(self, action: #selector(ForgotPasswordViewController.submitBtnTapped), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginBtn!)
        loginBtn!.center.x  = self.view.center.x
        
        let kNum    =   NSUserDefaults.standardUserDefaults().objectForKey("kIsRemPwd")
        
        if ((kNum?.isKindOfClass(NSNull) == false) && (kNum?.boolValue == true) )
        {
            loginTxtFld?.text       =   NSUserDefaults.standardUserDefaults().objectForKey("kUsrName") as? String
        }
        
        
        let kLbl    =   UILabel(frame: CGRectMake(0,self.view.frame.size.height - 40 , self.view.frame.size.width , 40))
        kLbl.textColor  =   UIColor.blackColor()
        kLbl.font   =   UIFont(name: Gillsans.Default.description, size: 13)
        kLbl.textAlignment  =   .Center
        kLbl.textColor  =   UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        kLbl.text   =   "LENSPiRE version " + ((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String)
        self.view.addSubview(kLbl)
        
        
        loginTxtFld?.becomeFirstResponder()
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func submitBtnTapped () {
        
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
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}


