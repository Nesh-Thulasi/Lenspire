//
//  SelectAccountTypeViewController.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 21/03/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class SelectAccountTypeViewController: UIViewController
{
 
    var descLbl : UILabel?
    var email : String  =   ""
    var individualButton : UIButton!
    var organizationButton : UIButton!
    
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
        aButton.addTarget(self, action: #selector(SelectAccountTypeViewController.backBtnTapped), forControlEvents: .TouchUpInside)
        self.view.addSubview(aButton)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 30, 70, 70))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        self.view.addSubview(kImgView)
        kImgView.center.x   =   self.view.frame.size.width / 2.0
        
        
        descLbl         =   UILabel(frame: CGRectMake(30.0, 100, self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl?.text   =   "Select"
        descLbl?.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl?.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl?.numberOfLines  =   0
        descLbl?.textAlignment  =   .Center
        self.view.addSubview(descLbl!)
        
        var kStart : CGFloat    =   130.0
        
        
        let descLbl1         =   UILabel(frame: CGRectMake(30.0, kStart, self.view.frame.size.width - (2 * 30.0), 40.0 ))
        descLbl1.text   =   "Account Type".uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.863, green: 0.882, blue: 0.0, alpha: 1)
        descLbl1.font   =   UIFont(name: Gillsans.Default.description, size: 26.0)
        descLbl1.numberOfLines  =   0
        descLbl1.textAlignment  =   .Center
        descLbl1.shadowColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl1.shadowOffset   =   CGSizeMake(2 , -0.5)
        self.view.addSubview(descLbl1)

        
        kStart  =   kStart + 60
        
        individualButton     =   UIButton(frame: CGRectMake(0, kStart, 80, 80))
        individualButton.setImage(UIImage(named: "individual.png"), forState: .Normal)
        individualButton.setImage(UIImage(named: "individual-selected.png"), forState: .Selected)
        individualButton.addTarget(self, action: #selector(SelectAccountTypeViewController.individualBtnTapped(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(individualButton)
        individualButton.center.x   =   self.view.frame.size.width / 2.0
        kStart  =   kStart + 80
        
        let descLbl2         =   UILabel(frame: CGRectMake(30.0, kStart , self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl2.text   =   "Individual"
        descLbl2.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl2.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl2.numberOfLines  =   0
        descLbl2.textAlignment  =   .Center
        self.view.addSubview(descLbl2)
        
        
        kStart  =   kStart + 40
        
        let kImgView2        =   UIImageView(frame: CGRectMake(80.0, kStart + 15 , (self.view.frame.size.width / 2.0) -  80.0 - 20.0, 1.0 ))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        self.view.addSubview(kImgView2)
        
        let kImgView3        =   UIImageView(frame: CGRectMake((self.view.frame.size.width / 2.0) + 20.0, kStart + 15 , (self.view.frame.size.width / 2.0) -  80.0 - 20.0, 1.0 ))
        kImgView3.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        self.view.addSubview(kImgView3)
        
        let descLbl3         =   UILabel(frame: CGRectMake(30.0, kStart , self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl3.text   =   "or"
        descLbl3.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl3.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl3.numberOfLines  =   0
        descLbl3.textAlignment  =   .Center
        self.view.addSubview(descLbl3)
        
        kStart  =   kStart + 40
        
        organizationButton     =   UIButton(frame: CGRectMake(0, kStart, 80, 80))
        organizationButton.setImage(UIImage(named: "group.png"), forState: .Normal)
        organizationButton.setImage(UIImage(named: "group-selected.png"), forState: .Selected)
        organizationButton.addTarget(self, action: #selector(SelectAccountTypeViewController.organizationBtnTapped(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(organizationButton)
        organizationButton.center.x   =   self.view.frame.size.width / 2.0
        kStart  =   kStart + 80
        
        let descLbl4         =   UILabel(frame: CGRectMake(30.0, kStart , self.view.frame.size.width - (2 * 30.0), 30.0 ))
        descLbl4.text   =   "Organization"
        descLbl4.textColor  =   UIColor.blackColor()//UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        descLbl4.font   =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl4.numberOfLines  =   0
        descLbl4.textAlignment  =   .Center
        self.view.addSubview(descLbl4)
        
        
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
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func individualBtnTapped (sender : UIButton) {
        sender.selected =   true
        organizationButton.selected =   false
        let ApplyMem    =   ApplyMembershipVC()
        ApplyMem.email  =   self.email
        ApplyMem.viewType   =   1
        self.navigationController?.pushViewController(ApplyMem, animated: true)
    
    }
    func organizationBtnTapped (sender : UIButton) {
        sender.selected =   true
        individualButton.selected =   false
        let ApplyMem    =   ApplyMembershipVC()
        ApplyMem.email  =   self.email
        ApplyMem.viewType   =   2
        self.navigationController?.pushViewController(ApplyMem, animated: true)
    }
}