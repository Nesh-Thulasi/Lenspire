//
//  Profile.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 30/11/15.
//  Copyright © 2015 nesh. All rights reserved.
//

import Foundation

class ProfileVC: UIViewController, TLSSegmentViewDelegate, UserDetailsObjDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate , OptionsControllerDelegate{

    var kArtistID : String      =   ""
    var kArtistName : String    =   ""
    var _textFldHeight: CGFloat?
    var _textFldMargin: CGFloat?
    var _textFldsGap: CGFloat?
    var _viewWidth: CGFloat?
    var _viewHeight: CGFloat?
    
    var isArtistEditable : Bool =   false
    
    var selectedTypeView: Int = 1
    
    var contentView : UIView    =   UIView()
    var segmentedControl: TLSSegmentView!
    var seletionBar: UIView     =   UIView()
    var scrollView: UIScrollView?
    var profImg : UIImageView   =   UIImageView()
    var profHeaderImgView : UIImageView =   UIImageView()
    var profHeadertransView : UIImageView =   UIImageView()
    var isEditMode : Bool   =   false
    let picker = UIImagePickerController()
    var profileImgURL : NSString        =   ""
    var selectedPrimaryRoleId : NSString    =   ""
    var selectedAddRoleIDs : NSString    =   ""
    var selectedAddSpecIDs   : NSString     =   ""
    var selectedCountryId : NSString    =   ""
    var selectedImgName : NSString      =   ""
    var selectedImageSize : NSString    =   ""
    var profImgActivity : UIActivityIndicatorView?
    var userNameLbl : UILabel?
    var userSpecLbl : UILabel?
    var socialContainer : UIView?
    var profEditIcon : UIImageView?
    var firstNameTxtFld: UITextField?
    var firstNameContainer : UIView?
    var lastNameTxtFld: UITextField?
    var lastNameContainer : UIView?
    
    var emailTxtFld: UITextField?
    var emailContainer : UIView?
    var phoneTxtFld : UITextField?
    var phoneContainer : UIView?
    var primaryroleTxtFld: UITextField?
    var primaryroleContainer : UIView?
    var personalMottoTxtFld: UITextField?
    var personalMottoContainer : UIView?
    var websiteTxtFld: UITextField?
    var websiteContainer : UIView?
    var countryTxtFld: UITextField?
    var countryContainer : UIView?
    var cityTxtFld: UITextField?
    var cityContainer : UIView?
    var zipTxtFld: UITextField?
    var zipContainer : UIView?
    var facebookTxtFld: UITextField?
    var facebookContainer : UIView?
    var twitterTxtFld: UITextField?
    var twitterContainer : UIView?
    var instagramTxtFld: UITextField?
    var instagramContainer : UIView?
    
    var agencynameTxtFld: UITextField?
    var agencynameContainer : UIView?
    var agentTxtFld: UITextField?
    var agentContainer : UIView?
    var agentemailTxtFld: UITextField?
    var agentemailContainer : UIView?
    var genderContainer : UIView?
    var genderSegment : UISegmentedControl?
    var addRoleContainer : UIView?
    var addRoleTxtField : UITextField?
    var addSpecContainer : UIView?
    var addSpecTxtFld : UITextField?
    
    
    var heightContainer : UIView?
    var heightTxtFld : UITextField?
    var pantsizeContainer : UIView?
    var pantsizeTxtFld : UITextField?
    var bustContainer : UIView?
    var bustTxtFld : UITextField?
    var waistContainer : UIView?
    var waistTxtFld : UITextField?
    var hipsContainer : UIView?
    var hipsTxtFld : UITextField?
    var shoeContainer : UIView?
    var shoeTxtFld : UITextField?
    var hairContainer : UIView?
    var hairTxtFld : UITextField?
    var eyeContainer : UIView?
    var eyeTxtFld : UITextField?
    
    var extraViewContainer : UIView = UIView()
    var kScrollView =   UIScrollView()
    var extraContStrtY : CGFloat    =   0.0
    
    var userDetails : UserDetailsObj! //   =   UserDetailsObj().setDetails(NSDictionary(), kDelegate: self as! UserDetailsObjDelegate)
    var menuEditBtn : UIButton?
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
     func keyboardWillHide(notification: NSNotification) {
        self.scrollView?.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        _viewWidth  =   self.view.frame.size.width
        _viewHeight =   self.view.frame.size.height
        
        _textFldHeight   =   30.0
        _textFldMargin   =   80.0
        _textFldsGap     =   15.0
        
        
        if (kArtistID == "")
        {
            let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
            aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
            aButton.addTarget(self, action: #selector(ProfileVC.menuBtnTapped), forControlEvents: .TouchUpInside)
            
            
            let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
            self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
            
            
            menuEditBtn    =   UIButton(frame: CGRectMake(0, 0, 58, 25))
            menuEditBtn!.setImage(UIImage(named: "edit.png"), forState: .Normal)
            menuEditBtn!.setImage(UIImage(named: "save.png"), forState: .Selected)
            menuEditBtn!.addTarget(self, action: #selector(ProfileVC.menuEditBtnTapped(_:)), forControlEvents: .TouchUpInside)
            let aBarButtonItem1  =   UIBarButtonItem(customView: menuEditBtn!)
            self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
            
            let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
            kImgView.image  =   UIImage(named: "lenspire-logo.png")
            kImgView.userInteractionEnabled =   true
            kImgView.contentMode    =   .ScaleAspectFit
            kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileVC.headBtnTapped)))
            
            self.navigationItem.titleView   =   kImgView
            
        }
        else
        {
            let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
            aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
            aButton.addTarget(self, action: #selector(ProfileVC.backBtnTapped), forControlEvents: .TouchUpInside)
            
            let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
            self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
            
            
            let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
            let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
            descLbl.text       =   kArtistName.uppercaseString
            descLbl.textColor  =   UIColor.blackColor()
            descLbl.numberOfLines   =   0
            descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
            descLbl.textAlignment  =   .Center
            kTempView.addSubview(descLbl)
            descLbl.center.x    =   1
            descLbl.center.y    =   22
            self.navigationItem.titleView   =   kTempView
            
            if (isArtistEditable){
                menuEditBtn    =   UIButton(frame: CGRectMake(0, 0, 76, 33))
                menuEditBtn!.setImage(UIImage(named: "edit.png"), forState: .Normal)
                menuEditBtn!.setImage(UIImage(named: "save.png"), forState: .Selected)
                menuEditBtn!.addTarget(self, action: #selector(ProfileVC.menuEditBtnTapped(_:)), forControlEvents: .TouchUpInside)
                let aBarButtonItem1  =   UIBarButtonItem(customView: menuEditBtn!)
                self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
            }
            
           
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileVC.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
        self.navigationItem.rightBarButtonItem?.customView?.hidden  =   true
        
        loadProfile()
    }
    func profImageEditTapped () {
        
        if (isEditMode == true)
        {
            // 1
            let optionMenu = UIAlertController(title: nil, message: "Select", preferredStyle: .ActionSheet)
            
            // 2
            let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.picker.allowsEditing = true
                self.picker.sourceType = UIImagePickerControllerSourceType.Camera
                self.picker.cameraCaptureMode = .Photo
                self.picker.modalPresentationStyle = .FullScreen
                self.picker.delegate    =   self
                self.presentViewController(self.picker, animated: true, completion: nil)
                
            })
            let libraryAction = UIAlertAction(title: "Photo Library", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.picker.allowsEditing = true //2
                self.picker.sourceType = .PhotoLibrary //3
                self.picker.delegate    =   self
                
                self.presentViewController(self.picker, animated: true, completion: nil)//4
            })
            
            //
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
                (alert: UIAlertAction!) -> Void in
            })
            
            
            // 4
            optionMenu.addAction(cameraAction)
            optionMenu.addAction(libraryAction)
            optionMenu.addAction(cancelAction)
            
            // 5
            self.presentViewController(optionMenu, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage //2
        
        let mediaType   =   info[UIImagePickerControllerMediaType] as! NSString
        if (mediaType.isEqualToString("public.image")) {
            let kProfImg =    CommonMethods.squareImageWithImage(chosenImage, scaledToSize: CGSize(width: 700, height: 700))
            
            print("====JPEG===\(Double(UIImageJPEGRepresentation(kProfImg, 0.0)!.length)/1024.0)")
            if (false)// (Int(UIImageJPEGRepresentation(kProfImg, 0.0)!.length) + Int(GetAppDelegate().loginDetails!._spaceUsed as String)!) > GetAppDelegate().loginDetails!._storageSpaceBytes)
            {
                MessageAlertView().showMessage("You have not enough storage. Please upgrade your plan.", kColor : kLS_FailedMsgColor)
            }
            else
            {
                let imgName     =   NSUUID().UUIDString.stringByReplacingOccurrencesOfString("-", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                
                let paths   = NSSearchPathForDirectoriesInDomains(
                    .DocumentDirectory, .UserDomainMask, true)
                let imgPath = (paths[0] as String).stringByAppendingString("/tempFile")
                
                UIImageJPEGRepresentation(kProfImg, 0.0)!.writeToFile(imgPath, atomically: true)
                let fileUrl = NSURL(fileURLWithPath: imgPath)
                
                
                let uploadReq       =   AWSS3TransferManagerUploadRequest()
                uploadReq.key       =   "\(imgName).jpg"
                uploadReq.body      =   fileUrl
                uploadReq.bucket    =   S3Bucket_lens_dev_s3_150_150
                uploadReq.contentType   =   "image/jpg"
                
                let transferManager =   AWSS3TransferManager.defaultS3TransferManager()
                
                print("UPLOADING =================== https://s3-us-west-2.amazonaws.com/lens-dev-s3-150-150/\(imgName).jpg")
                
                profImgActivity!.startAnimating()
                
                transferManager.upload(uploadReq).continueWithBlock ({ (task) -> AnyObject! in
                    dispatch_async(dispatch_get_main_queue()) {
                        self.profImgActivity?.stopAnimating()
                        
                        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
                        {
                            print("FILE AVAILABLE")
                            let success: Bool
                            do {
                                try NSFileManager.defaultManager().removeItemAtPath(imgPath)
                                success = true
                            } catch _ {
                                success = false
                            }
                            if (success == true)
                            {
                                print("FILE DELETED")
                            }
                            else
                            {
                                print("Could not delete file -:")
                            }
                        }
                        else
                        {
                            print("FILE NOT AVAILABLE")
                        }
                        
                        if let error    =   task.error {
                            print(error)
                        }
                        else
                        {
                            self.profImg.image  =   kProfImg
                            self.profHeaderImgView.image  =   kProfImg
                            self.profileImgURL  =   "https://s3-us-west-2.amazonaws.com/lens-dev-s3-150-150/\(imgName).jpg"
                            self.selectedImgName    =   "\(imgName).jpg"
                            let length  =   UIImageJPEGRepresentation(kProfImg, 1.0)?.length
                            self.selectedImageSize  =   "\(length!)"
                        }
                    }
                    
                    return nil
                })
            }
        }
        else {
            MessageAlertView().showMessage("Selected media type is not supported to upload.", kColor : kLS_FailedMsgColor)
        }
        
        self.picker.dismissViewControllerAnimated(true) { () -> Void in
            
        }
        
    }
    
    func ImageDownloadReqFinished () {
        profImg.image   =   self.userDetails._thumbImg
         profHeaderImgView.image    =   self.userDetails._thumbImg
        if (profileImgURL.isEqualToString("") == false) {
            self.selectedImgName    =   profileImgURL.componentsSeparatedByString("/").last!
            let length  =   UIImageJPEGRepresentation(self.userDetails._thumbImg, 1.0)?.length
            self.selectedImageSize  =   "\(length!)"
        }
    }
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func socialBtnTapped (sender : UIButton) {
        MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
    }
    
    func loadSetupUI () {
        
        scrollView  =   UIScrollView(frame: CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height))
        self.view.addSubview(scrollView!)
        scrollView!.showsVerticalScrollIndicator    =   false
        
        profHeaderImgView      =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        profHeaderImgView.layer.masksToBounds =   true
        scrollView!.addSubview(profHeaderImgView)
        profHeaderImgView.center.x    =   self.view.frame.size.width / 2.0
        
        profHeadertransView      =   UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        profHeadertransView.layer.masksToBounds =   true
        profHeadertransView.backgroundColor     =   UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        scrollView!.addSubview(profHeadertransView)
        profHeadertransView.center.x    =   self.view.frame.size.width / 2.0
        
        //Profile Head Setup
        let profMask      =   UIImageView(frame: CGRectMake(5, 5, 90, 90))
        profMask.image       =   UIImage(named: "image-stroke.png")
        scrollView!.addSubview(profMask)
        profMask.center.x    =   self.view.frame.size.width / 2.0
        
        profImg      =   UIImageView(frame: CGRectMake(10, 10, 80, 80))
        profImg.layer.masksToBounds =   true
        profImg.layer.cornerRadius  =   40.0
        scrollView!.addSubview(profImg)
        profImg.center.x    =   self.view.frame.size.width / 2.0
        profImg.userInteractionEnabled  =   true
        profImg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileVC.profImageEditTapped)))
        
        profImgActivity   =   UIActivityIndicatorView(activityIndicatorStyle: .White)
        profImgActivity?.hidesWhenStopped   =   true
        profImg.addSubview(profImgActivity!)
        profImgActivity?.center =   CGPoint(x: 40, y: 40)
        
        
        self.userDetails._delegate    =   self
        if (self.userDetails._isThumbImgDownloadIntiated == false)
        {
            self.userDetails.downloadThumbImg()
        }
        if ((self.userDetails._isThumbImgDownloadIntiated) == true && (self.userDetails._isThumbImgDownloaded == true))
        {
            profImg.image    =   self.userDetails._thumbImg
            profHeaderImgView.image    =   self.userDetails._thumbImg
            profileImgURL   =   self.userDetails._imageurl
            if (profileImgURL.isEqualToString("") == false) {
                self.selectedImgName    =   profileImgURL.componentsSeparatedByString("/").last!
                let length  =   UIImageJPEGRepresentation(self.userDetails._thumbImg, 1.0)?.length
                self.selectedImageSize  =   "\(length!)"
            }
            
        }
        
        userNameLbl  =   UILabel(frame: CGRectMake(10, 100, self.view.frame.size.width - 20, 20))
        userNameLbl!.text       =   "\(self.userDetails._firstName) \(self.userDetails._lastName)".uppercaseString
        userNameLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15)
        userNameLbl!.textColor  =   UIColor.blackColor()
        userNameLbl!.textAlignment  =   NSTextAlignment.Center
        scrollView!.addSubview(userNameLbl!)
        
        userSpecLbl  =   UILabel(frame: CGRectMake(10, 120, self.view.frame.size.width - 20, 15))
        userSpecLbl!.text       =  self.userDetails._specialitydesc.uppercaseString
        userSpecLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 11)
        userSpecLbl!.textColor  =   UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1)
        userSpecLbl!.textAlignment  =   NSTextAlignment.Center
        scrollView!.addSubview(userSpecLbl!)
        
        var kStart : CGFloat  =   100.0
        firstNameContainer  =   UIView(frame: CGRectMake(_textFldMargin!, kStart, _viewWidth! - (2 * _textFldMargin!), _textFldHeight!))
        scrollView!.addSubview(firstNameContainer!)
        
        firstNameTxtFld                 =   UITextField(frame: CGRectMake(0,0,(firstNameContainer?.frame.size.width )!,(firstNameContainer?.frame.size.height)!))
        firstNameTxtFld!.delegate       =   self
        firstNameTxtFld?.placeholder     =   "FIRST NAME"
        firstNameTxtFld?.textAlignment  =   .Center
        firstNameTxtFld?.autocapitalizationType =   .AllCharacters
        firstNameTxtFld?.keyboardType   =   UIKeyboardType.Default
        firstNameTxtFld?.text            =   self.userDetails._firstName.uppercaseString
        firstNameTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        firstNameContainer!.addSubview(firstNameTxtFld!)
        
        let kImgView1        =   UIImageView(frame: CGRectMake(0,_textFldHeight!,(firstNameContainer?.frame.size.width )!,1.0))
        kImgView1.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        firstNameContainer!.addSubview(kImgView1)
        
        kStart  =   kStart + _textFldHeight! + _textFldsGap!
        
        
        lastNameContainer  =   UIView(frame: CGRectMake(_textFldMargin!, kStart, _viewWidth! - (2 * _textFldMargin!), _textFldHeight!))
        scrollView!.addSubview(lastNameContainer!)
        
        lastNameTxtFld              =   UITextField(frame: CGRectMake(0,0,(lastNameContainer?.frame.size.width )!,(lastNameContainer?.frame.size.height)!))
        lastNameTxtFld!.delegate    =   self
        lastNameTxtFld?.placeholder     =   "LAST NAME"
        lastNameTxtFld?.textAlignment   =   .Center
        lastNameTxtFld?.autocapitalizationType =   .AllCharacters
        lastNameTxtFld?.text            =   self.userDetails._lastName.uppercaseString
        lastNameTxtFld?.keyboardType   =   UIKeyboardType.Default
        lastNameTxtFld?.font                =   UIFont(name: Gillsans.Default.description, size: 15.0)
        lastNameContainer!.addSubview(lastNameTxtFld!)
        
        let kImgView2        =   UIImageView(frame: CGRectMake(0,_textFldHeight!,(lastNameContainer?.frame.size.width )!,1.0))
        kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        lastNameContainer!.addSubview(kImgView2)
        
        socialContainer   =   UIView(frame: CGRectMake(0,150,(32 * 3) + (25 * 2), 32))
   //     scrollView!.addSubview(socialContainer!)
        let kBtn        =   UIButton(type: .Custom)
        kBtn.setImage(UIImage(named: "facebookColor.png"), forState: .Normal)
        kBtn.frame      =   CGRectMake(0, 0, 32, 32)
        kBtn.addTarget(self, action: #selector(ProfileVC.socialBtnTapped(_:)), forControlEvents: .TouchUpInside)
        socialContainer!.addSubview(kBtn)
        let kBtn1       =   UIButton(type: .Custom)
        kBtn1.setImage(UIImage(named: "twitterColor.png"), forState: .Normal)
        kBtn1.frame     =   CGRectMake(32 + 25, 0, 32, 32)
        kBtn1.tag       =   1
        kBtn1.addTarget(self, action: #selector(ProfileVC.socialBtnTapped(_:)), forControlEvents: .TouchUpInside)
        socialContainer!.addSubview(kBtn1)
        let kBtn2       =   UIButton(type: .Custom)
        kBtn2.setImage(UIImage(named: "linkedinColor.png"), forState: .Normal)
        kBtn2.frame     =   CGRectMake((32 * 2) + (25 * 2), 0, 32, 32)
        kBtn2.tag       =   2
        kBtn2.addTarget(self, action: #selector(ProfileVC.socialBtnTapped(_:)), forControlEvents: .TouchUpInside)
        socialContainer!.addSubview(kBtn2)
        
        socialContainer!.center.x    =   self.view.frame.size.width / 2.0
        
        let sepImg1      =   UIImageView(frame: CGRectMake(0, 199, self.view.frame.size.width, 1))
        sepImg1.backgroundColor  =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
        scrollView!.addSubview(sepImg1)
        
        profEditIcon      =   UIImageView(frame: CGRectMake(0, 15, 20, 20))
        profEditIcon!.image =   UIImage(named: "profile-edit.png")
        scrollView!.addSubview(profEditIcon!)
        profEditIcon!.center.x    =   (self.view.frame.size.width / 2.0) - 30
        
        firstNameContainer?.hidden  =   true
        lastNameContainer?.hidden   =   true
        profEditIcon?.hidden        =   true
        
        //Sengemnt Setup
        segmentedControl    =   TLSSegmentView(frame: CGRectMake(0, 200, self.view.frame.size.width, 50), textColor: UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1), selectedTextColor: UIColor.blackColor(), textFont: UIFont(name: Gillsans.Default.description, size: 15.0)!)
        segmentedControl.delegate = self
        segmentedControl.addSegments(["PERSONAL","WORK"])
        self.view.addSubview(segmentedControl)
        scrollView!.addSubview(segmentedControl)
        
        contentView     =   UIView(frame: CGRectMake(0,250.0,self.view.frame.size.width, self.view.frame.size.height - 50.0))
        contentView.backgroundColor    =   UIColor.whiteColor()
        scrollView!.addSubview(contentView)
        scrollView!.contentSize =   CGSizeMake(self.view.frame.size.width, 250.0 + self.view.frame.size.height - 50.0)
        
        let kTempBar    = UIView(frame:CGRect(x: 0.0, y: 47.0, width: self.view.frame.size.width, height: 3.0))
        kTempBar.backgroundColor    =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1)
        self.segmentedControl.addSubview(kTempBar)
        self.seletionBar.frame = CGRect(x: 0.0, y: 47.0, width: 0, height: 3.0)
        self.seletionBar.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.41, alpha: 1)
        self.segmentedControl.addSubview(self.seletionBar)
        self.segmentedControl.selectSegementAtIndex(0)
      

    }
    
    func loadProfile () {
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "Unknown error occured."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        
        noLbl.hidden    =   true
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        if (kArtistID == "")
        {
            kArtistID   =   getUserID() as String
        }
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kArtistID] , forKeys: [kLS_CP_UserId,kLS_CP_Artistid])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_UserProfile_GetUserDetails, parm: dict1, completion: { result , desc , code in
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
                        let kArr: AnyObject?   =   result .objectForKey(kLS_CP_result)
                        if (kArr?.isKindOfClass(NSNull) == false && kArr?.isKindOfClass(NSDictionary) == true)
                        {
                            isSuccess   =   true
                            self.userDetails    =   UserDetailsObj().setDetails(kArr  as! NSDictionary, kDelegate: self as UserDetailsObjDelegate)
                            self.loadSetupUI()
                        }
                    }
                }
                if (isSuccess == false)
                {
                    noLbl.hidden    =   false
                }
            }
            else
            {
                noLbl.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                }
            }
        })
    }
    
    
    func loadDetails (kType:Int) {
        for kView in self.contentView.subviews {
            kView.removeFromSuperview()
        }
        let kScrollView =   UIScrollView(frame: CGRectMake(0,0,self.contentView.frame.size.width,self.contentView.frame.size.height))
        self.contentView.addSubview(kScrollView)
        
        
        self.selectedPrimaryRoleId      =   self.userDetails._specialityCd
        self.selectedAddRoleIDs      =   self.userDetails._addRoleIds
        self.selectedAddSpecIDs         =   self.userDetails._addSpecIds
        self.selectedCountryId          =   self.userDetails._countryId
        var kStrtY : CGFloat    =   20.0
        
        let kMutArray   =   NSMutableArray()
        if (kType == 1)
        {
            // kMutArray.addObject(["NAME":self.userDetails._firstName.uppercaseString + " " + self.userDetails._lastName.uppercaseString])
            kMutArray.addObject(["EMAIL":self.userDetails._email.uppercaseString])
            kMutArray.addObject(["PHONE":self.userDetails._phone.uppercaseString])
            kMutArray.addObject(["PRIMARY ROLE":self.userDetails._specialitydesc.uppercaseString])
            kMutArray.addObject(["PERSONAL MOTO":self.userDetails._personalMotto.uppercaseString])
            kMutArray.addObject(["WEBSITE":self.userDetails._website.uppercaseString])
            kMutArray.addObject(["COUNTRY":self.userDetails._countryName.uppercaseString])
            kMutArray.addObject(["CITY":self.userDetails._city.uppercaseString])
            kMutArray.addObject(["ZIP":self.userDetails._zipCode.uppercaseString])
            kMutArray.addObject(["FACEBOOK":self.userDetails._facebooklink.uppercaseString])
            kMutArray.addObject(["TWITTER":self.userDetails._twitterlink.uppercaseString])
            kMutArray.addObject(["INSTAGRAM":self.userDetails._instagramlink.uppercaseString])
            
        }
        else if (kType == 2)
        {
            
            kMutArray.addObject(["PRIMARY ROLE":self.userDetails._specialitydesc.uppercaseString])
            kMutArray.addObject(["ADDITIONAL ROLE":self.userDetails._addRoleIds.uppercaseString])
            kMutArray.addObject(["SPECIALITY":self.userDetails._addSpecIds.uppercaseString])
            if (self.userDetails._specialityCd.isEqualToString("MODEL") == true)
            {
                kMutArray.addObject(["GENDER":self.userDetails._gender.uppercaseString])
                kMutArray.addObject(["HEIGHT":self.userDetails._height.uppercaseString])
                if (userDetails._gender.uppercaseString == "MALE")
                {
                    kMutArray.addObject(["PANT SIZE":self.userDetails._pantsize.uppercaseString])
                }
                else
                {
                    kMutArray.addObject(["BUST":self.userDetails._bust.uppercaseString])
                    kMutArray.addObject(["WAIST":self.userDetails._waist.uppercaseString])
                    kMutArray.addObject(["HIPS":self.userDetails._hips.uppercaseString])
                }
                
                kMutArray.addObject(["SHOE":self.userDetails._shoe.uppercaseString])
                kMutArray.addObject(["HAIR COLOR":self.userDetails._hairColor.uppercaseString])
                kMutArray.addObject(["EYE COLOR":self.userDetails._eyeColor.uppercaseString])
            }
        }
        
        for i in 0 ..< kMutArray.count {
            
            let descLbl         =   UILabel(frame: CGRectMake(80,kStrtY, self.view.frame.size.width - 80 - 10 , 20))
            descLbl.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl.textAlignment   =   .Left
            descLbl.text        =   kMutArray.objectAtIndex(i).allKeys[0] as? String
            kScrollView.addSubview(descLbl)
            
            kStrtY  =   kStrtY + 20
            if (descLbl.text  == "ADDITIONAL ROLE")
            {
                let kArray  = (kMutArray.objectAtIndex(i).allValues[0] as? String)!.componentsSeparatedByString(",")
                print(kArray)
                
                var isItemThr : Bool    =   false
                
                for j in 0 ..< kArray.count
                {
                    if (kArray[j] != "")
                    {
                        isItemThr   =   true
                        
                        
                        let descLbl1         =   UILabel(frame: CGRectMake(80,kStrtY, self.view.frame.size.width - 80 - 10 , 20))
                        descLbl1.textColor   =   UIColor.blackColor()
                        descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
                        descLbl1.textAlignment   =   .Left
                        descLbl1.text       =   userDetails._addRolesDict[kArray[j]]?.uppercaseString
                        descLbl1.numberOfLines  =   0
                        kScrollView.addSubview(descLbl1)
                        
                        kStrtY      =   kStrtY + 20.0 + 5.0 //height + 5.0
                    }
                }
                
                if (isItemThr)
                {
                    kStrtY      =   kStrtY + 15.0
                }
                else
                {
                    kStrtY      =   kStrtY + 20.0 + 20.0
                }
                
            }
            else if (descLbl.text  == "SPECIALITY")
            {
                let kArray  = (kMutArray.objectAtIndex(i).allValues[0] as? String)!.componentsSeparatedByString(",")
                print(kArray)
                
                var isItemThr : Bool    =   false
                
                for j in 0 ..< kArray.count
                {
                    if (kArray[j] != "")
                    {
                        isItemThr   =   true
                        
                        let descLbl1         =   UILabel(frame: CGRectMake(80,kStrtY, self.view.frame.size.width - 80 - 10 , 20))
                        descLbl1.textColor   =   UIColor.blackColor()
                        descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
                        descLbl1.textAlignment   =   .Left
                        descLbl1.text       =   userDetails._specialitiesDict[kArray[j]]?.uppercaseString
                        descLbl1.numberOfLines  =   0
                        kScrollView.addSubview(descLbl1)
                        
                        kStrtY      =   kStrtY + 20.0 + 5.0 //height + 5.0
                    }
                }
                
                if (isItemThr)
                {
                    kStrtY      =   kStrtY + 15.0
                }
                else
                {
                    kStrtY      =   kStrtY + 20.0 + 20.0
                }
                
            }
            else
            {
                let descLbl1         =   UILabel(frame: CGRectMake(80,kStrtY, self.view.frame.size.width - 80 - 10 , 20))
                descLbl1.textColor   =   UIColor.blackColor()
                descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
                descLbl1.textAlignment   =   .Left
                descLbl1.numberOfLines  =   0
                descLbl1.text        =   kMutArray.objectAtIndex(i).allValues[0] as? String
                kScrollView.addSubview(descLbl1)
                
                
                var height = heightForView(descLbl1.text!, font: UIFont(name: Gillsans.Default.description, size: 15.0)!, width: self.view.frame.size.width - 80 - 10 )
                
                if (height > 20.0)
                {
                    descLbl1.frame.size.height   =   height
                }
                else
                {
                    height = 20.0
                }
                
                kStrtY      =   kStrtY + height + 20.0
            }
            
        }
        
        let kImgView    =   UIImageView(frame: CGRectMake(25, 20, 30, 30))
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        kScrollView.addSubview(kImgView)
        
        if (kType == 1)
        {
            kImgView.image  =   UIImage(named: "profile1.png")
        }
        else if (kType == 2)
        {
            kImgView.image  =   UIImage(named: "work.png")
        }
        
        kScrollView.contentSize =   CGSizeMake(self.contentView.frame.size.width, kStrtY)
        
        if (kStrtY > kScrollView.frame.size.height)
        {
            let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kStrtY - 60))
            imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            kScrollView.addSubview(imgView)
        }
        else
        {
            let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kScrollView.frame.size.height - 60))
            imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            kScrollView.addSubview(imgView)
        }
    }
    
    func segementSelected (segment : TLSSegment, index : Int) {
        
        UIView.animateWithDuration(0.2, animations: {
            self.seletionBar.frame = CGRectMake(segment.frame.origin.x, self.seletionBar.frame.origin.y, segment.frame.size.width, self.seletionBar.frame.size.height)
        })
        
        for kView in (contentView.subviews) {
            kView.removeFromSuperview()
        }
        
        self.navigationItem.rightBarButtonItem?.customView?.hidden  =   true
        (self.navigationItem.rightBarButtonItem?.customView as? UIButton)?.selected =   false
        isEditMode          =   false
        userNameLbl?.hidden =   false
        userSpecLbl?.hidden =   false
        socialContainer?.hidden     =   false
        firstNameContainer?.hidden  =   true
        lastNameContainer?.hidden   =   true
        profEditIcon?.hidden        =   true

        switch index {
            
        case 0:
            self.navigationItem.rightBarButtonItem?.customView?.hidden  =   false
            
            loadDetails(1)
            selectedTypeView    =   1
        case 1:
            self.navigationItem.rightBarButtonItem?.customView?.hidden  =   false
            loadDetails(2)
            selectedTypeView    =   2
            break
        default:
            selectedTypeView    =   0
//            let prodView            =   MyPortfolioView(frame: CGRectMake(0,0,contentView.frame.size.width,contentView.frame.size.height))
//            prodView.viewController =   self
//            contentView.addSubview(prodView)
//            prodView.loadDetails()
            let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height))
            noLbl.text       =   kLS_FeatureNotImplemented
            noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
            noLbl.textAlignment  =   .Center
            contentView.addSubview(noLbl)

            break
        }
    }
    
    func headBtnTapped () {
        NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_HomeHeadTapped, object: nil)
    }
    func menuBtnTapped () {
        presentLeftMenuViewController()
    }
    
    func menuEditBtnTapped (sender: UIButton) {
        if (sender.selected == true)
        {
            if (selectedTypeView == 1)
            {
                if (firstNameTxtFld?.text == "")
                {
                    firstNameTxtFld?.becomeFirstResponder()
                    ShowAlert("Specify first name.")
                    return
                }
                
                var profLinkUserType  : NSString  =   "Agent"
                if (self.selectedPrimaryRoleId.isEqualToString("AAGENT") == true)
                {
                    profLinkUserType    =   "Artist"
                }
                let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kArtistID,"",(cityTxtFld?.text)!,self.selectedCountryId,(countryTxtFld?.text)!,(emailTxtFld?.text)!,(personalMottoTxtFld?.text)!,(firstNameTxtFld?.text)!,(lastNameTxtFld?.text)!,self.selectedPrimaryRoleId,(websiteTxtFld?.text)!,(zipTxtFld?.text)!,(facebookTxtFld?.text)!,(twitterTxtFld?.text)!,(instagramTxtFld?.text)!,profileImgURL,self.selectedImageSize,profLinkUserType,"","","","",[],[],self.selectedImgName,[],[],(self.phoneTxtFld?.text)!] , forKeys: [kLS_CP_UserId,kLS_CP_Artistid,kLS_CP_profileAgentId,kLS_CP_profileCity,kLS_CP_profileCountry,kLS_CP_countryName,kLS_CP_profileEmail,kLS_CP_profileMotto,kLS_CP_profileFirstName,kLS_CP_profileLastName,kLS_CP_profileRole,kLS_CP_profileWebsite,kLS_CP_profileZip,kLS_CP_profileFacebook,kLS_CP_profileTwitter,kLS_CP_profileInstagram,kLS_CP_profileimagename,kLS_CP_profileimagesize,kLS_CP_proflinkuserType,kLS_CP_proflinkAcceptedlist,kLS_CP_proflinkDeletedlist,kLS_CP_proflinkRejectedlist,kLS_CP_profileSpecialtyId,kLS_CP_acceptlinklistarr,kLS_CP_deletelinklistarr,kLS_CP_imagename,kLS_CP_linkartistlistarr,kLS_CP_rejectlinklistarr,kLS_CP_profilePhone])
                
                print(dict1)
                let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
                GetAppDelegate().window?.addSubview(maskView)
                
                ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Profile_SavePersonalInfo, parm: dict1, completion: { result , desc , code in
                   maskView.removeFromSuperview()
                    if ( code == 99)
                    {
                        MessageAlertView().showMessage("Personal details updated successfully", kColor :kLS_SuccessMsgColor)
                        print(result)
                        
                        self.userDetails._firstName     =   (self.firstNameTxtFld?.text)!
                        self.userDetails._lastName      =   (self.lastNameTxtFld?.text)!
                        self.userDetails._specialityCd  =   self.selectedPrimaryRoleId
                        self.userDetails._email         =   (self.emailTxtFld?.text)!
                        self.userDetails._phone         =   (self.phoneTxtFld?.text)!
                        self.userDetails._specialitydesc    =   (self.primaryroleTxtFld?.text)!
                        self.userDetails._personalMotto =   (self.personalMottoTxtFld?.text)!
                        self.userDetails._website       =   (self.websiteTxtFld?.text)!
                        self.userDetails._countryName   =   (self.countryTxtFld?.text)!
                        self.userDetails._countryId     =   self.selectedCountryId
                        self.userDetails._city          =   (self.cityTxtFld?.text)!
                        self.userDetails._zipCode       =   (self.zipTxtFld?.text)!
                        self.userDetails._facebooklink  =   (self.facebookTxtFld?.text)!
                        self.userDetails._twitterlink   =   (self.twitterTxtFld?.text)!
                        self.userDetails._instagramlink =   (self.instagramTxtFld?.text)!
                        self.userNameLbl!.text          =   "\(self.userDetails._firstName) \(self.userDetails._lastName)".uppercaseString
                        self.userSpecLbl!.text          =   self.userDetails._specialityRole.uppercaseString
                        self.userDetails._imageurl      =   self.profileImgURL
                
                        
                        self.isEditMode             =   false
                        self.userNameLbl?.hidden    =   false
                        self.userSpecLbl?.hidden    =   false
                        self.socialContainer?.hidden     =   false
                        self.firstNameContainer?.hidden  =   true
                        self.lastNameContainer?.hidden   =   true
                        self.profEditIcon?.hidden        =   true
                        sender.selected =   false
                        
                        self.segmentedControl.selectSegementAtIndex(0)
                        
                        if (self.isArtistEditable == false)
                        {
                            NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_ProfileUpdated, object: self.userDetails)
                        }
                        else
                        {
                            NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_ArtistProfileUpdated, object: self.userDetails)
                        }
                        
                        
                    }
                    else
                    {
                        MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                        print(desc)
                    }
                })
            }
            else if (selectedTypeView == 2)
            {
                var dict1: NSMutableDictionary   =  NSMutableDictionary()
                
                var kGender    =   "FEMALE"
                if (self.genderSegment  != nil)
                {
                    kGender =   self.genderSegment!.titleForSegmentAtIndex( self.genderSegment!.selectedSegmentIndex)!
                }
                
                dict1   =   NSMutableDictionary(objects: [getUserID(),kArtistID,self.selectedPrimaryRoleId,kGender,"",self.selectedAddSpecIDs,self.selectedAddRoleIDs] , forKeys: [kLS_CP_UserId,kLS_CP_Artistid,kLS_CP_UserRole,kLS_CP_Gender,kLS_CP_SpecialtyId,kLS_CP_addSpecialty,kLS_CP_addionalrole])
                
                if (self.selectedPrimaryRoleId.uppercaseString == "MODEL")
                {
                    if (kGender == "MALE")
                    {
                        dict1   =   NSMutableDictionary(objects: [getUserID(),kArtistID,self.selectedPrimaryRoleId,kGender,"",self.selectedAddSpecIDs,self.selectedAddRoleIDs,"",(eyeTxtFld?.text)!,(hairTxtFld?.text)!,(heightTxtFld?.text)!,"",(pantsizeTxtFld?.text)!,(shoeTxtFld?.text)!,"",""] , forKeys: [kLS_CP_UserId,kLS_CP_Artistid,kLS_CP_UserRole,kLS_CP_Gender,kLS_CP_SpecialtyId,kLS_CP_addSpecialty,kLS_CP_addionalrole,kLS_CP_Bust,kLS_CP_EyeColor,kLS_CP_HairColor,kLS_CP_Height,kLS_CP_Hips,kLS_CP_Pantsize,kLS_CP_Shoe,kLS_CP_Waist,kLS_CP_Weight])
                    }
                    else
                    {
                      dict1   =   NSMutableDictionary(objects: [getUserID(),kArtistID,self.selectedPrimaryRoleId,kGender,"",self.selectedAddSpecIDs,self.selectedAddRoleIDs,(bustTxtFld?.text)!,(eyeTxtFld?.text)!,(hairTxtFld?.text)!,(heightTxtFld?.text)!,(hipsTxtFld?.text)!,"",(shoeTxtFld?.text)!,(waistTxtFld?.text)!,""] , forKeys: [kLS_CP_UserId,kLS_CP_Artistid,kLS_CP_UserRole,kLS_CP_Gender,kLS_CP_SpecialtyId,kLS_CP_addSpecialty,kLS_CP_addionalrole,kLS_CP_Bust,kLS_CP_EyeColor,kLS_CP_HairColor,kLS_CP_Height,kLS_CP_Hips,kLS_CP_Pantsize,kLS_CP_Shoe,kLS_CP_Waist,kLS_CP_Weight])
                    }
                }
                
                let maskView    =   MaskView(frame: (GetAppDelegate().window?.frame)!)
                GetAppDelegate().window?.addSubview(maskView)
                
                ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Profile_SaveWorkdetail, parm: dict1, completion: { result , desc , code in
                    maskView.removeFromSuperview()
                    if ( code == 99)
                    {
                        
                        MessageAlertView().showMessage("Work details updated successfully", kColor :kLS_SuccessMsgColor)
                        print(result)
                        
                        self.userDetails._gender        =   kGender
                        self.userDetails._addSpecIds    =   self.selectedAddSpecIDs
                        self.userDetails._addRoleIds    =   self.selectedAddRoleIDs
                 
                        
                        if (self.selectedPrimaryRoleId.uppercaseString == "MODEL")
                        {
                            self.userDetails._eyeColor  =   (self.eyeTxtFld?.text)!
                            self.userDetails._hairColor =   (self.hairTxtFld?.text)!
                            self.userDetails._height    =   (self.heightTxtFld?.text)!
                            self.userDetails._shoe      =   (self.shoeTxtFld?.text)!
                            
                            if (kGender == "MALE")
                            {
                                self.userDetails._pantsize =   (self.pantsizeTxtFld?.text)!
                            }
                            else
                            {
                                self.userDetails._bust  =   (self.bustTxtFld?.text)!
                                self.userDetails._waist =   (self.waistTxtFld?.text)!
                                self.userDetails._hips  =   (self.hipsTxtFld?.text)!
                            }
                        }
                        
                        self.isEditMode     =   false
                        sender.selected     =   false
                        
                        self.segmentedControl.selectSegementAtIndex(1)
                        if (self.isArtistEditable == false)
                        {
                            NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_ProfileUpdated, object: self.userDetails)
                        }
                        else
                        {
                            NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_ArtistProfileUpdated, object: self.userDetails)
                        }
                    }
                    else
                    {
                        MessageAlertView().showMessage(desc, kColor : kLS_FailedMsgColor)
                        print(desc)
                    }
                })

            }
 
        }
        else
        {
            
            sender.selected =   true
            
            if (selectedTypeView == 1)
            {
                isEditMode              =   true
                userNameLbl?.hidden     =   true
                userSpecLbl?.hidden     =   true
                socialContainer?.hidden     =   true
                firstNameContainer?.hidden  =   false
                lastNameContainer?.hidden   =   false
                profEditIcon?.hidden        =   false
                loadEditingView(1)
            }
            else if (selectedTypeView == 2)
            {
                loadEditingView(2)
            }
        }
        
    }
    
    func loadEditingView (kType : Int) {
        
        for kView in self.contentView.subviews {
            kView.removeFromSuperview()
        }
        kScrollView =   UIScrollView(frame: CGRectMake(0,0,self.contentView.frame.size.width,self.contentView.frame.size.height))
        self.contentView.addSubview(kScrollView)
        
        if (kType == 1)
        {
            var kStrtY : CGFloat    =   20.0
            
            emailContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(emailContainer!)
            
            let descLbl         =   UILabel(frame: CGRectMake(0,0, (emailContainer?.frame.size.width )! , 20))
            descLbl.textColor   =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl.textAlignment   =   .Left
            descLbl.text        =   "EMAIL"
            emailContainer!.addSubview(descLbl)
            
            emailTxtFld                 =   UITextField(frame: CGRectMake(0,20,(emailContainer?.frame.size.width )!,20))
            emailTxtFld!.delegate       =   self
            emailTxtFld?.placeholder    =   "EMAIL"
            emailTxtFld?.textAlignment  =   .Left
            emailTxtFld?.autocapitalizationType =   .AllCharacters
            emailTxtFld?.textColor      =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            emailTxtFld?.enabled        =   false
            emailTxtFld?.keyboardType   =   UIKeyboardType.Default
            emailTxtFld?.text           =   userDetails._email.uppercaseString
            emailTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            emailContainer!.addSubview(emailTxtFld!)
            
            let kImgView        =   UIImageView(frame: CGRectMake(0,(emailContainer?.frame.size.height )! - 1,(emailContainer?.frame.size.width )!,1.0))
            kImgView.backgroundColor    =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            emailContainer!.addSubview(kImgView)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            phoneContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(phoneContainer!)
            
            let descLbl10         =   UILabel(frame: CGRectMake(0,0, (phoneContainer?.frame.size.width )! , 20))
            descLbl10.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl10.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl10.textAlignment   =   .Left
            descLbl10.text        =   "PHONE"
            phoneContainer!.addSubview(descLbl10)
            
            phoneTxtFld                 =   UITextField(frame: CGRectMake(0,20,(phoneContainer?.frame.size.width )!,20))
            phoneTxtFld!.delegate       =   self
            phoneTxtFld?.placeholder    =   "PHONE"
            phoneTxtFld?.textAlignment  =   .Left
            phoneTxtFld?.autocapitalizationType =   .AllCharacters
            phoneTxtFld?.keyboardType   =   .NumberPad
            phoneTxtFld?.text           =   userDetails._phone.uppercaseString
            phoneTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            phoneContainer!.addSubview(phoneTxtFld!)
            
            let kImgView10        =   UIImageView(frame: CGRectMake(0,(phoneContainer?.frame.size.height )! - 1,(phoneContainer?.frame.size.width )!,1.0))
            kImgView10.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            phoneContainer!.addSubview(kImgView10)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            primaryroleContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(primaryroleContainer!)
            
            let descLbl1         =   UILabel(frame: CGRectMake(0,0, (primaryroleContainer?.frame.size.width )! , 20))
            descLbl1.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl1.textAlignment   =   .Left
            descLbl1.text        =   "PRIMARY ROLE"
            primaryroleContainer!.addSubview(descLbl1)
            
            primaryroleTxtFld                 =   UITextField(frame: CGRectMake(0,20,(primaryroleContainer?.frame.size.width )!,20))
            primaryroleTxtFld!.delegate       =   self
            primaryroleTxtFld?.placeholder    =   "PRIMARY ROLE"
            primaryroleTxtFld?.textAlignment  =   .Left
            primaryroleTxtFld?.autocapitalizationType =   .AllCharacters
            primaryroleTxtFld?.keyboardType   =   UIKeyboardType.Default
            primaryroleTxtFld?.text           =   userDetails._specialitydesc.uppercaseString
            primaryroleTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            primaryroleContainer!.addSubview(primaryroleTxtFld!)
            
            let kImgView1        =   UIImageView(frame: CGRectMake(0,(primaryroleContainer?.frame.size.height )! - 1,(primaryroleContainer?.frame.size.width )!,1.0))
            kImgView1.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            primaryroleContainer!.addSubview(kImgView1)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            personalMottoContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(personalMottoContainer!)
            
            let descLbl2         =   UILabel(frame: CGRectMake(0,0, (personalMottoContainer?.frame.size.width )! , 20))
            descLbl2.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl2.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl2.textAlignment   =   .Left
            descLbl2.text        =   "PERSONAL MOTO"
            personalMottoContainer!.addSubview(descLbl2)
            
            personalMottoTxtFld                 =   UITextField(frame: CGRectMake(0,20,(personalMottoContainer?.frame.size.width )!,20))
            personalMottoTxtFld!.delegate       =   self
            personalMottoTxtFld?.placeholder     =   "PERSONAL MOTO"
            personalMottoTxtFld?.textAlignment  =   .Left
            personalMottoTxtFld?.autocapitalizationType =   .AllCharacters
            personalMottoTxtFld?.keyboardType   =   UIKeyboardType.Default
            personalMottoTxtFld?.text            =   userDetails._personalMotto.uppercaseString
            personalMottoTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            personalMottoContainer!.addSubview(personalMottoTxtFld!)
            
            let kImgView2        =   UIImageView(frame: CGRectMake(0,(personalMottoContainer?.frame.size.height )! - 1,(personalMottoContainer?.frame.size.width )!,1.0))
            kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            personalMottoContainer!.addSubview(kImgView2)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            websiteContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(websiteContainer!)
            
            let descLbl3         =   UILabel(frame: CGRectMake(0,0, (websiteContainer?.frame.size.width )! , 20))
            descLbl3.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl3.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl3.textAlignment   =   .Left
            descLbl3.text        =   "WEBSITE"
            websiteContainer!.addSubview(descLbl3)
            
            websiteTxtFld                 =   UITextField(frame: CGRectMake(0,20,(websiteContainer?.frame.size.width )!,20))
            websiteTxtFld!.delegate       =   self
            websiteTxtFld?.placeholder     =   "WEBSITE"
            websiteTxtFld?.textAlignment  =   .Left
            websiteTxtFld?.autocapitalizationType =   .AllCharacters
            websiteTxtFld?.keyboardType   =   UIKeyboardType.Default
            websiteTxtFld?.text            =   userDetails._website.uppercaseString
            websiteTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            websiteContainer!.addSubview(websiteTxtFld!)
            
            let kImgView3        =   UIImageView(frame: CGRectMake(0,(websiteContainer?.frame.size.height )! - 1,(websiteContainer?.frame.size.width )!,1.0))
            kImgView3.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            websiteContainer!.addSubview(kImgView3)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            countryContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(countryContainer!)
            
            let descLbl4         =   UILabel(frame: CGRectMake(0,0, (countryContainer?.frame.size.width )! , 20))
            descLbl4.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl4.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl4.textAlignment   =   .Left
            descLbl4.text        =   "COUNTRY"
            countryContainer!.addSubview(descLbl4)
            
            countryTxtFld                 =   UITextField(frame: CGRectMake(0,20,(countryContainer?.frame.size.width )!,20))
            countryTxtFld!.delegate       =   self
            countryTxtFld?.placeholder     =   "COUNTRY"
            countryTxtFld?.textAlignment  =   .Left
            countryTxtFld?.autocapitalizationType =   .AllCharacters
            countryTxtFld?.keyboardType   =   UIKeyboardType.Default
            countryTxtFld?.text            =   userDetails._countryName.uppercaseString
            countryTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            countryContainer!.addSubview(countryTxtFld!)
            
            let kImgView4        =   UIImageView(frame: CGRectMake(0,(countryContainer?.frame.size.height )! - 1,(countryContainer?.frame.size.width )!,1.0))
            kImgView4.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            countryContainer!.addSubview(kImgView4)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            
            cityContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(cityContainer!)
            
            let descLbl5         =   UILabel(frame: CGRectMake(0,0, (cityContainer?.frame.size.width )! , 20))
            descLbl5.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl5.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl5.textAlignment   =   .Left
            descLbl5.text        =   "CITY"
            cityContainer!.addSubview(descLbl5)
            
            cityTxtFld                 =   UITextField(frame: CGRectMake(0,20,(cityContainer?.frame.size.width )!,20))
            cityTxtFld!.delegate       =   self
            cityTxtFld?.placeholder     =   "CITY"
            cityTxtFld?.textAlignment  =   .Left
            cityTxtFld?.autocapitalizationType =   .AllCharacters
            cityTxtFld?.keyboardType   =   UIKeyboardType.Default
            cityTxtFld?.text            =   userDetails._city.uppercaseString
            cityTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            cityContainer!.addSubview(cityTxtFld!)
            
            let kImgView5        =   UIImageView(frame: CGRectMake(0,(cityContainer?.frame.size.height )! - 1,(cityContainer?.frame.size.width )!,1.0))
            kImgView5.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            cityContainer!.addSubview(kImgView5)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            zipContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(zipContainer!)
            
            let descLbl6         =   UILabel(frame: CGRectMake(0,0, (zipContainer?.frame.size.width )! , 20))
            descLbl6.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl6.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl6.textAlignment   =   .Left
            descLbl6.text        =   "ZIP"
            zipContainer!.addSubview(descLbl6)
            
            zipTxtFld                 =   UITextField(frame: CGRectMake(0,20,(zipContainer?.frame.size.width )!,20))
            zipTxtFld!.delegate       =   self
            zipTxtFld?.placeholder     =   "ZIP"
            zipTxtFld?.textAlignment  =   .Left
            zipTxtFld?.autocapitalizationType =   .AllCharacters
            zipTxtFld?.keyboardType   =   UIKeyboardType.Default
            zipTxtFld?.text            =   userDetails._zipCode.uppercaseString
            zipTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            zipContainer!.addSubview(zipTxtFld!)
            
            let kImgView6        =   UIImageView(frame: CGRectMake(0,(zipContainer?.frame.size.height )! - 1,(zipContainer?.frame.size.width )!,1.0))
            kImgView6.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            zipContainer!.addSubview(kImgView6)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            
            facebookContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(facebookContainer!)
            
            let descLbl7         =   UILabel(frame: CGRectMake(0,0, (facebookContainer?.frame.size.width )! , 20))
            descLbl7.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl7.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl7.textAlignment   =   .Left
            descLbl7.text        =   "FACEBOOK"
            facebookContainer!.addSubview(descLbl7)
            
            facebookTxtFld                 =   UITextField(frame: CGRectMake(0,20,(facebookContainer?.frame.size.width )!,20))
            facebookTxtFld!.delegate       =   self
            facebookTxtFld?.placeholder     =   "FACEBOOK"
            facebookTxtFld?.textAlignment  =   .Left
            facebookTxtFld?.autocapitalizationType =   .AllCharacters
            facebookTxtFld?.keyboardType   =   UIKeyboardType.Default
            facebookTxtFld?.text            =   userDetails._facebooklink.uppercaseString
            facebookTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            facebookContainer!.addSubview(facebookTxtFld!)
            
            let kImgView7        =   UIImageView(frame: CGRectMake(0,(facebookContainer?.frame.size.height )! - 1,(facebookContainer?.frame.size.width )!,1.0))
            kImgView7.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            facebookContainer!.addSubview(kImgView7)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            
            twitterContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(twitterContainer!)
            
            let descLbl8         =   UILabel(frame: CGRectMake(0,0, (twitterContainer?.frame.size.width )! , 20))
            descLbl8.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl8.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl8.textAlignment   =   .Left
            descLbl8.text        =   "TWITTER"
            twitterContainer!.addSubview(descLbl8)
            
            twitterTxtFld                 =   UITextField(frame: CGRectMake(0,20,(twitterContainer?.frame.size.width )!,20))
            twitterTxtFld!.delegate       =   self
            twitterTxtFld?.placeholder     =   "TWITTER"
            twitterTxtFld?.textAlignment  =   .Left
            twitterTxtFld?.autocapitalizationType =   .AllCharacters
            twitterTxtFld?.keyboardType   =   UIKeyboardType.Default
            twitterTxtFld?.text            =   userDetails._twitterlink.uppercaseString
            twitterTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            twitterContainer!.addSubview(twitterTxtFld!)
            
            let kImgView8        =   UIImageView(frame: CGRectMake(0,(twitterContainer?.frame.size.height )! - 1,(twitterContainer?.frame.size.width )!,1.0))
            kImgView8.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            twitterContainer!.addSubview(kImgView8)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            instagramContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(instagramContainer!)
            
            let descLbl9         =   UILabel(frame: CGRectMake(0,0, (instagramContainer?.frame.size.width )! , 20))
            descLbl9.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl9.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl9.textAlignment   =   .Left
            descLbl9.text        =   "INSTAGRAM"
            instagramContainer!.addSubview(descLbl9)
            
            instagramTxtFld                 =   UITextField(frame: CGRectMake(0,20,(instagramContainer?.frame.size.width )!,20))
            instagramTxtFld!.delegate       =   self
            instagramTxtFld?.placeholder    =   "INSTAGRAM"
            instagramTxtFld?.textAlignment  =   .Left
            instagramTxtFld?.autocapitalizationType =   .AllCharacters
            instagramTxtFld?.keyboardType   =   UIKeyboardType.Default
            instagramTxtFld?.text           =   userDetails._instagramlink.uppercaseString
            instagramTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            instagramContainer!.addSubview(instagramTxtFld!)
            
            let kImgView9        =   UIImageView(frame: CGRectMake(0,(instagramContainer?.frame.size.height )! - 1,(instagramContainer?.frame.size.width )!,1.0))
            kImgView9.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            instagramContainer!.addSubview(kImgView9)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            

            let kImgView0    =   UIImageView(frame: CGRectMake(25, 20, 30, 30))
            kImgView0.userInteractionEnabled =   true
            kImgView0.contentMode    =   .ScaleAspectFit
            kScrollView.addSubview(kImgView0)
            
            if (kType == 1)
            {
                kImgView0.image  =   UIImage(named: "profile1.png")
            }
            else if (kType == 2)
            {
                kImgView0.image  =   UIImage(named: "work.png")
            }

            kScrollView.contentSize =   CGSizeMake(self.contentView.frame.size.width, kStrtY)
            if (kStrtY > kScrollView.frame.size.height)
            {
                let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kStrtY - 60))
                imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
                kScrollView.addSubview(imgView)
            }
            else
            {
                let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kScrollView.frame.size.height - 60))
                imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
                kScrollView.addSubview(imgView)
            }

        }
        else if (kType == 2)
        {
            var kStrtY : CGFloat    =   20.0
            primaryroleContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(primaryroleContainer!)
            
            let descLbl1         =   UILabel(frame: CGRectMake(0,0, (primaryroleContainer?.frame.size.width )! , 20))
            descLbl1.textColor   =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl1.textAlignment   =   .Left
            descLbl1.text        =   "PRIMARY ROLE"
            primaryroleContainer!.addSubview(descLbl1)
            
            primaryroleTxtFld                 =   UITextField(frame: CGRectMake(0,20,(primaryroleContainer?.frame.size.width )!,20))
            primaryroleTxtFld!.delegate       =   self
            primaryroleTxtFld?.placeholder    =   "PRIMARY ROLE"
            primaryroleTxtFld?.textColor    =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            primaryroleTxtFld?.enabled      =   false
            primaryroleTxtFld?.textAlignment  =   .Left
            primaryroleTxtFld?.autocapitalizationType =   .AllCharacters
            primaryroleTxtFld?.keyboardType   =   UIKeyboardType.Default
            primaryroleTxtFld?.text           =   userDetails._specialitydesc.uppercaseString
            primaryroleTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            primaryroleContainer!.addSubview(primaryroleTxtFld!)
            
            let kImgView1        =   UIImageView(frame: CGRectMake(0,(primaryroleContainer?.frame.size.height )! - 1,(primaryroleContainer?.frame.size.width )!,1.0))
            kImgView1.backgroundColor    =   UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1)
            primaryroleContainer!.addSubview(kImgView1)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            addRoleContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(addRoleContainer!)
            
            let descLbl3         =   UILabel(frame: CGRectMake(0,0, (addRoleContainer?.frame.size.width )! , 20))
            descLbl3.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl3.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl3.textAlignment   =   .Left
            descLbl3.text        =   "ADDITIONAL ROLE"
            addRoleContainer!.addSubview(descLbl3)
            
            addRoleTxtField                 =   UITextField(frame: CGRectMake(0,20,(addRoleContainer?.frame.size.width )!,20))
            addRoleTxtField!.delegate       =   self
            addRoleTxtField?.placeholder    =   "ADDITIONAL ROLE"
            addRoleTxtField?.textAlignment  =   .Left
            addRoleTxtField?.autocapitalizationType =   .AllCharacters
            addRoleTxtField?.keyboardType   =   UIKeyboardType.Default
            addRoleTxtField?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            addRoleContainer!.addSubview(addRoleTxtField!)
            
            let kArray2  =   userDetails._addRoleIds.componentsSeparatedByString(",")
            var kStringApp2  =   ""
            for j in 0 ..< kArray2.count
            {
                if (kArray2[j] != "")
                {
                    kStringApp2 =   kStringApp2 + userDetails._addRolesDict[kArray2[j]]!.uppercaseString + ", "
                }
                
            }
            addRoleTxtField?.text =   String(kStringApp2.characters.dropLast(2))
            
            let kImgView3        =   UIImageView(frame: CGRectMake(0,(addRoleContainer?.frame.size.height )! - 1,(addRoleContainer?.frame.size.width )!,1.0))
            kImgView3.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            addRoleContainer!.addSubview(kImgView3)
            
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            
            addSpecContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            kScrollView.addSubview(addSpecContainer!)
            
            let descLbl4         =   UILabel(frame: CGRectMake(0,0, (addSpecContainer?.frame.size.width )! , 20))
            descLbl4.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl4.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl4.textAlignment   =   .Left
            descLbl4.text        =   "SPECIALITY"
            addSpecContainer!.addSubview(descLbl4)
            
            addSpecTxtFld                 =   UITextField(frame: CGRectMake(0,20,(addSpecContainer?.frame.size.width )!,20))
            addSpecTxtFld!.delegate       =   self
            addSpecTxtFld?.placeholder    =   "ADDITIONAL SPECIALITY"
            addSpecTxtFld?.textAlignment  =   .Left
            addSpecTxtFld?.autocapitalizationType =   .AllCharacters
            addSpecTxtFld?.keyboardType   =   UIKeyboardType.Default
            addSpecTxtFld?.text           =   ""
            addSpecTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            addSpecContainer!.addSubview(addSpecTxtFld!)
            
            let kArray1  =   userDetails._addSpecIds.componentsSeparatedByString(",")
            
            var kStringApp1  =   ""
            for j in 0 ..< kArray1.count
            {
                if (kArray1[j] != "")
                {
                    kStringApp1 =   kStringApp1 + userDetails._specialitiesDict[kArray1[j]]!.uppercaseString + ", "
                }
 
            }
            addSpecTxtFld?.text =   String(kStringApp1.characters.dropLast(2))
            
            let kImgView4        =   UIImageView(frame: CGRectMake(0,(addSpecContainer?.frame.size.height )! - 1,(addSpecContainer?.frame.size.width )!,1.0))
            kImgView4.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            addSpecContainer!.addSubview(kImgView4)
            
            kStrtY      =   (addSpecContainer?.frame.origin.y)! + (addSpecContainer?.frame.size.height)! + 20.0
            
            extraContStrtY  =   kStrtY
            
            let kImgView0    =   UIImageView(frame: CGRectMake(25, 20, 30, 30))
            kImgView0.userInteractionEnabled =   true
            kImgView0.contentMode    =   .ScaleAspectFit
            kScrollView.addSubview(kImgView0)
            
            if (kType == 1)
            {
                kImgView0.image  =   UIImage(named: "profile1.png")
            }
            else if (kType == 2)
            {
                kImgView0.image  =   UIImage(named: "work.png")
            }
            
            kScrollView.contentSize =   CGSizeMake(self.contentView.frame.size.width, kStrtY)
            if (kStrtY > kScrollView.frame.size.height)
            {
                let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kStrtY - 60))
                imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
                kScrollView.addSubview(imgView)
            }
            else
            {
                let imgView     =   UIImageView(frame: CGRectMake(40, 60, 1, kScrollView.frame.size.height - 60))
                imgView.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
                kScrollView.addSubview(imgView)
            }
            
            if (self.userDetails._specialityCd.isEqualToString("MODEL") == true)
            {
                loadExtraEditingView(userDetails._gender.uppercaseString, kYpt: kStrtY, scrView: kScrollView)
            }

        }
    }
    
    func loadExtraEditingView (kType : String , kYpt : CGFloat , scrView : UIScrollView) {
        
        
        self.extraViewContainer.removeFromSuperview()
        self.extraViewContainer     =   UIView()
        self.extraViewContainer.frame     =   CGRectMake(0,kYpt, self.view.frame.size.width , 0)
        scrView.addSubview(self.extraViewContainer)
        var kStrtY : CGFloat    =   0.0
        
        
        genderContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        extraViewContainer.addSubview(genderContainer!)
        
        
        let descLbl20         =   UILabel(frame: CGRectMake(0,0, (genderContainer?.frame.size.width )! , 20))
        descLbl20.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl20.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl20.textAlignment   =   .Left
        descLbl20.text        =   "GENDER"
        genderContainer!.addSubview(descLbl20)
        
        let items = ["MALE", "FEMALE"]
        
        genderSegment   =   nil
        
        let selectedAtt =   [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        genderSegment   =   UISegmentedControl(items: items)
        genderSegment?.frame    =   CGRectMake(0,20,(genderContainer?.frame.size.width )!, 40)
        genderSegment!.setTitleTextAttributes(selectedAtt, forState: UIControlState.Selected)
        genderSegment!.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        genderSegment?.addTarget(self, action: #selector(ProfileVC.genderSegmentSelected(_:)), forControlEvents: .ValueChanged)
        
        if (kType == "MALE")
        {
            genderSegment?.selectedSegmentIndex = 0
        }
        else
        {
            genderSegment?.selectedSegmentIndex = 1
        }
        
        genderContainer!.addSubview(genderSegment!)
        genderSegment?.tintColor    =   UIColor.blackColor()

        
        kStrtY      =   kStrtY + 60.0 + 20.0
        
        heightContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        extraViewContainer.addSubview(heightContainer!)
        
        let descLbl1         =   UILabel(frame: CGRectMake(0,0, (heightContainer?.frame.size.width )! , 20))
        descLbl1.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl1.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl1.textAlignment   =   .Left
        descLbl1.text        =   "HEIGHT"
        heightContainer!.addSubview(descLbl1)
        
        heightTxtFld                 =   UITextField(frame: CGRectMake(0,20,(heightContainer?.frame.size.width )!,20))
        heightTxtFld!.delegate       =   self
        heightTxtFld?.placeholder    =   "HEIGHT"
        heightTxtFld?.textAlignment  =   .Left
        heightTxtFld?.autocapitalizationType =   .AllCharacters
        heightTxtFld?.keyboardType   =   UIKeyboardType.NumbersAndPunctuation
        heightTxtFld?.text           =   userDetails._height.uppercaseString
        heightTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        heightContainer!.addSubview(heightTxtFld!)
        
        let kImgView1        =   UIImageView(frame: CGRectMake(0,(heightContainer?.frame.size.height )! - 1,(heightContainer?.frame.size.width )!,1.0))
        kImgView1.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        heightContainer!.addSubview(kImgView1)
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        if (kType == "MALE")
        {
            pantsizeContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            extraViewContainer.addSubview(pantsizeContainer!)
            
            let descLbl2         =   UILabel(frame: CGRectMake(0,0, (pantsizeContainer?.frame.size.width )! , 20))
            descLbl2.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl2.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl2.textAlignment   =   .Left
            descLbl2.text        =   "PANT SIZE"
            pantsizeContainer!.addSubview(descLbl2)
            
            pantsizeTxtFld                 =   UITextField(frame: CGRectMake(0,20,(pantsizeContainer?.frame.size.width )!,20))
            pantsizeTxtFld!.delegate       =   self
            pantsizeTxtFld?.placeholder    =   "PANT SIZE"
            pantsizeTxtFld?.textAlignment  =   .Left
            pantsizeTxtFld?.autocapitalizationType =   .AllCharacters
            pantsizeTxtFld?.keyboardType   =   UIKeyboardType.NumbersAndPunctuation
            pantsizeTxtFld?.text           =   userDetails._pantsize.uppercaseString
            pantsizeTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            pantsizeContainer!.addSubview(pantsizeTxtFld!)
            
            let kImgView2        =   UIImageView(frame: CGRectMake(0,(pantsizeContainer?.frame.size.height )! - 1,(pantsizeContainer?.frame.size.width )!,1.0))
            kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            pantsizeContainer!.addSubview(kImgView2)
            kStrtY      =   kStrtY + 40.0 + 20.0
        }
        else
        {
            bustContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            extraViewContainer.addSubview(bustContainer!)
            
            let descLbl2         =   UILabel(frame: CGRectMake(0,0, (bustContainer?.frame.size.width )! , 20))
            descLbl2.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl2.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl2.textAlignment   =   .Left
            descLbl2.text        =   "bust".uppercaseString
            bustContainer!.addSubview(descLbl2)
            
            bustTxtFld                 =   UITextField(frame: CGRectMake(0,20,(bustContainer?.frame.size.width )!,20))
            bustTxtFld!.delegate       =   self
            bustTxtFld?.placeholder    =   "bust".uppercaseString
            bustTxtFld?.textAlignment  =   .Left
            bustTxtFld?.autocapitalizationType =   .AllCharacters
            bustTxtFld?.keyboardType   =   UIKeyboardType.NumbersAndPunctuation
            bustTxtFld?.text           =   userDetails._bust.uppercaseString
            bustTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            bustContainer!.addSubview(bustTxtFld!)
            
            let kImgView2        =   UIImageView(frame: CGRectMake(0,(bustContainer?.frame.size.height )! - 1,(bustContainer?.frame.size.width )!,1.0))
            kImgView2.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            bustContainer!.addSubview(kImgView2)
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            waistContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            extraViewContainer.addSubview(waistContainer!)
            
            let descLbl3         =   UILabel(frame: CGRectMake(0,0, (waistContainer?.frame.size.width )! , 20))
            descLbl3.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl3.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl3.textAlignment   =   .Left
            descLbl3.text        =   "waist".uppercaseString
            waistContainer!.addSubview(descLbl3)
            
            waistTxtFld                 =   UITextField(frame: CGRectMake(0,20,(waistContainer?.frame.size.width )!,20))
            waistTxtFld!.delegate       =   self
            waistTxtFld?.placeholder    =   "waist".uppercaseString
            waistTxtFld?.textAlignment  =   .Left
            waistTxtFld?.autocapitalizationType =   .AllCharacters
            waistTxtFld?.keyboardType   =   UIKeyboardType.NumbersAndPunctuation
            waistTxtFld?.text           =   userDetails._waist.uppercaseString
            waistTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            waistContainer!.addSubview(waistTxtFld!)
            
            let kImgView3        =   UIImageView(frame: CGRectMake(0,(waistContainer?.frame.size.height )! - 1,(waistContainer?.frame.size.width )!,1.0))
            kImgView3.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            waistContainer!.addSubview(kImgView3)
            kStrtY      =   kStrtY + 40.0 + 20.0
            
            hipsContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
            extraViewContainer.addSubview(hipsContainer!)
            
            let descLbl4         =   UILabel(frame: CGRectMake(0,0, (hipsContainer?.frame.size.width )! , 20))
            descLbl4.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
            descLbl4.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
            descLbl4.textAlignment   =   .Left
            descLbl4.text        =   "hips".uppercaseString
            hipsContainer!.addSubview(descLbl4)
            
            hipsTxtFld                 =   UITextField(frame: CGRectMake(0,20,(hipsContainer?.frame.size.width )!,20))
            hipsTxtFld!.delegate       =   self
            hipsTxtFld?.placeholder    =   "hips".uppercaseString
            hipsTxtFld?.textAlignment  =   .Left
            hipsTxtFld?.autocapitalizationType =   .AllCharacters
            hipsTxtFld?.keyboardType   =   UIKeyboardType.NumbersAndPunctuation
            hipsTxtFld?.text           =   userDetails._hips.uppercaseString
            hipsTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
            hipsContainer!.addSubview(hipsTxtFld!)
            
            let kImgView4        =   UIImageView(frame: CGRectMake(0,(hipsContainer?.frame.size.height )! - 1,(hipsContainer?.frame.size.width )!,1.0))
            kImgView4.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
            hipsContainer!.addSubview(kImgView4)
            kStrtY      =   kStrtY + 40.0 + 20.0

        }
        
        shoeContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        extraViewContainer.addSubview(shoeContainer!)
        
        let descLbl5         =   UILabel(frame: CGRectMake(0,0, (shoeContainer?.frame.size.width )! , 20))
        descLbl5.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl5.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl5.textAlignment   =   .Left
        descLbl5.text        =   "shoe".uppercaseString
        shoeContainer!.addSubview(descLbl5)
        
        shoeTxtFld                 =   UITextField(frame: CGRectMake(0,20,(shoeContainer?.frame.size.width )!,20))
        shoeTxtFld!.delegate       =   self
        shoeTxtFld?.placeholder    =   "shoe".uppercaseString
        shoeTxtFld?.textAlignment  =   .Left
        shoeTxtFld?.autocapitalizationType =   .AllCharacters
        shoeTxtFld?.keyboardType   =   UIKeyboardType.NumbersAndPunctuation
        shoeTxtFld?.text           =   userDetails._shoe.uppercaseString
        shoeTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        shoeContainer!.addSubview(shoeTxtFld!)
        
        let kImgView5        =   UIImageView(frame: CGRectMake(0,(shoeContainer?.frame.size.height )! - 1,(shoeContainer?.frame.size.width )!,1.0))
        kImgView5.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        shoeContainer!.addSubview(kImgView5)
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        
        hairContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        extraViewContainer.addSubview(hairContainer!)
        
        let descLbl6         =   UILabel(frame: CGRectMake(0,0, (hairContainer?.frame.size.width )! , 20))
        descLbl6.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl6.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl6.textAlignment   =   .Left
        descLbl6.text        =   "hair".uppercaseString
        hairContainer!.addSubview(descLbl6)
        
        hairTxtFld                 =   UITextField(frame: CGRectMake(0,20,(hairContainer?.frame.size.width )!,20))
        hairTxtFld!.delegate       =   self
        hairTxtFld?.placeholder    =   "hair".uppercaseString
        hairTxtFld?.textAlignment  =   .Left
        hairTxtFld?.autocapitalizationType =   .AllCharacters
        hairTxtFld?.keyboardType   =   UIKeyboardType.Default
        hairTxtFld?.text           =   userDetails._hairColor.uppercaseString
        hairTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        hairContainer!.addSubview(hairTxtFld!)
        
        let kImgView6        =   UIImageView(frame: CGRectMake(0,(hairContainer?.frame.size.height )! - 1,(hairContainer?.frame.size.width )!,1.0))
        kImgView6.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        hairContainer!.addSubview(kImgView6)
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        
        eyeContainer  =   UIView(frame: CGRectMake(80, kStrtY, self.view.frame.size.width - 80 - 20, 40))
        extraViewContainer.addSubview(eyeContainer!)
        
        let descLbl7         =   UILabel(frame: CGRectMake(0,0, (eyeContainer?.frame.size.width )! , 20))
        descLbl7.textColor   =   UIColor(red: 0.65, green: 0.65, blue: 0.65, alpha: 1)
        descLbl7.font        =   UIFont(name: Gillsans.Default.description, size: 12.0)
        descLbl7.textAlignment   =   .Left
        descLbl7.text        =   "eye".uppercaseString
        eyeContainer!.addSubview(descLbl7)
        
        eyeTxtFld                 =   UITextField(frame: CGRectMake(0,20,(eyeContainer?.frame.size.width )!,20))
        eyeTxtFld!.delegate       =   self
        eyeTxtFld?.placeholder    =   "eye".uppercaseString
        eyeTxtFld?.textAlignment  =   .Left
        eyeTxtFld?.autocapitalizationType =   .AllCharacters
        eyeTxtFld?.keyboardType   =   UIKeyboardType.Default
        eyeTxtFld?.text           =   userDetails._eyeColor.uppercaseString
        eyeTxtFld?.font           =   UIFont(name: Gillsans.Default.description, size: 15.0)
        eyeContainer!.addSubview(eyeTxtFld!)
        
        let kImgView7        =   UIImageView(frame: CGRectMake(0,(eyeContainer?.frame.size.height )! - 1,(eyeContainer?.frame.size.width )!,1.0))
        kImgView7.backgroundColor    =   UIColor(red: 0.764, green: 0.764, blue: 0.764, alpha: 1)
        eyeContainer!.addSubview(kImgView7)
        kStrtY      =   kStrtY + 40.0 + 20.0
        
        self.extraViewContainer.frame.size.height   =   kStrtY
        
        let imgView0     =   UIImageView(frame: CGRectMake(40, 0, 1, kStrtY))
        imgView0.backgroundColor =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        self.extraViewContainer.addSubview(imgView0)
        
        scrView.contentSize =   CGSizeMake(self.contentView.frame.size.width, kYpt + kStrtY)
    }
    
    func genderSegmentSelected (sender : UISegmentedControl) {
        
        let  kStr   =   self.genderSegment!.titleForSegmentAtIndex( self.genderSegment!.selectedSegmentIndex)!
        
        loadExtraEditingView(kStr, kYpt: extraContStrtY, scrView: kScrollView)
    }
    
    func selectedObjects (kArray : NSArray, kViewType: Int) {
        
        if (kViewType == 0) // Primary Role
        {
            if (kArray.count > 0)
            {
                let specObj: SpecialityObj      =   (kArray.objectAtIndex(0) as? SpecialityObj)!
                self.selectedPrimaryRoleId      =  specObj._specialityCd
                self.primaryroleTxtFld?.text    =   specObj._specialityDesc.uppercaseString
            }
        }
        else if (kViewType == 1) // Country
        {
            if (kArray.count > 0)
            {
                let specObj: CountryObj     =   (kArray.objectAtIndex(0) as? CountryObj)!
                self.selectedCountryId      =   specObj._countryId
                self.countryTxtFld?.text    =   specObj._countryName.uppercaseString
            }
            else
            {
                self.selectedCountryId      =   ""
                self.countryTxtFld?.text    =   ""
            }
        }
        else if (kViewType == 2) // Additional Role
        {
            if (kArray.count > 0)
            {
                var kStringApp  =   ""
                var kStringApp1  =   ""
                for kSubSpecObj in kArray  {
                    kStringApp =   kStringApp + String((kSubSpecObj as? SpecialityObj)!._specialityCd) + ","
                    kStringApp1 =   kStringApp1 + String((kSubSpecObj as? SpecialityObj)!._specialityDesc) + ", "
                    
                    self.userDetails._addRolesDict.setValue((kSubSpecObj as? SpecialityObj)!._specialityDesc, forKey:  String((kSubSpecObj as? SpecialityObj)!._specialityCd))
                }
                self.selectedAddRoleIDs =   kStringApp
                addRoleTxtField?.text =   String(kStringApp1.characters.dropLast(2)).uppercaseString
            }
            else
            {
                self.selectedAddRoleIDs  =   ""
                addRoleTxtField?.text =   ""
            }
        }
        else if (kViewType == 4) // Additinal Speciality
        {
            if (kArray.count > 0)
            {
                var kStringApp  =   ""
                var kStringApp1  =   ""
                for kSubSpecObj in kArray  {
                    kStringApp =   kStringApp + String((kSubSpecObj as? SpecialityObj)!._primaryId) + ","
                    kStringApp1 =   kStringApp1 + String((kSubSpecObj as? SpecialityObj)!._primaryDesc) + ", "
                    
                    self.userDetails._specialitiesDict.setValue((kSubSpecObj as? SpecialityObj)!._primaryDesc, forKey:  String((kSubSpecObj as? SpecialityObj)!._primaryId))
                }
                self.selectedAddSpecIDs  =   kStringApp
                addSpecTxtFld?.text =   String(kStringApp1.characters.dropLast(2)).uppercaseString
            }
            else
            {
                self.selectedAddSpecIDs  =   ""
                addSpecTxtFld?.text =   ""
            }
            
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let rect : CGRect    =   textField.convertRect(textField.frame, toView: scrollView!)
        let kFocusPoint : CGFloat =   150
        if (rect.origin.y > kFocusPoint)
        {
            scrollView?.setContentOffset(CGPointMake(0, rect.origin.y - kFocusPoint), animated: true)
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if (textField == primaryroleTxtFld)
        {
            let optionsView     =   OptionsController()
            optionsView.kTitle  =   "Select primary role"
            optionsView.prevSelected    =   NSArray(object: self.selectedPrimaryRoleId)
            optionsView.delegate    =   self
            self.navigationController?.pushViewController(optionsView, animated: true)
            
            return false
        }
        if (textField == countryTxtFld)
        {
            let optionsView     =   OptionsController()
            optionsView.prevSelected    =   NSArray(object: self.selectedCountryId)
            optionsView.delegate    =   self
            optionsView.kTitle  =   "Select country"
            optionsView.viewType    =   1
            self.navigationController?.pushViewController(optionsView, animated: true)
            
            return false
        }
        
        if (textField == addRoleTxtField)
        {
            let optionsView     =   OptionsController()
            optionsView.kTitle  =   "Select additional role"
            optionsView.prevSelected    =   NSArray(object: self.selectedAddRoleIDs)
            optionsView.delegate    =   self
            optionsView.viewType    =   2
            optionsView.isSingleSelection   =   false
            self.navigationController?.pushViewController(optionsView, animated: true)
            
            return false
        }
        
        if (textField == addSpecTxtFld)
        {
            let optionsView     =   OptionsController()
            optionsView.kTitle  =   "Select speciality"
            optionsView.prevSelected    =   NSArray(object: self.selectedAddSpecIDs)
            optionsView.delegate    =   self
            optionsView.viewType    =   4
            optionsView.isSingleSelection   =   false
            self.navigationController?.pushViewController(optionsView, animated: true)
            
            return false
        }
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.characters.count + string.characters.count - range.length
        if (textField == phoneTxtFld) {
            return newLength <= 15
        }
        if (textField == zipTxtFld) {
            return newLength <= 10
        }
        
        if (textField == facebookTxtFld || textField == twitterTxtFld || textField == instagramTxtFld) {
            return newLength <= 100
        }
        return newLength <= 50
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if (textField == firstNameTxtFld)
        {
            lastNameTxtFld?.becomeFirstResponder()
        }
        else if (textField == lastNameTxtFld)
        {
            emailTxtFld?.becomeFirstResponder()
        }
        else if (textField == emailTxtFld)
        {
            primaryroleTxtFld?.becomeFirstResponder()
        }
        else if (textField == primaryroleTxtFld)
        {
            personalMottoTxtFld?.becomeFirstResponder()
        }
        else if (textField == personalMottoTxtFld)
        {
            websiteTxtFld?.becomeFirstResponder()
        }
        else if (textField == websiteTxtFld)
        {
            countryTxtFld?.becomeFirstResponder()
        }
        else if (textField == countryTxtFld)
        {
            cityTxtFld?.becomeFirstResponder()
        }
        else if (textField == cityTxtFld)
        {
            zipTxtFld?.becomeFirstResponder()
        }
        else if (textField == zipTxtFld)
        {
            facebookTxtFld?.becomeFirstResponder()
        }
        else if (textField == facebookTxtFld)
        {
            twitterTxtFld?.becomeFirstResponder()
        }
        else if (textField == twitterTxtFld)
        {
            instagramTxtFld?.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}


protocol OptionsControllerDelegate {
    func selectedObjects (kArray : NSArray, kViewType: Int)
}

class OptionsController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var specObjects : NSArray   =   NSArray()
    var tempObjects : NSArray   =   NSArray()
    var tbleView: UITableView?
    var kWidth : CGFloat?
    var isSingleSelection : Bool  =   true
    var selectedObjects : NSMutableArray    =   NSMutableArray()
    var delegate : OptionsControllerDelegate!  =   nil
    var prevSelected    =   NSArray()
    var viewType : Int  =   0 // 0 - Role, 1 - Country
    var kTitle: NSString    =   ""
    var kRoleID : NSString  =   ""
    var kPrimRoleId : NSString  =   ""
    var searchBar: UISearchBar!
    
    var itineraryId : NSString  =   ""
    var pbDate : NSString       =   ""
    var productionBookId : NSString =   ""
    var scheduleId : NSString   =   ""
    
    func backBtnTapped () {

        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func doneBtnTapped () {
        delegate.selectedObjects(self.selectedObjects, kViewType: viewType)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        let aBarButtonItem  =   UIBarButtonItem(title: "CANCEL", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ProfileVC.backBtnTapped))//UIBarButtonItem(customView: aButton)
        aBarButtonItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!], forState: UIControlState.Normal)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let disabledAtt =   [NSForegroundColorAttributeName: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        
        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(OptionsController.doneBtnTapped))
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
        if (viewType == 0)
        {
            loadPrimaryRoles()
        }
        else if (viewType == 2)
        {
            loadAdditionalRoles()
        }
        else if (viewType == 1)
        {
            loadCountrydetails()
        }
        else if (viewType == 3 || viewType == 4)
        {
            loadSpecialityDetails()
        }
        else if (viewType == 5)
        {
            loadConfirmedArtistsByDateDetails()
        }
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
       
        
        if (viewType == 0 || viewType == 2)
        {
            let predicate : NSPredicate =   NSPredicate(format: "SELF._specialityDesc contains[c] %@", argumentArray: [searchText])
            self.specObjects    =   tempObjects.filteredArrayUsingPredicate(predicate)
        }
        else if(viewType == 1)
        {
            let predicate : NSPredicate =   NSPredicate(format: "SELF._countryName contains[c] %@", argumentArray: [searchText])
            self.specObjects    =   tempObjects.filteredArrayUsingPredicate(predicate)
        }
        else if(viewType == 3 || viewType == 4)
        {
            let predicate : NSPredicate =   NSPredicate(format: "SELF._primaryDesc contains[c] %@", argumentArray: [searchText])
            self.specObjects    =   tempObjects.filteredArrayUsingPredicate(predicate)
        }
        else  if (viewType == 5)
        {
            let predicate : NSPredicate =   NSPredicate(format: "SELF._UserName contains[c] %@", argumentArray: [searchText])
            self.specObjects    =   tempObjects.filteredArrayUsingPredicate(predicate)
        }
        
        self.tbleView?.reloadData()
       
    }
    
    func loadAdditionalRoles () {
        
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
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID()] , forKeys: [kLS_CP_UserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Profile_getRole, parm: dict1, completion: { result , desc , code in
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
                            for kDict in sortedArray
                            {
                                self.searchBar.hidden   =   false
                                let specObj : SpecialityObj   =   SpecialityObj().setDetails(kDict as! NSDictionary)
                                
                                kTempArr.addObject(specObj)
                                
                                let kArray1  =   (self.prevSelected.objectAtIndex(0) as? NSString)!.componentsSeparatedByString(",")
                                
                                
                                for j in 0 ..< kArray1.count
                                {
                                    let kStringApp1 : String =   kArray1[j]
                                    if (kStringApp1 != "")
                                    {
                                        if (specObj._specialityCd == kStringApp1)
                                        {
                                            self.selectedObjects.addObject(specObj)
                                        }
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
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID()] , forKeys: [kLS_CP_UserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Profile_getRole, parm: dict1, completion: { result , desc , code in
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
                                
                                if (self.viewType == 2 && self.kPrimRoleId.isEqualToString(specObj._specialityCd as String))
                                {
                                    kTempArr.removeObject(specObj)
                                }
                                
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
    
    func loadCountrydetails () {
        
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
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID()] , forKeys: [kLS_CP_UserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Profile_getCountry, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_countryName as String, ascending: true)
                            let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                self.searchBar.hidden   =   false
                                let countryObj : CountryObj   =   CountryObj().setDetails(kDict as! NSDictionary)
                                
                                kTempArr.addObject(countryObj)
                                
                                for speObj in self.prevSelected {
                                    
                                    if ((speObj as? NSString)?.isEqualToString(countryObj._countryId as String) == true)
                                    {
                                        self.selectedObjects.addObject(countryObj)
                                        
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
    
    func loadSpecialityDetails () {
        
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
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),"%"] , forKeys: [kLS_CP_UserId,kLS_CP_roleId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Profile_getSpeciality, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_primaryDesc as String, ascending: true)
                            let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                self.searchBar.hidden   =   false
                                let specObj : SpecialityObj   =   SpecialityObj().setDetails(kDict as! NSDictionary)
                                
                                kTempArr.addObject(specObj)
                                
                                let kArray1  =   (self.prevSelected.objectAtIndex(0) as? NSString)!.componentsSeparatedByString(",")
                                
                                
                                for j in 0 ..< kArray1.count
                                {
                                    let kStringApp1 : String =   kArray1[j]
                                    if (kStringApp1 != "")
                                    {
                                        if (specObj._primaryId == Int(kStringApp1))
                                        {
                                            self.selectedObjects.addObject(specObj)
                                        }
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

    func loadConfirmedArtistsByDateDetails () {
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        self.view.addSubview(processView)
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
        noLbl.text       =   "No confirmed artist found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.view.addSubview(noLbl)
        noLbl.hidden    =   true
        
        var indexPath   =   NSIndexPath(forRow: 0, inSection: 0)
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),itineraryId,pbDate,productionBookId,scheduleId] , forKeys: [kLS_CP_userId,kLS_CP_itineraryId,kLS_CP_pbDate,kLS_CP_productionBookId,kLS_CP_scheduleId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Schedule_GetConfirmedArtistByDate, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_UserName as String, ascending: true)
                            let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                            
                            let kTempArr : NSMutableArray   =   NSMutableArray()
                            for kDict in sortedArray {
                                self.searchBar.hidden   =   false
                                let specObj : ConfirmedArtistObj   =   ConfirmedArtistObj().setDetails(kDict as! NSDictionary)
                                
                                kTempArr.addObject(specObj)
                                
                                
                                let kArray1  =   (self.prevSelected.objectAtIndex(0) as? NSString)!.componentsSeparatedByString(",")
                                
                                
                                for j in 0 ..< kArray1.count
                                {
                                    let kStringApp1 : String =   kArray1[j]
                                    if (kStringApp1 != "")
                                    {
                                        if (specObj._ArtistId.isEqualToString(kStringApp1) == true)
                                        {
                                            self.selectedObjects.addObject(specObj)
                                        }
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
                    MessageAlertView().showMessage("No confirmed artist found for this date.", kColor : kLS_MsgColor)
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
        
        
        var specObj : AnyObject?
        if (viewType == 0 || viewType == 2)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        }
        else  if (viewType == 1)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? CountryObj)!
        }
        else  if (viewType == 3 || viewType == 4)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        }
        else  if (viewType == 5)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? ConfirmedArtistObj)!
        }
        
        if (isSingleSelection == true)
        {
            if (specObj != nil && self.selectedObjects.containsObject(specObj!))
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
            
            if (specObj != nil && self.selectedObjects.containsObject(specObj!))
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
        
        
        if (viewType == 0 || viewType == 2)
        {
            descLbl.text       =   (specObj as? SpecialityObj)!._specialityDesc.uppercaseString
        }
        
        if(viewType == 1)
        {
            descLbl.text       =   (specObj as? CountryObj)!._countryName.uppercaseString
        }

        if(viewType == 3 || viewType == 4)
        {
            descLbl.text       =   (specObj as? SpecialityObj)!._primaryDesc.uppercaseString
        }
        else  if (viewType == 5)
        {
            descLbl.text       =   (specObj as? ConfirmedArtistObj)!._UserName.uppercaseString
        }
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        var specObj : AnyObject?
        if (viewType == 0 || viewType == 2)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        }
        else  if (viewType == 1)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? CountryObj)!
        }
        else  if (viewType == 3 || viewType == 4)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? SpecialityObj)!
        }
        else  if (viewType == 5)
        {
            specObj    =   (specObjects.objectAtIndex(indexPath.row) as? ConfirmedArtistObj)!
        }
        
        
        
        if (isSingleSelection == true)
        {
            if (viewType == 2)
            {
                if (self.selectedObjects.containsObject(specObj!))
                {
                    self.selectedObjects.removeObject(specObj!)
                }
                else
                {
                    self.selectedObjects.removeAllObjects()
                    self.selectedObjects.addObject(specObj!)
                }
            }
            else
            {
                self.selectedObjects.removeAllObjects()
                self.selectedObjects.addObject(specObj!)
            }
        }
        else
        {
            if (self.selectedObjects.containsObject(specObj!))
            {
                self.selectedObjects.removeObject(specObj!)
            }
            else
            {
                self.selectedObjects.addObject(specObj!)
            }
        }
         tableView.reloadData()
    }
    
}

//Not using now
class MyPortfolioView: UIView, FeedObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout {
    
    var collView: UICollectionView?
    var kWidth : CGFloat?
    var portObjs : NSArray  =   NSArray()
    var viewController : UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor   =   UIColor.whiteColor()
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.frame.size.width - (3 * kSpac)) / 2
        
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = kSpac
        layout.minimumInteritemSpacing = kSpac
        
        layout.sectionInset = UIEdgeInsets(top: kSpac, left: kSpac, bottom: kSpac, right: kSpac)
        
        collView = UICollectionView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), collectionViewLayout: layout)
        collView!.dataSource   = self
        collView!.delegate     = self
        collView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collView!.registerClass(FeedCollViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        collView!.backgroundColor = UIColor.whiteColor()
        self.addSubview(collView!)
    }
    
    func loadDetails () {
        
        let noLbl        =   UILabel(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        noLbl.text       =   "No portfolio found."
        noLbl.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noLbl.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noLbl.textAlignment  =   .Center
        self.addSubview(noLbl)
        
        noLbl.hidden    =   true
        let processView     =   ProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView)
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),getUserID()] , forKeys: [kLS_CP_UserId,kLS_CP_StoryUserId])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Story_StoryList, parm: dict1, completion: { result , desc , code in
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
                            let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_PortfolioName as String, ascending: true)
                            let sortedArray: NSArray = NSArray(array: kArr as! NSArray).sortedArrayUsingDescriptors([brandDescriptor])
                            
                            let kTempArr: NSMutableArray            =   NSMutableArray()
                            
                            for  kDictionary in sortedArray {
                                let callSheet: PortfolioObj    =   PortfolioObj().setDetails(kDictionary as! NSDictionary, kDelegate: self as FeedObjDelegate, kImgWidth: self.kWidth!)
                                kTempArr.addObject(callSheet)
                            }
                            
                            self.portObjs   =   NSArray(array: kTempArr)
                        }
                    }
                }
                if (isSuccess == false)
                {
                    noLbl.hidden    =   false
                }
            }
            else
            {
                noLbl.hidden    =   false
                if((desc as NSString).isKindOfClass(NSNull) == false)
                {
                    noLbl.text      =   desc
                }
            }
            
            self.collView?.reloadData()
        })
        
    }
    
    func feedImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return portObjs.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let portObj: PortfolioObj    =   portObjs.objectAtIndex(indexPath.row) as! PortfolioObj
        return CGSize(width: portObj._imgWidth, height: portObj._imgHeight + 40)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! FeedCollViewCell
        
        let portObj: PortfolioObj    =   portObjs.objectAtIndex(indexPath.row) as! PortfolioObj
        portObj._delegate       =   self
        cell.bgImg.frame        =   CGRect(x: 0, y: 0, width: portObj._imgWidth , height: portObj._imgHeight)
        cell.bgImg.image        =   UIImage()
        cell.descLbl!.frame     =  CGRectMake(3, cell.frame.size.height - 40, cell.frame.size.width - 3, 40)
        cell.backgroundColor    =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        cell.descLbl?.text      =   (portObj._Name as String).uppercaseString
        cell.descLbl?.font      =   UIFont(name: Gillsans.Default.description, size: 15.0)
        cell.processView?.hidden    =   false
        if (portObj._isThumbImgDownloadIntiated == false)
        {
            portObj.downloadThumbImg()
        }
        if ((portObj._isThumbImgDownloadIntiated) == true && (portObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   portObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let feedView    =   PortDescVC()
        feedView.portObj      =   portObjs.objectAtIndex(indexPath.row) as? PortfolioObj
        self.viewController!.navigationController?.pushViewController(feedView, animated: true)
    }
}

