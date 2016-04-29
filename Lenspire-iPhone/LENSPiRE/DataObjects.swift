//
//  DataObjects.swift
//  Lenspire
//
//  Created by Thulasi on 02/09/15.
//  Copyright (c) 2015 Nesh. All rights reserved.
//

import Foundation

// MARK: - LoginDetails -

class LoginDetails: NSObject {
    var _authorizationToken : NSString  =   ""
    var _collaboratorAccess : Bool      =   true
    var _contributorAccess  : Bool      =   true
    var _createStoryboard   : Int       =   0
    var _email              : NSString  =   ""
    var _feedAccess         : Bool      =   true
    var _firstName          : NSString  =   ""
    var _followAccess       : Bool      =   true
    var _followerAccess     : Bool      =   true
    var _lastName           : NSString  =   ""
    var _location           : NSString  =   ""
    var _planCode           : Int       =   0
    var _planName           : NSString  =   ""
    var _portfolioAccess    : Bool      =   true
    var _primaryDesc        : NSString  =   ""
    var _secondaryDesc      : NSString  =   ""
    var _solicitationAccess : Bool      =   true
    var _spaceUsed          : NSString  =   ""
    var _specialityDesc     : NSString  =   ""
    var _userId             : NSString  =   ""
    var _winkAccess         : Bool      =   true
    var _specialityRole     : NSString  =   ""
    var _secondaryId        : NSString  =   ""
    var _specialityCode     : NSString  =   ""
    var _userprofileImg     : NSString  =   ""
    var _storageSpaceBytes  : Int       =   0
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _delegate   : FeedObjDelegate!   =   nil
    var _thumbImg          : UIImage   =   UIImage()
    
    func setDetails (kDict: NSDictionary, kDelegate: FeedObjDelegate) -> LoginDetails {
        _authorizationToken =   (checkAndSave(kDict, aKey: kLS_CP_authorizationToken , returnType: 0) as? NSString)!
        _collaboratorAccess =   (checkAndSave(kDict, aKey: kLS_CP_collaboratorAccess , returnType: 2) as? Bool)!
        _contributorAccess  =   (checkAndSave(kDict, aKey: kLS_CP_contributorAccess , returnType: 2) as? Bool)!
        _createStoryboard   =   (checkAndSave(kDict, aKey: kLS_CP_createStoryboard , returnType: 1) as? Int)!
        _email              =   (checkAndSave(kDict, aKey: kLS_CP_email , returnType: 0) as? NSString)!
        _feedAccess         =   (checkAndSave(kDict, aKey: kLS_CP_feedAccess , returnType: 2) as? Bool)!
        _firstName          =   (checkAndSave(kDict, aKey: kLS_CP_firstName , returnType: 0) as? NSString)!
        _followAccess       =   (checkAndSave(kDict, aKey: kLS_CP_followAccess , returnType: 2) as? Bool)!
        _followerAccess     =   (checkAndSave(kDict, aKey: kLS_CP_followerAccess , returnType: 2) as? Bool)!
        _lastName           =   (checkAndSave(kDict, aKey: kLS_CP_lastName , returnType: 0) as? NSString)!
        _location           =   (checkAndSave(kDict, aKey: kLS_CP_location , returnType: 0) as? NSString)!
        _planCode           =   (checkAndSave(kDict, aKey: kLS_CP_planCode , returnType: 1) as? Int)!
        _planName           =   (checkAndSave(kDict, aKey: kLS_CP_planName , returnType: 0) as? NSString)!
        _portfolioAccess    =   (checkAndSave(kDict, aKey: kLS_CP_portfolioAccess , returnType: 2) as? Bool)!
        _primaryDesc        =   (checkAndSave(kDict, aKey: kLS_CP_primaryDesc , returnType: 0) as? NSString)!
        _secondaryDesc      =   (checkAndSave(kDict, aKey: kLS_CP_secondaryDesc , returnType: 0) as? NSString)!
        _solicitationAccess =   (checkAndSave(kDict, aKey: kLS_CP_solicitationAccess , returnType: 2) as? Bool)!
        _spaceUsed          =   (checkAndSave(kDict, aKey: kLS_CP_spaceUsed , returnType: 0) as? NSString)!
        _specialityDesc     =   (checkAndSave(kDict, aKey: kLS_CP_specialityDesc , returnType: 0) as? NSString)!
        _specialityRole     =   (checkAndSave(kDict, aKey: kLS_CP_specialityRole , returnType: 0) as? NSString)!
        _userId             =   (checkAndSave(kDict, aKey: kLS_CP_userId , returnType: 0) as? NSString)!
        _winkAccess         =   true //(checkAndSave(kDict, aKey: kLS_CP_winkAccess , returnType: 0) as? Bool)!
        _secondaryId        =   (checkAndSave(kDict, aKey: kLS_CP_secondaryId , returnType: 0) as? NSString)!
        _specialityCode     =   (checkAndSave(kDict, aKey: kLS_CP_specialityCode , returnType: 0) as? NSString)!
        _storageSpaceBytes  =   (checkAndSave(kDict, aKey: kLS_CP_storageSpaceBytes , returnType: 1) as? Int)!
        _userprofileImg     =   (checkAndSave(kDict, aKey: kLS_CP_userprofileImg , returnType: 0) as? NSString)!
        
        _delegate       =   kDelegate
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)

        let imgName     =   self._userprofileImg.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        if (imgName.trim() == "")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            self._thumbImg      =    UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            }
        }
        
        return self
    }
    
    func updateImage () {
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        self._isThumbImgDownloadIntiated =   false
        self._isThumbImgDownloaded  =   false
        let imgName     =   self._userprofileImg.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        if (imgName.trim() == "")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            self._thumbImg      =    UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            }
        }
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        print("Request : \(NSDate()) :\(self._userprofileImg)")
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _userprofileImg as String)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
             
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded      =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    print("Response : \(NSDate()) :\(self._userprofileImg) \(Double(kData!.length)/1024.0)")
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._userprofileImg.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }
}

let kLS_CP_CallTime     : NSString  =   "CallTime"
let kLS_CP_PB_CastCd    : NSString  =   "PB_CastCd"
let kLS_CP_PB_CastDesc  : NSString  =   "PB_CastDesc"
let kLS_CP_PB_CastId    : NSString  =   "PB_CastId"
let kLS_CP_ScheduleDate : NSString  =   "ScheduleDate"
let kLS_CP_UserPhone    : NSString  =   "UserPhone"

class callSheetObj: NSObject {
    var _CallTime   : NSString  =   ""
    var _PB_Artist_AssignId : NSString  =   ""
    var _PB_CastCd  : NSString  =  ""
    var _PB_CastDesc    : NSString  =   ""
    var _PB_CastId  : NSString  =   ""
    var _ScheduleDate   : NSString  =   ""
    var _UserEmail  : NSString  =   ""
    var _UserId     : NSString  =   ""
    var _UserName   : NSString  =   ""
    var _UserPhone  : NSString  =   ""
    
    func setDetails (kDict: NSDictionary) -> callSheetObj {
        _CallTime       =   (checkAndSave(kDict, aKey: kLS_CP_CallTime , returnType: 0) as? NSString)!
        _PB_Artist_AssignId  =   (checkAndSave(kDict, aKey: kLS_CP_PB_Artist_AssignId , returnType: 0) as? NSString)!
        _PB_CastCd      =   (checkAndSave(kDict, aKey: kLS_CP_PB_CastCd , returnType: 0) as? NSString)!
        _PB_CastDesc    =   (checkAndSave(kDict, aKey: kLS_CP_PB_CastDesc , returnType: 0) as? NSString)!
        _PB_CastId      =   (checkAndSave(kDict, aKey: kLS_CP_PB_CastId , returnType: 0) as? NSString)!
        _ScheduleDate   =   (checkAndSave(kDict, aKey: kLS_CP_ScheduleDate , returnType: 0) as? NSString)!
        _UserEmail      =   (checkAndSave(kDict, aKey: kLS_CP_UserEmail , returnType: 0) as? NSString)!
        _UserId         =   (checkAndSave(kDict, aKey: kLS_CP_UserId , returnType: 0) as? NSString)!
        _UserName       =   (checkAndSave(kDict, aKey: kLS_CP_UserName , returnType: 0) as? NSString)!
        _UserPhone      =   (checkAndSave(kDict, aKey: kLS_CP_UserPhone , returnType: 0) as? NSString)!
        
        return self
    }
}

let kLS_CP_BillingInfo  : NSString  =   "BillingInfo"
let kLS_CP_CallSheetPassStatus  : NSString  =   "CallSheetPassStatus"
let kLS_CP_LogoId       : NSString  =   "LogoId"
let kLS_CP_LogoType     : NSString  =   "LogoType"
let kLS_CP_LogoURL      : NSString  =   "LogoURL"
let kLS_CP_ShootNotes   : NSString  =   "ShootNotes"

// MARK: - CallSheet -
class CallSheet: NSObject {
    var _AgencyName   : NSString  =   ""
    var _ArtistStatus : NSString  =   ""
    var _BrandName    : NSString  =   ""
    var _CreatedBy    : NSString  =   ""
    var _CreatedDate  : NSString  =   ""
    var _DeleteInd    : Int  =   0
    var _Description  : NSString  =   ""
    var _FinalizeStatus   : NSString  =   ""
    var _JobNumber    : NSString  =   ""
    var _Owner_UserEmail  : NSString  =   ""
    var _Owner_UserId     : NSString  =   ""
    var _Owner_UserName   : NSString  =   ""
    var _PB_FromDt    : NSString  =   ""
    var _PB_Id    : NSString  =   ""
    var _PB_ToDt  : NSString  =   ""
    var _ProjectName  : NSString  =   ""
    var _ScheduleStatus  : NSString  =   ""
    var _UsageTerms   : NSString  =   ""
    var _Usage_FromDt : NSString  =   ""
    var _Usage_ToDt   : NSString  =   ""
    
    
    var _BillingInfo    : NSString  =   ""
    var _CallSheetPassStatus    : NSString  =   ""
    var _LogoId         : NSString  =   ""
    var _LogoType       : NSString  =   ""
    var _LogoURL        : NSString  =   ""
    var _ShootNotes     : NSString  =   ""
    
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _delegate   : FeedObjDelegate!   =   nil
    dynamic var _thumbImg          : UIImage   =   UIImage()
    
    
    func setDetails (kDict: NSDictionary, kDelegate: FeedObjDelegate) -> CallSheet {
        
        _BillingInfo    =   (checkAndSave(kDict, aKey: kLS_CP_BillingInfo , returnType: 0) as? NSString)!
        _CallSheetPassStatus   =   (checkAndSave(kDict, aKey: kLS_CP_CallSheetPassStatus , returnType: 0) as? NSString)!
        _LogoId         =   (checkAndSave(kDict, aKey: kLS_CP_LogoId , returnType: 0) as? NSString)!
  //      _LogoType       =   (checkAndSave(kDict, aKey: kLS_CP_LogoType , returnType: 0) as? NSString)!
        _LogoURL        =   (checkAndSave(kDict, aKey: kLS_CP_LogoURL , returnType: 0) as? NSString)!
        _ShootNotes     =   (checkAndSave(kDict, aKey: kLS_CP_ShootNotes , returnType: 0) as? NSString)!
        
        _AgencyName   =   (checkAndSave(kDict, aKey: kLS_CP_AgencyName , returnType: 0) as? NSString)!
        _ArtistStatus =   (checkAndSave(kDict, aKey: kLS_CP_ArtistStatus , returnType: 0) as? NSString)!
        _BrandName    =   (checkAndSave(kDict, aKey: kLS_CP_BrandName , returnType: 0) as? NSString)!
        _CreatedBy    =   (checkAndSave(kDict, aKey: kLS_CP_CreatedBy , returnType: 0) as? NSString)!
        _CreatedDate  =   (checkAndSave(kDict, aKey: kLS_CP_CreatedDate , returnType: 0) as? NSString)!
        _DeleteInd    =   (checkAndSave(kDict, aKey: kLS_CP_DeleteInd , returnType: 1) as? Int)!
        _Description  =   (checkAndSave(kDict, aKey: kLS_CP_Description , returnType: 0) as? NSString)!
        _FinalizeStatus   =   (checkAndSave(kDict, aKey: kLS_CP_FinalizeStatus , returnType: 0) as? NSString)!
        _JobNumber    =   (checkAndSave(kDict, aKey: kLS_CP_JobNumber , returnType: 0) as? NSString)!
        _Owner_UserEmail  =   (checkAndSave(kDict, aKey: kLS_CP_Owner_UserEmail , returnType: 0) as? NSString)!
        _Owner_UserId     =   (checkAndSave(kDict, aKey: kLS_CP_Owner_UserId , returnType: 0) as? NSString)!
        _Owner_UserName   =   (checkAndSave(kDict, aKey: kLS_CP_Owner_UserName , returnType: 0) as? NSString)!
        _PB_FromDt    =   (checkAndSave(kDict, aKey: kLS_CP_PB_FromDt , returnType: 0) as? NSString)!
        _PB_Id    =   (checkAndSave(kDict, aKey: kLS_CP_PB_Id , returnType: 0) as? NSString)!
        _PB_ToDt  =   (checkAndSave(kDict, aKey: kLS_CP_PB_ToDt , returnType: 0) as? NSString)!
        _ProjectName  =   (checkAndSave(kDict, aKey: kLS_CP_ProjectName , returnType: 0) as? NSString)!
        _ScheduleStatus  =   (checkAndSave(kDict, aKey: kLS_CP_ScheduleStatus , returnType: 0) as? NSString)!
        _UsageTerms   =   (checkAndSave(kDict, aKey: kLS_CP_UsageTerms , returnType: 0) as? NSString)!
        _Usage_FromDt =   (checkAndSave(kDict, aKey: kLS_CP_Usage_FromDt , returnType: 0) as? NSString)!
        _Usage_ToDt   =   (checkAndSave(kDict, aKey: kLS_CP_Usage_ToDt , returnType: 0) as? NSString)!
        
        _delegate       =   kDelegate
        
        
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   self._LogoURL.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        if (imgName.trim() == "" || imgName.trim().characters.last == ".")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            self._thumbImg      =    UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            }
        }
     
        
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _LogoURL as String)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._LogoURL.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                    
                }
                else
                {
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }
}
// MARK: - CrewDetails -
class CrewDetails: NSObject {
    var _SpecialityDesc : NSString  =   ""
    var _SpecialityCd   : NSString  =   ""
    var _specialityId   : NSString  =   ""
    var _list   : NSArray   =   NSArray()
    
    func setDetails (kArray:NSArray, kDetails: NSArray) -> CrewDetails {
        
        _SpecialityDesc =   (kArray.objectAtIndex(1) as? NSString)!
        _SpecialityCd   =   (kArray.objectAtIndex(0) as? NSString)!
        _specialityId   =   (kArray.objectAtIndex(2) as? NSString)!
        if (kDetails.isKindOfClass(NSArray))
        {
            let kArr:NSMutableArray =   NSMutableArray()
            for  kDict in kDetails {
                kArr.addObject(CrewObject().setDetails(kDict as! NSDictionary))
            }
            _list           =   NSArray(array: kArr)
        }
        return self
    }
}
// MARK: - CrewObject -
class CrewObject: NSObject {
    var _artist         : NSString  =   ""
    var _artistName     : NSString  =   ""
    var _artist_CallTime    : NSString  =   ""
    var _artist_Status  : NSString  =   ""
    var _createdBy      : NSString  =   ""
    var _createdDate    : NSString  =   ""
    var _currencyFreq   : NSString  =   ""
    var _currencyRate   : Int       =   0
    var _currencyType   : NSString  =   ""
    var _email          : NSString  =   ""
    var _modifiedBy     : NSString  =   ""
    var _modifiedDate   : NSString  =   ""
    var _pb_Artist_AssignId    : NSString  =   ""
    var _pb_CastId      : NSString  =   ""
    var _pb_Id          : NSString  =   ""
    var _phone          : NSString  =   ""
    var _projectName    : NSString  =   ""
    var _shortlist      : NSString  =   ""
    var _specialityCd   : NSString  =   ""
    var _specialityDesc : NSString  =   ""
    var _specialityRole : NSString  =   ""
    
    func setDetails (kDict: NSDictionary) -> CrewObject {
        
        _artist             =   (checkAndSave(kDict, aKey: kLS_CP_artist , returnType: 0) as? NSString)!
        _artistName         =   (checkAndSave(kDict, aKey: kLS_CP_artistName , returnType: 0) as? NSString)!
        _artist_CallTime    =   (checkAndSave(kDict, aKey: kLS_CP_Artist_CallTime , returnType: 0) as? NSString)!
        _artist_Status      =   (checkAndSave(kDict, aKey: kLS_CP_Artist_Status , returnType: 0) as? NSString)!
        _createdBy          =   (checkAndSave(kDict, aKey: kLS_CP_createdBy , returnType: 0) as? NSString)!
        _createdDate        =   (checkAndSave(kDict, aKey: kLS_CP_createdDate , returnType: 0) as? NSString)!
        _currencyFreq       =   (checkAndSave(kDict, aKey: kLS_CP_CurrencyFreq , returnType: 0) as? NSString)!
        _currencyRate       =   (checkAndSave(kDict, aKey: kLS_CP_CurrencyRate , returnType: 1) as? Int)!
        _currencyType       =   (checkAndSave(kDict, aKey: kLS_CP_CurrencyType , returnType: 0) as? NSString)!
        _email              =   (checkAndSave(kDict, aKey: kLS_CP_email , returnType: 0) as? NSString)!
        _modifiedBy         =   (checkAndSave(kDict, aKey: kLS_CP_ModifiedBy , returnType: 0) as? NSString)!
        _modifiedDate       =   (checkAndSave(kDict, aKey: kLS_CP_ModifiedDate , returnType: 0) as? NSString)!
        _pb_Artist_AssignId =   (checkAndSave(kDict, aKey: kLS_CP_pb_Artist_AssignId , returnType: 0) as? NSString)!
        _pb_CastId          =   (checkAndSave(kDict, aKey: kLS_CP_pb_CastId , returnType: 0) as? NSString)!
        _pb_Id              =   (checkAndSave(kDict, aKey: kLS_CP_pb_Id , returnType: 0) as? NSString)!
        _phone              =   (checkAndSave(kDict, aKey: kLS_CP_phone , returnType: 0) as? NSString)!
        _projectName        =   (checkAndSave(kDict, aKey: kLS_CP_projectName , returnType: 0) as? NSString)!
        _shortlist          =   (checkAndSave(kDict, aKey: kLS_CP_shortlist , returnType: 0) as? NSString)!
        _specialityCd       =   (checkAndSave(kDict, aKey: kLS_CP_specialityCd , returnType: 0) as? NSString)!
        _specialityDesc     =   (checkAndSave(kDict, aKey: kLS_CP_specialityDesc , returnType: 0) as? NSString)!
        _specialityRole     =   (checkAndSave(kDict, aKey: kLS_CP_specialityRole , returnType: 0) as? NSString)!
        return self
    }
}
// MARK: - ScheduleEvent -
class ScheduleEvent: NSObject {
    var _artistCrew     : NSString  =   ""
    var _artistUserId     : NSString  =   ""
    var _artistUserName : NSString  =   ""
    var _createdBy      : NSString  =   ""
    var _createdDate    : NSString  =   ""
    var _deleteInd      : Int       =   0
    var _locationId     : NSString  =   ""
    var _locationName   : NSString  =   ""
    var _modifiedBy     : NSString  =   ""
    var _modifiedDate   : NSString  =   ""
    var _scheduleDate   : NSString  =   ""
    var _scheduleAction   : NSString  =   ""
    var _scheduleId     : NSString  =   ""
    var _scheduleTime   : NSString  =   ""
    var _scheduleNotes  : NSString  =   ""
    var _scheduleAttachment : NSString  =   ""
    var _sortOrder      : NSString  =   ""
    var _latLng      : NSString  =   ""
    
    func setDetails (kDict: NSDictionary) -> ScheduleEvent {
        
        _artistCrew     =   (checkAndSave(kDict, aKey: kLS_CP_artistCrew , returnType: 0) as? NSString)!
        _artistUserName   =   (checkAndSave(kDict, aKey: kLS_CP_artistUserName , returnType: 0) as? NSString)!
        _artistUserId   =   (checkAndSave(kDict, aKey: kLS_CP_artistUserId , returnType: 0) as? NSString)!
        _createdBy      =   (checkAndSave(kDict, aKey: kLS_CP_createdBy , returnType: 0) as? NSString)!
        _createdDate    =   (checkAndSave(kDict, aKey: kLS_CP_createdDate , returnType: 0) as? NSString)!
        _deleteInd      =   (checkAndSave(kDict, aKey: kLS_CP_deleteInd , returnType: 1) as? Int)!
        _locationId     =   (checkAndSave(kDict, aKey: kLS_CP_locationId , returnType: 0) as? NSString)!
        _locationName   =   (checkAndSave(kDict, aKey: kLS_CP_locationName , returnType: 0) as? NSString)!
        _modifiedBy     =   (checkAndSave(kDict, aKey: kLS_CP_ModifiedBy , returnType: 0) as? NSString)!
        _modifiedDate   =   (checkAndSave(kDict, aKey: kLS_CP_ModifiedDate , returnType: 0) as? NSString)!
        _scheduleDate   =   (checkAndSave(kDict, aKey: kLS_CP_scheduleDate , returnType: 0) as? NSString)!
        _scheduleTime   =   (checkAndSave(kDict, aKey: kLS_CP_scheduleTime , returnType: 0) as? NSString)!
        _scheduleAction =   (checkAndSave(kDict, aKey: kLS_CP_scheduleAction , returnType: 0) as? NSString)!
        _scheduleId     =   (checkAndSave(kDict, aKey: kLS_CP_scheduleId , returnType: 0) as? NSString)!
        _scheduleNotes  =   (checkAndSave(kDict, aKey: kLS_CP_scheduleNotes , returnType: 0) as? NSString)!
        _scheduleAttachment   =   (checkAndSave(kDict, aKey: kLS_CP_scheduleAttachment , returnType: 0) as? NSString)!
        _latLng      =   (checkAndSave(kDict, aKey: kLS_CP_latLng , returnType: 0) as? NSString)!
        _sortOrder      =   (checkAndSave(kDict, aKey: kLS_CP_sortOrder , returnType: 0) as? NSString)!
        return self
    }
}

// MARK: - FeedObjDelegate -
protocol FeedObjDelegate {
    func feedImageDownloadReqFinished ()
}
// MARK: - FeedObj -
class FeedObj: NSObject {
    var _coverImg       : NSString  =   ""
    var _PortfolioId    : NSString  =   ""
    var _SearchId       : NSString  =   ""
    var _SearchObjDate  : NSString  =   ""
    var _StoryId        : NSString  =   ""
    var _StoryName      : NSString  =   ""
    var _ThumbnailURL   : NSString  =   ""
    var _URL            : NSString  =   ""
    var _UserId         : NSString  =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _isImgDownloadIntiated : Bool  =   false
    var _isImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()
    var _Img          : UIImage   =   UIImage()
    var _delegate   : FeedObjDelegate!   =   nil
    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: FeedObjDelegate , kImgWidth: CGFloat) -> FeedObj {
        
        _coverImg       =   (checkAndSave(kDict, aKey: kLS_CP_CoverImg , returnType: 0) as? NSString)!
        _PortfolioId    =   (checkAndSave(kDict, aKey: kLS_CP_PortfolioId , returnType: 0) as? NSString)!
        _SearchId       =   (checkAndSave(kDict, aKey: kLS_CP_SearchId , returnType: 0) as? NSString)!
        _SearchObjDate  =   (checkAndSave(kDict, aKey: kLS_CP_SearchObjDate , returnType: 0) as? NSString)!
        _StoryId        =   (checkAndSave(kDict, aKey: kLS_CP_StoryId , returnType: 0) as? NSString)!
        _StoryName      =   (checkAndSave(kDict, aKey: kLS_CP_StoryName , returnType: 0) as? NSString)!
        _ThumbnailURL   =   (checkAndSave(kDict, aKey: kLS_CP_ThumbnailURL , returnType: 0) as? NSString)!
        _URL            =   (checkAndSave(kDict, aKey: kLS_CP_URL , returnType: 0) as? NSString)!
        _UserId         =   (checkAndSave(kDict, aKey: kLS_CP_UserId , returnType: 0) as? NSString)!
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   "\(self._ThumbnailURL)\(self._coverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            
            self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            
            self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
        }
        
        let paths1 = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName1     =   "\(self._URL)\(self._coverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath1 = (paths1[0] as String).stringByAppendingString("/\(imgName1)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath1))
        {
            self._isImgDownloadIntiated =   true
            self._isImgDownloaded  =   true
            
            self._Img =   UIImage(contentsOfFile: imgPath1)!
        }
        
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        print("Request : \(NSDate()) :\(_ThumbnailURL)\(_coverImg)")
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_ThumbnailURL)\(_coverImg)")!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    print("Response : \(NSDate()) :\(self._ThumbnailURL)\(self._coverImg)  \(Double(kData!.length)/1024.0)")
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._ThumbnailURL)\(self._coverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                    
                }
                else
                {
                    print("No Image")
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }
    func downloadImg () {
        self._isImgDownloadIntiated =   true
        print("Request : \(NSDate()) :\(_URL)\(_coverImg)")
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_URL)\(_coverImg)")!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isImgDownloadIntiated    =   false
            }
            else
            {
                self._isImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._Img =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._URL)\(self._coverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._Img, 1.0)?.writeToFile(imgPath, atomically: true)
                    
                }
                else
                {
                    print("No Image")
                    self._Img =   UIImage(named: "NoImage.png")!
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }
}
// MARK: - ViewStoryObj -
class ViewStoryObj: NSObject {
    var _BigItem        : NSString  =   ""
    var _Credits        : NSArray   =   []
    var _FileName       : NSString  =   ""
    var _ThumbnailURL   : NSString  =   ""
    var _URL            : NSString  =   ""
    var _UserId         : NSString  =   ""
    var _UserName       : NSString  =   ""
    var _UserRole       : NSString  =   ""
    var _isBigImage     : Bool      =   false
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _isImgDownloadIntiated : Bool  =   false
    var _isImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()
    var _Img          : UIImage   =   UIImage()
    var _delegate   : FeedObjDelegate!   =   nil
    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: FeedObjDelegate , kImgWidth: CGFloat) -> ViewStoryObj {
        
        _BigItem        =   (checkAndSave(kDict, aKey: kLS_CP_BigItem , returnType: 0) as? NSString)!
        
        let kTemp : AnyObject        =   checkAndSave(kDict, aKey: kLS_CP_Credits , returnType: 0)
        
        if (kTemp.isKindOfClass(NSString) == false)
        {
            let kMutArrr: NSMutableArray    =   NSMutableArray()
            for kDict1  in (kTemp as! NSArray) {
                let creditObj :CreditObj    =   CreditObj().setDetails(kDict1 as! NSDictionary)
                kMutArrr.addObject(creditObj)
            }
            _Credits    =   NSArray(array: kMutArrr)
        }
        
        
        _FileName       =   (checkAndSave(kDict, aKey: kLS_CP_FileName , returnType: 0) as? NSString)!
        _UserRole       =   (checkAndSave(kDict, aKey: kLS_CP_UserRole , returnType: 0) as? NSString)!
        _UserId         =   (checkAndSave(kDict, aKey: kLS_CP_UserId , returnType: 0) as? NSString)!
        _UserName       =   (checkAndSave(kDict, aKey: kLS_CP_UserName , returnType: 0) as? NSString)!
        _ThumbnailURL   =   (checkAndSave(kDict, aKey: kLS_CP_ThumbnailURL , returnType: 0) as? NSString)!
        _URL            =   (checkAndSave(kDict, aKey: kLS_CP_URL , returnType: 0) as? NSString)!
        _UserId         =   (checkAndSave(kDict, aKey: kLS_CP_UserId , returnType: 0) as? NSString)!
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        
        if (_BigItem.isEqualToString(kLS_CP_BigItem as String))
        {
            _isBigImage =   true
            _imgWidth   = (2 * kImgWidth) + 3.0
        }
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   "\(self._ThumbnailURL)\(self._FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            
            self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            
            self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
        }
        
        let imgName1     =   "\(self._URL)\(self._FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath1 = (paths[0] as String).stringByAppendingString("/\(imgName1)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath1))
        {
            self._isImgDownloadIntiated =   true
            self._isImgDownloaded  =   true
            
            self._Img =   UIImage(contentsOfFile: imgPath1)!
        }
        
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
  
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_ThumbnailURL)\(_FileName)")!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._ThumbnailURL)\(self._FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                    
                }
                else
                {
                    print("No Image")
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }
    
    func downloadImg () {
        self._isImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_URL)\(_FileName)")!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isImgDownloadIntiated    =   false
            }
            else
            {
                self._isImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._Img =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._URL)\(self._FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._Img, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._Img =   UIImage(named: "NoImage.png")!
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }
}
// MARK: - CreditObj -
class CreditObj: NSObject {
    var _CreditsId      : NSString  =   ""
    var _CreditsName    : NSString  =   ""
    var _roleDesc       : NSString  =   ""
    var _ArtistName     : NSString  =   ""
    var _SpecialityCd   : NSString  =   ""
    var _Artist         : NSString  =   ""
    var _SpecialityDesc : NSString  =   ""
    
    func setDetails (kDict: NSDictionary) -> CreditObj {
        
        _CreditsId      =   (checkAndSave(kDict, aKey: kLS_CP_CreditsId , returnType: 0) as? NSString)!
        let karr: NSArray   =   (checkAndSave(kDict, aKey: kLS_CP_CreditsName , returnType: 0) as? NSString)!.componentsSeparatedByString(" | ")
        if (karr.count > 1)
        {
            _CreditsName    =   karr.objectAtIndex(0) as! NSString
            _roleDesc       =   karr.objectAtIndex(1) as! NSString
        }
        _ArtistName     =   (checkAndSave(kDict, aKey: kLS_CP_ArtistName , returnType: 0) as? NSString)!
        _SpecialityCd   =   (checkAndSave(kDict, aKey: kLS_CP_SpecialityCd , returnType: 0) as? NSString)!
        _Artist         =   (checkAndSave(kDict, aKey: kLS_CP_Artist , returnType: 0) as? NSString)!
        _SpecialityDesc =   (checkAndSave(kDict, aKey: kLS_CP_SpecialityDesc , returnType: 0) as? NSString)!
        return self
    }
}

// MARK: - WinkBoardListObjDelegate -
protocol WinkBoardListObjDelegate {
    func ImageDownloadReqFinished ()
}

// MARK: - WinkBoardListObj -
class WinkBoardListObj: NSObject {
    var _Access      : NSString  =   ""
    var _CoverImg    : NSString  =   ""
    var _ThumbnailURL   : NSString  =   ""
    var _URL        : NSString  =   ""
    var _UserId     : NSString  =   ""
    var _UserName   : NSString  =   ""
    var _WinkboardDesc  : NSString  =   ""
    var _WinkboardId    : NSString  =   ""
    var _WinkboardName  : NSString  =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()
    var _isImgDownloadIntiated : Bool  =   false
    var _isImgDownloaded : Bool  =   false
    var _Img          : UIImage   =   UIImage()
    var _delegate   : WinkBoardListObjDelegate!   =   nil
    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: WinkBoardListObjDelegate , kImgWidth: CGFloat) -> WinkBoardListObj {
        
        _Access         =   (checkAndSave(kDict, aKey: kLS_CP_Access , returnType: 0) as? NSString)!
        _CoverImg       =   (checkAndSave(kDict, aKey: kLS_CP_CoverImg , returnType: 0) as? NSString)!
        _ThumbnailURL   =   (checkAndSave(kDict, aKey: kLS_CP_ThumbnailURL , returnType: 0) as? NSString)!
        _URL            =   (checkAndSave(kDict, aKey: kLS_CP_URL , returnType: 0) as? NSString)!
        _UserId         =   (checkAndSave(kDict, aKey: kLS_CP_UserId , returnType: 0) as? NSString)!
        _UserName       =   (checkAndSave(kDict, aKey: kLS_CP_UserName , returnType: 0) as? NSString)!
        _WinkboardDesc  =   (checkAndSave(kDict, aKey: kLS_CP_WinkboardDesc , returnType: 0) as? NSString)!
        _WinkboardId    =   (checkAndSave(kDict, aKey: kLS_CP_WinkboardId , returnType: 0) as? NSString)!
        _WinkboardName  =   (checkAndSave(kDict, aKey: kLS_CP_WinkboardName , returnType: 0) as? NSString)!
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   "\(self._ThumbnailURL)\(self._CoverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            
            self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            
            self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
        }
        
        let imgName1     =   "\(self._URL)\(self._CoverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath1 = (paths[0] as String).stringByAppendingString("/\(imgName1)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath1))
        {
            self._isImgDownloadIntiated =   true
            self._isImgDownloaded  =   true
            
            self._Img =   UIImage(contentsOfFile: imgPath1)!
        }
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_ThumbnailURL)\(_CoverImg)")!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                    
                    
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._ThumbnailURL)\(self._CoverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                }
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
    func downloadImg () {
        self._isImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_URL)\(_CoverImg)")!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isImgDownloadIntiated    =   false
            }
            else
            {
                self._isImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._Img =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._URL)\(self._CoverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._Img, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._Img =   UIImage(named: "NoImage.png")!
                    
                }
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
}

protocol SearchDataObjDelegate {
    func ImageDownloadReqFinished ()
}
// MARK: - SearchDataObj -
class SearchDataObj: NSObject {
    var _access   : NSString    =   ""
    var _creditedusers    : NSString  =   ""
    var _date     : NSString    =   ""
    var _desctag  : NSString    =   ""
    var _filename : NSString    =   ""
    var _userid   : NSString    =   ""
    var _loc      : NSString    =   ""
    var _ourl     : NSString    =   ""
    var _portfolioid  : NSString    =   ""
    var _portfolioname    : NSString    =   ""
    var _tags     : NSString    =   ""
    var _turl     : NSString    =   ""
    var _username     : NSString    =   ""
    var _userrole     : NSArray =  []
    var _sub_speciality : NSString  =   ""
    var _speciality : NSString      =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()
    var _isImgDownloadIntiated : Bool  =   false
    var _isImgDownloaded : Bool  =   false
    var _Img          : UIImage   =   UIImage()
    var _delegate   : SearchDataObjDelegate!   =   nil

    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: SearchDataObjDelegate, kImgWidth: CGFloat) -> SearchDataObj {
        _access           =   (checkAndSave(kDict, aKey: kLS_CP_access , returnType: 0) as? NSString)!
        _creditedusers  =   (checkAndSave(kDict, aKey: kLS_CP_creditedusers , returnType: 0) as? NSString)!
        _date           =   (checkAndSave(kDict, aKey: kLS_CP_date , returnType: 0) as? NSString)!
        _desctag        =   (checkAndSave(kDict, aKey: kLS_CP_desctag , returnType: 0) as? NSString)!
        _filename       =   (checkAndSave(kDict, aKey: kLS_CP_filename , returnType: 0) as? NSString)!
        _loc            =   (checkAndSave(kDict, aKey: kLS_CP_loc , returnType: 0) as? NSString)!
        _ourl           =   (checkAndSave(kDict, aKey: kLS_CP_ourl , returnType: 0) as? NSString)!
        _portfolioid    =   (checkAndSave(kDict, aKey: kLS_CP_portfolioid , returnType: 0) as? NSString)!
        _portfolioname  =   (checkAndSave(kDict, aKey: kLS_CP_portfolioname , returnType: 0) as? NSString)!
        _tags           =   (checkAndSave(kDict, aKey: kLS_CP_tags , returnType: 0) as? NSString)!
        _turl           =   (checkAndSave(kDict, aKey: kLS_CP_turl , returnType: 0) as? NSString)!
        _userid         =   (checkAndSave(kDict, aKey: kLS_CP_userid , returnType: 0) as? NSString)!
        _username       =   (checkAndSave(kDict, aKey: kLS_CP_username , returnType: 0) as? NSString)!
        _userrole       =   (checkAndSave(kDict, aKey: kLS_CP_userrole , returnType: 3) as? NSArray)!
        _sub_speciality =   (checkAndSave(kDict, aKey: kLS_CP_sub_speciality , returnType: 0) as? NSString)!
        _speciality     =   (checkAndSave(kDict, aKey: kLS_CP_speciality , returnType: 0) as? NSString)!
        
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   self._turl.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        if (imgName.trim() == "")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            self._thumbImg      =    UIImage(named: "NoImage.png")!
            
             self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
                 self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
            }
        }
        
        let imgName1     =   self._ourl.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath1 = (paths[0] as String).stringByAppendingString("/\(imgName1)")
        if (imgName1.trim() == "")
        {
            self._isImgDownloadIntiated =   true
            self._isImgDownloaded  =   true
            
            self._Img =   UIImage(named: "NoImage.png")!
             self._imgHeight =   (self._imgWidth / self._Img.size.width) * self._Img.size.height
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath1))
            {
                self._isImgDownloadIntiated =   true
                self._isImgDownloaded  =   true
                
                self._Img =   UIImage(contentsOfFile: imgPath1)!
                 self._imgHeight =   (self._imgWidth / self._Img.size.width) * self._Img.size.height
            }
        }
        
        return self
    }
    
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _turl as String)!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._turl.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                }
                self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
    func downloadImg () {
        self._isImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _ourl as String)!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isImgDownloadIntiated    =   false
            }
            else
            {
                self._isImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._Img =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._ourl.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._Img, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._Img =   UIImage(named: "NoImage.png")!
                    
                }
                self._imgHeight =   (self._imgWidth / self._Img.size.width) * self._Img.size.height
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }

}

protocol UserDetailsObjDelegate {
    func ImageDownloadReqFinished ()
}

// MARK: - UserDetailsObj -
class UserDetailsObj    : NSObject {
    var _activationFlag : NSString   =   ""
    var _authorizationToken     : NSString  =   ""
    var _countryId   : NSString  =   ""
    var _addSpecDesc   : NSString  =   ""
    var _addSpecCd   : NSString  =   ""
    var _countryName   : NSString  =   ""
    var _createdBy  : NSString  =   ""
    var _createdDate    : NSString  =   ""
    var _email      : NSString  =   ""
    var _enabled    : NSString       =   ""
    var _eyeColor   : NSString  =   ""
    var _failureFlag : NSString      =   ""
    var _firstName  : NSString  =   ""
    var _gender     : NSString  =   ""
    var _hairColor  : NSString  =   ""
    var _height     : NSString  =   ""
    var _lastName   : NSString  =   ""
    var _location   : NSString  =   ""
    var _middleName : NSString  =   ""
    var _modifiedBy : NSString  =   ""
    var _modifiedDate   : NSString  =   ""
    var _password   : NSString  =   ""
    var _phone      : NSString  =   ""
    var _planCd     : NSString  =   ""
    var _primaryId  : NSString  =   ""
    var _roleId     : NSString  =   ""
    var _secondaryId    : NSString  =   ""
    var _shoe       : NSString  =   ""
    var _spaceUsed  : NSString  =   ""
    var _specialityCd   : NSString  =   ""
    var _specialitydesc   : NSString  =   ""
    var _suit       : NSString  =   ""
    var _userId     : NSString  =   ""
    var _waist      : NSString  =   ""
    var _website    : NSString  =   ""
    var _weight     : NSString  =   ""
    var _zipCode    : NSString  =   ""
    var _bust       : NSString  =   ""
    var _city       : NSString  =   ""
    var _company    : NSString  =   ""
    var _contactemail   : NSString  =   ""
    var _specialityRole     : NSString  =   ""
    var _hips       : NSString  =   ""
    var _pantsize   : NSString  =   ""
    var _personalMotto  : NSString  =   ""
    var _signupstep     : NSString  =   ""
    var _sharemotto     : NSString  =   ""
    var _addSpecIds : NSString  =   ""
    var _addRoleIds : NSString  =   ""
    var _Specialtydetail : NSArray  =  NSArray()
    var _AdditionalRoles : NSArray  =  NSArray()
    var _userdefaultImg : NSString  =   ""
    var _specialitiesDict : NSMutableDictionary    =   NSMutableDictionary()
    var _addRolesDict : NSMutableDictionary    =   NSMutableDictionary()
    var _imageurl    : NSString     =   ""
    
    var _instagramlink : NSString   =   ""
    var _facebooklink : NSString    =   ""
    var _twitterlink  : NSString    =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()

    var _delegate   : UserDetailsObjDelegate!   =   nil
    
    func setDetails (kDict: NSDictionary, kDelegate: UserDetailsObjDelegate ) -> UserDetailsObj {
        _addRoleIds =   (checkAndSave(kDict, aKey: kLS_CP_addRoleIds , returnType: 0) as? NSString)!
        _addSpecIds =   (checkAndSave(kDict, aKey: kLS_CP_addSpecIds , returnType: 0) as? NSString)!
        _addSpecDesc =   (checkAndSave(kDict, aKey: kLS_CP_addSpecDesc , returnType: 0) as? NSString)!
         _addSpecCd =   (checkAndSave(kDict, aKey: kLS_CP_addSpecCd , returnType: 0) as? NSString)!
        _AdditionalRoles =   (checkAndSave(kDict, aKey: kLS_CP_AdditionalRoles , returnType: 3) as? NSArray)!
        _Specialtydetail =   (checkAndSave(kDict, aKey: kLS_CP_Specialtydetail , returnType: 3) as? NSArray)!
        _userdefaultImg =   (checkAndSave(kDict, aKey: kLS_CP_userdefaultImg , returnType: 0) as? NSString)!
        _bust           =   (checkAndSave(kDict, aKey: kLS_CP_bust , returnType: 0) as? NSString)!
        _city           =   (checkAndSave(kDict, aKey: kLS_CP_city , returnType: 0) as? NSString)!
        _company        =   (checkAndSave(kDict, aKey: kLS_CP_company , returnType: 0) as? NSString)!
        _contactemail   =   (checkAndSave(kDict, aKey: kLS_CP_contactemail , returnType: 0) as? NSString)!
        _hips           =   (checkAndSave(kDict, aKey: kLS_CP_hips , returnType: 0) as? NSString)!
        _pantsize       =   (checkAndSave(kDict, aKey: kLS_CP_pantsize , returnType: 0) as? NSString)!
        _personalMotto  =   (checkAndSave(kDict, aKey: kLS_CP_personalMotto , returnType: 0) as? NSString)!
        _signupstep     =   (checkAndSave(kDict, aKey: kLS_CP_signupstep , returnType: 0) as? NSString)!
        _sharemotto     =   (checkAndSave(kDict, aKey: kLS_CP_sharemotto , returnType: 0) as? NSString)!
        _userdefaultImg =   (checkAndSave(kDict, aKey: kLS_CP_userdefaultImg , returnType: 0) as? NSString)!
        _activationFlag =   (checkAndSave(kDict, aKey: kLS_CP_activationFlag , returnType: 0) as? NSString)!
        _countryId      =   (checkAndSave(kDict, aKey: kLS_CP_countryId , returnType: 0) as? NSString)!
        _countryName    =   (checkAndSave(kDict, aKey: kLS_CP_countryName , returnType: 0) as? NSString)!
        _createdBy      =   (checkAndSave(kDict, aKey: kLS_CP_createdBy , returnType: 0) as? NSString)!
        _createdDate    =   (checkAndSave(kDict, aKey: kLS_CP_createdDate , returnType: 0) as? NSString)!
        _email          =   (checkAndSave(kDict, aKey: kLS_CP_email , returnType: 0) as? NSString)!
        _enabled        =   (checkAndSave(kDict, aKey: kLS_CP_enabled , returnType: 0) as? NSString)!
        _eyeColor       =   (checkAndSave(kDict, aKey: kLS_CP_eyeColor , returnType: 0) as? NSString)!
        _failureFlag    =   (checkAndSave(kDict, aKey: kLS_CP_failureFlag , returnType: 0) as? NSString)!
        _firstName      =   (checkAndSave(kDict, aKey: kLS_CP_firstName , returnType: 0) as? NSString)!
        _gender         =   (checkAndSave(kDict, aKey: kLS_CP_gender , returnType: 0) as? NSString)!
        _hairColor      =   (checkAndSave(kDict, aKey: kLS_CP_hairColor , returnType: 0) as? NSString)!
        _height         =   (checkAndSave(kDict, aKey: kLS_CP_height , returnType: 0) as? NSString)!
        _lastName       =   (checkAndSave(kDict, aKey: kLS_CP_lastName , returnType: 0) as? NSString)!
        _location       =   (checkAndSave(kDict, aKey: kLS_CP_location , returnType: 0) as? NSString)!
        _middleName     =   (checkAndSave(kDict, aKey: kLS_CP_middleName , returnType: 0) as? NSString)!
        _modifiedBy     =   (checkAndSave(kDict, aKey: kLS_CP_modifiedBy , returnType: 0) as? NSString)!
        _modifiedDate   =   (checkAndSave(kDict, aKey: kLS_CP_modifiedDate , returnType: 0) as? NSString)!
        _password       =   (checkAndSave(kDict, aKey: kLS_CP_password , returnType: 0) as? NSString)!
        _phone          =   (checkAndSave(kDict, aKey: kLS_CP_phone , returnType: 0) as? NSString)!
        _planCd         =   (checkAndSave(kDict, aKey: kLS_CP_planCd , returnType: 0) as? NSString)!
        _primaryId      =   (checkAndSave(kDict, aKey: kLS_CP_primaryId , returnType: 0) as? NSString)!
        _roleId         =   (checkAndSave(kDict, aKey: kLS_CP_roleId , returnType: 0) as? NSString)!
        _secondaryId    =   (checkAndSave(kDict, aKey: kLS_CP_secondaryId , returnType: 0) as? NSString)!
        _shoe           =   (checkAndSave(kDict, aKey: kLS_CP_shoe , returnType: 0) as? NSString)!
        _spaceUsed      =   (checkAndSave(kDict, aKey: kLS_CP_spaceUsed , returnType: 0) as? NSString)!
        _specialityCd   =   (checkAndSave(kDict, aKey: kLS_CP_specialityCd , returnType: 0) as? NSString)!
        _specialitydesc =   (checkAndSave(kDict, aKey: kLS_CP_specialtydesc , returnType: 0) as? NSString)!
        if (GetAppDelegate().loginDetails != nil) {
            _specialityRole =   GetAppDelegate().loginDetails!._specialityRole
        }
        _suit           =   (checkAndSave(kDict, aKey: kLS_CP_suit , returnType: 0) as? NSString)!
        _userId         =   (checkAndSave(kDict, aKey: kLS_CP_userId , returnType: 0) as? NSString)!
        _waist          =   (checkAndSave(kDict, aKey: kLS_CP_waist , returnType: 0) as? NSString)!
        _website        =   (checkAndSave(kDict, aKey: kLS_CP_website , returnType: 0) as? NSString)!
        _weight         =   (checkAndSave(kDict, aKey: kLS_CP_weight , returnType: 0) as? NSString)!
        _zipCode        =   (checkAndSave(kDict, aKey: kLS_CP_zipCode , returnType: 0) as? NSString)!
        _imageurl       =   (checkAndSave(kDict, aKey: kLS_CP_imageurl , returnType: 0) as? NSString)!
        _instagramlink  =   (checkAndSave(kDict, aKey: kLS_CP_instagramlink, returnType: 0) as? NSString)!
        _facebooklink   =   (checkAndSave(kDict, aKey: kLS_CP_facebooklink, returnType: 0) as? NSString)!
        _twitterlink    =   (checkAndSave(kDict, aKey: kLS_CP_twitterlink, returnType: 0) as? NSString)!
        for kDict in _Specialtydetail {
            let key =   kDict.objectForKey("primaryId")!
            _specialitiesDict.setValue(kDict.objectForKey("primaryRoleCdDesc")!, forKey: key as! String)
            
        }
        for kDict in _AdditionalRoles {
            let key =   kDict.objectForKey("primaryRoleCd")!
            _addRolesDict.setValue(kDict.objectForKey("primaryRoleCdDesc")!, forKey: key as! String)
            
        }
        _delegate       =   kDelegate
        
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        
        let imgName     =   self._imageurl.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (imgName.trim() == "")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            
            self._thumbImg =   UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            }
        }
        
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: self._imageurl as String)!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._imageurl.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                }
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
}


// MARK: - WinkImgObjDelegate -
protocol WinkImgObjDelegate {
    func ImageDownloadReqFinished ()
}

// MARK: - WinkImgObj -
class WinkImgObj: NSObject {
    var _ArtistRole     : NSString  =   ""
    var _ArtistUserId   : NSString  =   ""
    var _ArtistUserName : NSString  =   ""
    var _FileName       : NSString  =   ""
    var _ThumbnailURL   : NSString  =   ""
    var _URL            : NSString  =   ""
    var _StoryId        :  NSString  =   ""
    var _WinkImageDesc  : NSString  =   ""
    var _WinkboardLike  : NSString  =   ""
    var _WinkedDateTime : NSString  =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()
    var _isImgDownloadIntiated : Bool  =   false
    var _isImgDownloaded : Bool  =   false
    var _Img          : UIImage   =   UIImage()
    var _delegate   : WinkImgObjDelegate!   =   nil
    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: WinkImgObjDelegate , kImgWidth: CGFloat) -> WinkImgObj {
        
        _ArtistRole     =   (checkAndSave(kDict, aKey: kLS_CP_ArtistRole , returnType: 0) as? NSString)!
        _ArtistUserId   =   (checkAndSave(kDict, aKey: kLS_CP_ArtistUserId , returnType: 0) as? NSString)!
        _ThumbnailURL   =   (checkAndSave(kDict, aKey: kLS_CP_ThumbnailURL , returnType: 0) as? NSString)!
        _URL            =   (checkAndSave(kDict, aKey: kLS_CP_URL , returnType: 0) as? NSString)!
        _ArtistUserName =   (checkAndSave(kDict, aKey: kLS_CP_ArtistUserName , returnType: 0) as? NSString)!
        _FileName       =   (checkAndSave(kDict, aKey: kLS_CP_FileName , returnType: 0) as? NSString)!
        _StoryId        =   (checkAndSave(kDict, aKey: kLS_CP_StoryId , returnType: 0) as? NSString)!
        _WinkImageDesc  =   (checkAndSave(kDict, aKey: kLS_CP_WinkImageDesc , returnType: 0) as? NSString)!
        _WinkboardLike  =   (checkAndSave(kDict, aKey: kLS_CP_WinkboardLike , returnType: 0) as? NSString)!
        _WinkedDateTime =   (checkAndSave(kDict, aKey: kLS_CP_WinkedDateTime , returnType: 0) as? NSString)!
        
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        
        let imgName     =   "\(_ThumbnailURL)\(_FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (imgName.trim() == "")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            
            self._thumbImg =   UIImage(named: "NoImage.png")!
            
            self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
                
                self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
            }
        }

        let imgName1     =   "\(_URL)\(_FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath1 = (paths[0] as String).stringByAppendingString("/\(imgName1)")
        
        if (imgName1.trim() == "")
        {
            self._isImgDownloadIntiated =   true
            self._isImgDownloaded  =   true
            
            self._Img =   UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath1))
            {
                self._isImgDownloadIntiated =   true
                self._isImgDownloaded  =   true
                
                self._Img =   UIImage(contentsOfFile: imgPath1)!
            }
        }
        
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_ThumbnailURL)\(_FileName)")!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                print("\(err)")
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._ThumbnailURL)\(self._FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                    
                }
                else
                {
                    print("No Image")
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                }
                
                self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
    func downloadImg () {
        self._isImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_URL)\(_FileName)")!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                print("\(err)")
                self._isImgDownloadIntiated    =   false
            }
            else
            {
                self._isImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._Img =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._URL)\(self._FileName)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._Img, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    print("No Image")
                    self._Img =   UIImage(named: "NoImage.png")!
                }
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
}
// MARK: - UserProfileImgObjDelegate -
protocol UserProfileImgObjDelegate {
    func ImageDownloadReqFinished ()
}

// MARK: - UserProfileImgObj -
class UserProfileImgObj: NSObject {
    var _createdBy     : NSString   =   ""
    var _createdDate   : NSString   =   ""
    var _defaultFlag : Int     =   0
    var _id       : NSString        =   ""
    var _modifiedBy   : NSString    =   ""
    var _modifiedDate   : NSString  =   ""
    var _url        :  NSString     =   ""
    var _userId  : NSString         =   ""
    
 
    var _isImgDownloadIntiated : Bool  =   false
    var _isImgDownloaded : Bool  =   false
    var _Img          : UIImage   =   UIImage()
    var _delegate   : UserProfileImgObjDelegate!   =   nil
    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: UserProfileImgObjDelegate , kImgWidth: CGFloat) -> UserProfileImgObj {
        
        _createdBy     =   (checkAndSave(kDict, aKey: kLS_CP_createdBy , returnType: 0) as? NSString)!
        _createdDate   =   (checkAndSave(kDict, aKey: kLS_CP_createdDate , returnType: 0) as? NSString)!
        _defaultFlag   =   (checkAndSave(kDict, aKey: kLS_CP_defaultFlag , returnType: 1) as? Int)!
        _id            =   (checkAndSave(kDict, aKey: kLS_CP_id , returnType: 0) as? NSString)!
        _modifiedBy     =   (checkAndSave(kDict, aKey: kLS_CP_modifiedBy , returnType: 0) as? NSString)!
        _modifiedDate   =   (checkAndSave(kDict, aKey: kLS_CP_modifiedDate , returnType: 0) as? NSString)!
        _url            =   (checkAndSave(kDict, aKey: kLS_CP_url , returnType: 0) as? NSString)!
        _userId         =   (checkAndSave(kDict, aKey: kLS_CP_userId , returnType: 0) as? NSString)!
        
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        return self
    }

    func downloadImg () {
        self._isImgDownloadIntiated =   true
        
        if (_url.isEqualToString("") == true)
        {
            self._isImgDownloaded  =   true
            self._Img =   UIImage(named: "NoImage.png")!
            self._imgHeight =   (self._imgWidth / self._Img.size.width) * self._Img.size.height
            
            self._delegate.ImageDownloadReqFinished()
        }
        else
        {
            NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _url as String)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
                
                if (err != nil)
                {
                    print("\(err)")
                    self._isImgDownloadIntiated    =   false
                }
                else
                {
                    self._isImgDownloaded  =   true
                    if ((resp as! NSHTTPURLResponse).statusCode == 200)
                    {
                        self._Img =   UIImage(data: kData!)!
                    }
                    else
                    {
                        print("No Image")
                        self._Img =   UIImage(named: "NoImage.png")!
                    }
                    
                    self._imgHeight =   (self._imgWidth / self._Img.size.width) * self._Img.size.height
                    
                    self._delegate.ImageDownloadReqFinished()
                }
            }
        }
    }
}



class PortfolioObj: NSObject {
    var _Access   : NSString        =   ""
    var _CoverImg   : NSString      =   ""
    var _Name   : NSString          =   ""
    var _PhotoshootId   : NSString  =   ""
    var _PortfolioId   : NSString   =   ""
    var _PortfolioName   : NSString =   ""
    var _SearchId   : NSString      =   ""
    var _SearchObjDate   : NSString =   ""
    var _StoryDesc   : NSString     =   ""
    var _StoryId   : NSString       =   ""
    var _ThumbnailURL   : NSString  =   ""
    var _URL   : NSString           =   ""
    var _UserId   : NSString        =   ""
    var _UserName   : NSString      =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage   =   UIImage()
    var _delegate   : FeedObjDelegate!   =   nil
    var _imgHeight  : CGFloat       =   0.0
    var _imgWidth   : CGFloat       =   0.0
    
    func setDetails (kDict: NSDictionary, kDelegate: FeedObjDelegate , kImgWidth: CGFloat) -> PortfolioObj {
        
        _Access     =   (checkAndSave(kDict, aKey: kLS_CP_Access , returnType: 0) as? NSString)!
        _CoverImg   =   (checkAndSave(kDict, aKey: kLS_CP_CoverImg , returnType: 0) as? NSString)!
        _Name       =   (checkAndSave(kDict, aKey: kLS_CP_Name , returnType: 0) as? NSString)!
        _PhotoshootId   =   (checkAndSave(kDict, aKey: kLS_CP_PhotoshootId , returnType: 0) as? NSString)!
        _PortfolioId    =   (checkAndSave(kDict, aKey: kLS_CP_PortfolioId , returnType: 0) as? NSString)!
        _PortfolioName  =   (checkAndSave(kDict, aKey: kLS_CP_PortfolioName , returnType: 0) as? NSString)!
        _SearchId       =   (checkAndSave(kDict, aKey: kLS_CP_SearchId , returnType: 0) as? NSString)!
        _SearchObjDate  =   (checkAndSave(kDict, aKey: kLS_CP_SearchObjDate , returnType: 0) as? NSString)!
        _StoryDesc      =   (checkAndSave(kDict, aKey: kLS_CP_StoryDesc , returnType: 0) as? NSString)!
        _StoryId        =   (checkAndSave(kDict, aKey: kLS_CP_StoryId , returnType: 0) as? NSString)!
        _ThumbnailURL   =   (checkAndSave(kDict, aKey: kLS_CP_ThumbnailURL , returnType: 0) as? NSString)!
        _URL            =   (checkAndSave(kDict, aKey: kLS_CP_URL , returnType: 0) as? NSString)!
        _UserId         =   (checkAndSave(kDict, aKey: kLS_CP_UserId , returnType: 0) as? NSString)!
        _UserName       =   (checkAndSave(kDict, aKey: kLS_CP_AgencyName , returnType: 0) as? NSString)!
        
        _delegate       =   kDelegate
        _imgWidth       =   kImgWidth
        _imgHeight      =   kImgWidth
        
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   "\(self._ThumbnailURL)\(self._CoverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            
            self._thumbImg =   UIImage(contentsOfFile: imgPath)!
            
            self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
        }
        
        return self
    }
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: "\(_ThumbnailURL)\(_CoverImg)")!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   "\(self._ThumbnailURL)\(self._CoverImg)".stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                    
                }
                else
                {
                    print("No Image")
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                    self._imgHeight =   (self._imgWidth / self._thumbImg.size.width) * self._thumbImg.size.height
                }
                self._delegate.feedImageDownloadReqFinished()
            }
        }
    }

}


class LocationObj    : NSObject {
    var _artistCrew : NSString  =   ""
    var _date : NSString        =   ""
    var _desc : NSString        =   ""
    var _latLng : NSString      =   ""
    var _latlng : NSString      =   ""
    var _location : NSString    =   ""
    var _locationId : NSString  =   ""
    var _pbId : NSString        =   ""
    var _time : NSString        =   ""
    var _title : NSString       =   ""
    
    var _scheduleDate : NSString       =   ""
    var _scheduleTime : NSString       =   ""
    func setDetails (kDict: NSDictionary) -> LocationObj {
        
        _artistCrew     =   (checkAndSave(kDict, aKey: kLS_CP_artistCrew , returnType: 0) as? NSString)!
        _date           =   (checkAndSave(kDict, aKey: kLS_CP_date , returnType: 0) as? NSString)!
        _desc           =   (checkAndSave(kDict, aKey: kLS_CP_desc , returnType: 0) as? NSString)!
        _latLng         =   (checkAndSave(kDict, aKey: kLS_CP_latLng , returnType: 0) as? NSString)!
        _latlng         =   (checkAndSave(kDict, aKey: kLS_CP_latlng , returnType: 0) as? NSString)!
        _location       =   (checkAndSave(kDict, aKey: kLS_CP_location , returnType: 0) as? NSString)!
        _locationId     =   (checkAndSave(kDict, aKey: kLS_CP_locationId , returnType: 0) as? NSString)!
        _pbId           =   (checkAndSave(kDict, aKey: kLS_CP_pbId , returnType: 0) as? NSString)!
        _time           =   (checkAndSave(kDict, aKey: kLS_CP_time , returnType: 0) as? NSString)!
        _title          =   (checkAndSave(kDict, aKey: kLS_CP_title , returnType: 0) as? NSString)!
        _scheduleDate          =   (checkAndSave(kDict, aKey: kLS_CP_scheduleDate , returnType: 0) as? NSString)!
        _scheduleTime          =   (checkAndSave(kDict, aKey: kLS_CP_scheduleTime , returnType: 0) as? NSString)!
        
        return self
    }
}

let kLS_CP_fromFlight : NSString        =   "fromFlight"
let kLS_CP_fromFlightId : NSString      =   "fromFlightId"
let kLS_CP_fromLocationId : NSString    =   "fromLocationId"
let kLS_CP_toFlight : NSString          =   "toFlight"
let kLS_CP_toFlightId : NSString        =   "toFlightId"
let kLS_CP_toLocationId : NSString      =   "toLocationId"
let kLS_CP_travellerName : NSString     =   "travellerName"

class TravelObj    : NSObject {
    var _categoryId : NSString      =   ""
    var _categoryName : NSString    =   ""
    var _flight : NSString          =   ""
    var _format : Int               =   0
    var _fromDate : NSString        =   ""
    var _fromLocation : NSString    =   ""
    var _fromTime : NSString        =   ""
    var _hotel : NSString           =   ""
    var _itineraryId : NSString     =   ""
    var _itineraryName : NSString   =   ""
    var _notes : NSString           =   ""
    var _proddays : NSString        =   ""
    var _sortOrder : NSString       =   ""
    var _toDate : NSString          =   ""
    var _toLocation : NSString      =   ""
    var _toTime : NSString          =   ""
    var _travelId : NSString        =   ""
    
    var _fromFlight : NSString      =   ""
    var _fromFlightId : NSString    =   ""
    var _fromLocationId : NSString  =   ""
    var _toFlight : NSString        =   ""
    var _toFlightId : NSString      =   ""
    var _toLocationId : NSString    =   ""
    var _travellerName : NSString   =   ""
    var _userId : NSString          =   ""
    var _attachmentUrl : NSString       =   ""
    
    var kFromFlight : NSString      =   ""
    var kFromCar    : NSString      =   ""
    var kFromLoc    : NSString      =   ""
    var kToFlight   : NSString      =   ""
    var kToCar      : NSString      =   ""
    var kToLoc      : NSString      =   ""
    var kDesc1      : NSString      =   ""
    var kDesc2      : NSString      =   ""
    var kHotel      : NSString      =   ""
    
    var kDesc1Height : CGFloat      =   0
    var kDesc2Height : CGFloat      =   0
    var kDesc3Height : CGFloat      =   0
    
    
    func setDetails (kDict: NSDictionary) -> TravelObj {
        _fromFlight         =   (checkAndSave(kDict, aKey: kLS_CP_fromFlight , returnType: 0) as? NSString)!
        
        _fromFlightId       =   (checkAndSave(kDict, aKey: kLS_CP_fromFlightId , returnType: 0) as? NSString)!
        _fromLocationId     =   (checkAndSave(kDict, aKey: kLS_CP_fromLocationId , returnType: 0) as? NSString)!
        _toFlight           =   (checkAndSave(kDict, aKey: kLS_CP_toFlight , returnType: 0) as? NSString)!
        _toFlightId         =   (checkAndSave(kDict, aKey: kLS_CP_toFlightId , returnType: 0) as? NSString)!
        _toLocationId       =   (checkAndSave(kDict, aKey: kLS_CP_toLocationId , returnType: 0) as? NSString)!
        _travellerName      =   (checkAndSave(kDict, aKey: kLS_CP_travellerName , returnType: 0) as? NSString)!
        _userId             =   (checkAndSave(kDict, aKey: kLS_CP_userId , returnType: 0) as? NSString)!
        
        _categoryId     =   (checkAndSave(kDict, aKey: kLS_CP_categoryId , returnType: 0) as? NSString)!
        _categoryName   =   (checkAndSave(kDict, aKey: kLS_CP_categoryName , returnType: 0) as? NSString)!
        _flight         =   (checkAndSave(kDict, aKey: kLS_CP_flight , returnType: 0) as? NSString)!
        _format         =   (checkAndSave(kDict, aKey: kLS_CP_format , returnType: 1) as? Int)!
        _fromDate       =   (checkAndSave(kDict, aKey: kLS_CP_fromDate , returnType: 0) as? NSString)!
        _fromLocation   =   (checkAndSave(kDict, aKey: kLS_CP_fromLocation , returnType: 0) as? NSString)!
       
        _fromTime       =   (checkAndSave(kDict, aKey: kLS_CP_fromTime , returnType: 0) as? NSString)!
        _hotel          =   (checkAndSave(kDict, aKey: kLS_CP_hotel , returnType: 0) as? NSString)!
        _itineraryId    =   (checkAndSave(kDict, aKey: kLS_CP_itineraryId , returnType: 0) as? NSString)!
        _itineraryName  =   (checkAndSave(kDict, aKey: kLS_CP_itineraryName , returnType: 0) as? NSString)!
        _notes          =   (checkAndSave(kDict, aKey: kLS_CP_notes , returnType: 0) as? NSString)!
        _proddays       =   (checkAndSave(kDict, aKey: kLS_CP_proddays , returnType: 0) as? NSString)!
        _sortOrder      =   (checkAndSave(kDict, aKey: kLS_CP_sortOrder , returnType: 0) as? NSString)!
        _toDate         =   (checkAndSave(kDict, aKey: kLS_CP_toDate , returnType: 0) as? NSString)!
        _toLocation     =   (checkAndSave(kDict, aKey: kLS_CP_toLocation , returnType: 0) as? NSString)!
        
        _toTime         =   (checkAndSave(kDict, aKey: kLS_CP_toTime , returnType: 0) as? NSString)!
        _travelId       =   (checkAndSave(kDict, aKey: kLS_CP_travelId , returnType: 0) as? NSString)!
        _attachmentUrl  =   (checkAndSave(kDict, aKey: kLS_CP_attachmentUrl , returnType: 0) as? NSString)!
        
        if (_fromFlight.uppercaseString.trim() != "") {
            let kArr    =   _fromFlight.componentsSeparatedByString("|")
            kFromFlight =   kArr[0]
            if (kArr.count>1)  {
                kFromLoc    =   kArr[1]
            }
            
            kDesc1          =   "Departs " + kFromFlight.capitalizedString + " At " + _fromTime.uppercaseString
            
        }
        
        if (_toFlight.uppercaseString.trim() != "") {
            let kArr    =   _toFlight.componentsSeparatedByString("|")
            kToFlight =   kArr[0]
            if (kArr.count>1)  {
                kToLoc    =   kArr[1]
            }
            kDesc2      =   "Arrives " + kToFlight.capitalizedString + " At " + _toTime.uppercaseString
        }
        
        
        if (_fromLocation.uppercaseString.trim() != "") {
            let kArr    =   _fromLocation.componentsSeparatedByString("|")
            kFromCar    =   kArr[0]
            if (kArr.count>1)  {
                kFromLoc    =   kArr[1]
            }
            kDesc1      =   "Pick Up  \(kFromCar.capitalizedString) At \(_fromTime.uppercaseString)"
        }
        if (_toLocation.uppercaseString.trim() != "") {
            let kArr    =   _toLocation.componentsSeparatedByString("|")
            kToCar =   kArr[0]
            if (kArr.count>1)  {
                kToLoc    =   kArr[1]
            }
            kDesc2      =   "Drop Off \(kToCar)".capitalizedString
        }
        
        if (_categoryId.isEqualToString("HTEL") == true) {
            let kArr    =   _hotel.componentsSeparatedByString("|")
            kHotel =   kArr[0]
            
            kDesc1      =   "Check In  \(kHotel.capitalizedString) At \(_fromTime.uppercaseString)"
            kDesc2      =   "Check Out \(kHotel.capitalizedString) At \(_toTime.uppercaseString)"
        }
        kDesc1Height    =  heightForView(kDesc1 as String, font: (UIFont(name: Gillsans.Default.description, size: 14.0))!, width: UIScreen.mainScreen().bounds.size.width - 55 - 70)
        kDesc2Height    =  heightForView(kDesc2 as String, font: (UIFont(name: Gillsans.Default.description, size: 14.0))!, width: UIScreen.mainScreen().bounds.size.width - 55 - 70)
        if (_attachmentUrl.uppercaseString != "") {
            kDesc3Height    =   heightForView("Attachment", font: (UIFont(name: Gillsans.Default.description, size: 14.0))!, width: UIScreen.mainScreen().bounds.size.width - 55 - 70)
        }
        
        if (kDesc1Height < 30.0) {
            kDesc1Height    =   30.0
        }
        if (kDesc2Height < 30.0) {
            kDesc2Height    =   30.0
        }
        return self
    }
}



let kLS_CP_actualFileName   : NSString  =   "actualFileName"
let kLS_CP_actualFileSize   : NSString  =   "actualFileSize"
let kLS_CP_attachmentId   : NSString    =   "attachmentId"
let kLS_CP_attachmentType   : NSString  =   "attachmentType"
let kLS_CP_attachmentURL   : NSString   =   "attachmentURL"
let kLS_CP_attachmentUrl   : NSString   =   "attachmentUrl"
let kLS_CP_fileSize : NSString      =   "fileSize"
let kLS_CP_winkboardId   : NSString           =   "winkboardId"
let kLS_CP_ownerName   : NSString       =   "ownerName"
let kLS_CP_sharedType   : NSString      =   "sharedType"

class AttachmentObj    : NSObject {
    var _actualFileName : NSString      =   ""
    var _actualFileSize : NSString      =   ""
    var _attachmentId : NSString        =   ""
    var _attachmentType : NSString      =   ""
    var _attachmentURL : NSString       =   ""
    var _createdBy : NSString           =   ""
    var _createdDate : NSString         =   ""
    var _fileName : NSString            =   ""
    var _fileSize : NSString            =   ""
    var _notes : NSString               =   ""
    var _ownerName : NSString           =   ""
    var _sharedType : NSString          =   ""
    var _winkboardId : NSString         =   ""

    
    func setDetails (kDict: NSDictionary) -> AttachmentObj {
        
        _actualFileName     =   (checkAndSave(kDict, aKey: kLS_CP_actualFileName , returnType: 0) as? NSString)!
        _actualFileSize     =   (checkAndSave(kDict, aKey: kLS_CP_actualFileSize , returnType: 0) as? NSString)!
        _attachmentId       =   (checkAndSave(kDict, aKey: kLS_CP_attachmentId , returnType: 0) as? NSString)!
        _attachmentType     =   (checkAndSave(kDict, aKey: kLS_CP_attachmentType , returnType: 0) as? NSString)!
        _attachmentURL      =   (checkAndSave(kDict, aKey: kLS_CP_attachmentURL , returnType: 0) as? NSString)!
        _createdBy          =   (checkAndSave(kDict, aKey: kLS_CP_createdBy , returnType: 0) as? NSString)!
        _createdDate        =   (checkAndSave(kDict, aKey: kLS_CP_createdDate , returnType: 0) as? NSString)!
        _fileName           =   (checkAndSave(kDict, aKey: kLS_CP_fileName , returnType: 0) as? NSString)!
        _fileSize           =   (checkAndSave(kDict, aKey: kLS_CP_fileSize , returnType: 0) as? NSString)!
        _notes              =   (checkAndSave(kDict, aKey: kLS_CP_notes , returnType: 0) as? NSString)!
        _ownerName          =   (checkAndSave(kDict, aKey: kLS_CP_ownerName , returnType: 0) as? NSString)!
        _sharedType         =   (checkAndSave(kDict, aKey: kLS_CP_sharedType , returnType: 0) as? NSString)!
        _winkboardId        =   (checkAndSave(kDict, aKey: kLS_CP_winkboardId , returnType: 0) as? NSString)!
        
        return self
    }
}

class CountryObj: NSObject {
    var _callingCode : NSString  =   ""
    var _countryCode   : NSString  =   ""
    var _countryId   : NSString  =   ""
    var _countryName   : NSString  =   ""
    
    func setDetails (kDict: NSDictionary) -> CountryObj {
        
        _countryCode     =   (checkAndSave(kDict, aKey: kLS_CP_countryCode , returnType: 0) as? NSString)!
        _callingCode     =   (checkAndSave(kDict, aKey: kLS_CP_callingCode , returnType: 0) as? NSString)!
        _countryId     =   (checkAndSave(kDict, aKey: kLS_CP_countryId , returnType: 0) as? NSString)!
        _countryName     =   (checkAndSave(kDict, aKey: kLS_CP_countryName , returnType: 0) as? NSString)!
        
        return self
    }
}

let kLS_CP_primaryRoleCdDesc    : NSString  =   "primaryRoleCdDesc"
let kLS_CP_primaryRoleCd    : NSString  =   "primaryRoleCd"
let kLS_CP_primaryRole      : NSString  =   "primaryRole"

class SpecialityObj: NSObject {
    var _specialityDesc : NSString  =   ""
    var _primaryDesc : NSString  =   ""
    var _specialityCd   : NSString  =   ""
    var _primaryRoleCd   : NSString  =   ""
    var _primaryRoleCdDesc   : NSString  =   ""
    var _primaryId   : Int  =   0
    var _specialityRole   : NSString  =   ""
    var _specialitySortOrder   : NSString  =   ""
    func setDetails (kDict: NSDictionary) -> SpecialityObj {
        
        _specialityCd       =   (checkAndSave(kDict, aKey: kLS_CP_specialityCd , returnType: 0) as? NSString)!
        _primaryDesc     =   (checkAndSave(kDict, aKey: kLS_CP_primaryDesc , returnType: 0) as? NSString)!
        _specialityDesc     =   (checkAndSave(kDict, aKey: kLS_CP_specialityDesc , returnType: 0) as? NSString)!
        _primaryRoleCd      =   (checkAndSave(kDict, aKey: kLS_CP_primaryRoleCd , returnType: 0) as? NSString)!
        _primaryRoleCdDesc  =   (checkAndSave(kDict, aKey: kLS_CP_primaryRoleCdDesc , returnType: 0) as? NSString)!
        _primaryId          =   (checkAndSave(kDict, aKey: kLS_CP_primaryId , returnType: 1) as? Int)!
        _specialityRole     =   (checkAndSave(kDict, aKey: kLS_CP_specialityRole , returnType: 0) as? NSString)!
        _specialitySortOrder    =   (checkAndSave(kDict, aKey: kLS_CP_specialitySortOrder , returnType: 0) as? NSString)!
        
        return self
    }
}

class AddRoleObj: NSObject {
    var _primaryRole : NSString  =   ""
    var _primaryRoleCd : NSString  =   ""
    var _primaryRoleCdDesc : NSString  =   ""
    
    func setDetails (kDict: NSDictionary) -> AddRoleObj {
        
        _primaryRoleCd      =   (checkAndSave(kDict, aKey: kLS_CP_primaryRoleCd , returnType: 0) as? NSString)!
        _primaryRole        =   (checkAndSave(kDict, aKey: kLS_CP_primaryRole , returnType: 0) as? NSString)!
        _primaryRoleCdDesc  =   (checkAndSave(kDict, aKey: kLS_CP_primaryRoleCdDesc , returnType: 0) as? NSString)!
        
        return self
    }
}

let kLS_CP_ConfirmedByDate     : NSString  =   "ConfirmedByDate"
let kLS_CP_SpecialityId     : NSString  =   "SpecialityId"
let kLS_CP_count     : NSString  =   "count"

class ConfirmedArtistObj: NSObject {
    var _ArtistId   : NSString  =   ""
    var _CallTime   : NSString  =   ""
    var _ConfirmedByDate   : NSString  =   ""
    var _Speciality   : NSString  =   ""
    var _SpecialityId   : NSString  =   ""
    var _UserName   : NSString  =   ""
    var _count   : NSString  =   ""
    var _specialityCd   : NSString  =   ""

    
    func setDetails (kDict: NSDictionary) -> ConfirmedArtistObj {
        
        _ArtistId     =   (checkAndSave(kDict, aKey: kLS_CP_ArtistId , returnType: 0) as? NSString)!
       _CallTime     =   (checkAndSave(kDict, aKey: kLS_CP_CallTime , returnType: 0) as? NSString)!
        _ConfirmedByDate     =   (checkAndSave(kDict, aKey: kLS_CP_ConfirmedByDate , returnType: 0) as? NSString)!
        _Speciality     =   (checkAndSave(kDict, aKey: kLS_CP_Speciality , returnType: 0) as? NSString)!
        _SpecialityId     =   (checkAndSave(kDict, aKey: kLS_CP_SpecialityId , returnType: 0) as? NSString)!
        _UserName     =   (checkAndSave(kDict, aKey: kLS_CP_UserName , returnType: 0) as? NSString)!
        _count     =   (checkAndSave(kDict, aKey: kLS_CP_count , returnType: 0) as? NSString)!
        
        return self
    }
}


let kLS_CP_notificationId   : NSString  =   "notificationId"
let kLS_CP_notifiedDate     : NSString  =   "notifiedDate"
let kLS_CP_notifiedTo   : NSString  =   "notifiedTo"
let kLS_CP_moduleId     : NSString  =   "moduleId"
let kLS_CP_moduleName   : NSString  =   "moduleName"
let kLS_CP_notifiedStatus   : NSString  =   "notifiedStatus"
let kLS_CP_notifiedBy   : NSString  =   "notifiedBy"
let kLS_CP_notificationMessage  : NSString  =   "notificationMessage"


class NotiMsgObj: NSObject {
    var _notificationId : NSString  =   ""
    var _notifiedDate   : NSString  =   ""
    var _notifiedTo     : NSString  =   ""
    var _moduleId   : NSString  =   ""
    var _moduleName : NSString  =   ""
    var _notifiedStatus : NSString  =   ""
    var _notifiedBy     : NSString  =   ""
    var _notificationMessage : NSString  =   ""

  
    func setDetails (kDict: NSDictionary) -> NotiMsgObj {
        
        _notificationId =   (checkAndSave(kDict, aKey: kLS_CP_notificationId , returnType: 0) as? NSString)!
        _notifiedDate   =   (checkAndSave(kDict, aKey: kLS_CP_notifiedDate , returnType: 0) as? NSString)!
        _notifiedTo     =   (checkAndSave(kDict, aKey: kLS_CP_notifiedTo , returnType: 0) as? NSString)!
        _moduleId       =   (checkAndSave(kDict, aKey: kLS_CP_moduleId , returnType: 0) as? NSString)!
        _moduleName     =   (checkAndSave(kDict, aKey: kLS_CP_moduleName , returnType: 0) as? NSString)!
        _notifiedStatus =   (checkAndSave(kDict, aKey: kLS_CP_notifiedStatus , returnType: 0) as? NSString)!
        _notifiedBy     =   (checkAndSave(kDict, aKey: kLS_CP_notifiedBy , returnType: 0) as? NSString)!
        _notificationMessage    =   (checkAndSave(kDict, aKey: kLS_CP_notificationMessage , returnType: 0) as? NSString)!
        
        
        return self
    }
}


let kLS_CP_buyPassStatus   : NSString  =   "buyPassStatus"
let kLS_CP_specialityRoleType   : NSString  =   "specialityRoleType"
let kLS_CP_pB_Id   : NSString  =   "pB_Id"
let kLS_CP_callSheetPassId   : NSString  =   "callSheetPassId"
let kLS_CP_enabledStatus   : NSString  =   "enabledStatus"


class PBuserListObj: NSObject {
    var _specialityCd   : NSString  =   ""
    var _lastName       : NSString  =   ""
    var _phone          : NSString  =   ""
    var _buyPassStatus  : NSString  =   ""
    var _specialityRoleType : NSString  =   ""
    var _pB_Id          : NSString  =   ""
    var _callSheetPassId : NSString  =   ""
    var _email          : NSString  =   ""
    var _userId         : NSString  =   ""
    var _company        : NSString  =   ""
    var _firstName      : NSString  =   ""
    var _specialityDesc : NSString  =   ""
    var _enabledStatus  : NSString  =   ""

    func setDetails (kDict: NSDictionary) -> PBuserListObj {
        
        _specialityCd   =   (checkAndSave(kDict, aKey: kLS_CP_specialityCd , returnType: 0) as? NSString)!
        _lastName       =   (checkAndSave(kDict, aKey: kLS_CP_lastName , returnType: 0) as? NSString)!
        _phone          =   (checkAndSave(kDict, aKey: kLS_CP_phone , returnType: 0) as? NSString)!
        _buyPassStatus  =   (checkAndSave(kDict, aKey: kLS_CP_buyPassStatus , returnType: 0) as? NSString)!
        _specialityRoleType =   (checkAndSave(kDict, aKey: kLS_CP_specialityRoleType , returnType: 0) as? NSString)!
        _pB_Id          =   (checkAndSave(kDict, aKey: kLS_CP_pB_Id , returnType: 0) as? NSString)!
        _callSheetPassId =   (checkAndSave(kDict, aKey: kLS_CP_callSheetPassId , returnType: 0) as? NSString)!
        _email          =   (checkAndSave(kDict, aKey: kLS_CP_email , returnType: 0) as? NSString)!
        _userId         =   (checkAndSave(kDict, aKey: kLS_CP_userId , returnType: 0) as? NSString)!
        _company        =   (checkAndSave(kDict, aKey: kLS_CP_company , returnType: 0) as? NSString)!
        _firstName      =   (checkAndSave(kDict, aKey: kLS_CP_firstName , returnType: 0) as? NSString)!
        _specialityDesc =   (checkAndSave(kDict, aKey: kLS_CP_specialityDesc , returnType: 0) as? NSString)!
        _enabledStatus  =   (checkAndSave(kDict, aKey: kLS_CP_enabledStatus , returnType: 0) as? NSString)!
        return self
    }
}

class OutstandingConfirmDate: NSObject {
    var _Artist_AvailabilityTypeId  : NSString  =   ""
    var _PB_Artist_AssignId         : NSString  =   ""
    var _PB_Artist_AvailabilityId   : Int  =   0
    var _PB_Dt   : NSString  =   ""
    func setDetails (kDict: NSDictionary) -> OutstandingConfirmDate {
        
        _Artist_AvailabilityTypeId  =   (checkAndSave(kDict, aKey: kLS_CP_Artist_AvailabilityTypeId , returnType: 0) as? NSString)!
        _PB_Artist_AssignId         =   (checkAndSave(kDict, aKey: kLS_CP_PB_Artist_AssignId , returnType: 0) as? NSString)!
        _PB_Artist_AvailabilityId   =   (checkAndSave(kDict, aKey: kLS_CP_PB_Artist_AvailabilityId , returnType: 1) as? Int)!
        _PB_Dt   =   (checkAndSave(kDict, aKey: kLS_CP_PB_Dt , returnType: 0) as? NSString)!
        return self
    }
}

class PortfolioGroupObj: NSObject {
    var _Desc  : NSString  =   ""
    var _PortfolioId         : NSString  =   ""
    var _PortfolioName   : NSString  =   ""
    func setDetails (kDict: NSDictionary) -> PortfolioGroupObj {
        
        _Desc  =   (checkAndSave(kDict, aKey: kLS_CP_Desc , returnType: 0) as? NSString)!
        _PortfolioId         =   (checkAndSave(kDict, aKey: kLS_CP_PortfolioId , returnType: 0) as? NSString)!
        _PortfolioName   =   (checkAndSave(kDict, aKey: kLS_CP_PortfolioName , returnType: 0) as? NSString)!
        return self
    }
}

protocol LinkedArtistObjDelegate {
    func ImageDownloadReqFinished ()
}
class LinkedArtistObj: NSObject {
    var _AcceptedBy : NSString    =   ""
    var _AgentEmail : NSString    =   ""
    var _AgentId    : NSString    =   ""
    var _AgentName  : NSString    =   ""
    var _ArtistAgentStatus : NSString   =   ""
    var _ArtistEmail   : NSString   =   ""
    var _ArtistId   : NSString    =   ""
    var _ArtistName : NSString    =   ""
    var _CreatedBy  : NSString    =   ""
    var _LinkId     : NSString    =   ""
    var _ArtistProfileImg   : NSString    =   ""
    var _AgentProfileImg    : NSString    =   ""
    var _ourl     : NSString    =   ""
    
    var _isThumbImgDownloadIntiated : Bool  =   false
    var _isThumbImgDownloaded : Bool  =   false
    var _thumbImg          : UIImage  =   UIImage()
    var _isImgDownloadIntiated : Bool =   false
    var _isImgDownloaded : Bool     =   false
    var _Img          : UIImage     =   UIImage()
    var _delegate   : LinkedArtistObjDelegate!   =   nil
    
    func setDetails (kDict: NSDictionary, kDelegate: LinkedArtistObjDelegate) -> LinkedArtistObj {
        _AcceptedBy     =   (checkAndSave(kDict, aKey: kLS_CP_AcceptedBy , returnType: 0) as? NSString)!
        _AgentEmail     =   (checkAndSave(kDict, aKey: kLS_CP_AgentEmail , returnType: 0) as? NSString)!
        _AgentId        =   (checkAndSave(kDict, aKey: kLS_CP_AgentId , returnType: 0) as? NSString)!
        _AgentName      =   (checkAndSave(kDict, aKey: kLS_CP_AgentName , returnType: 0) as? NSString)!
        _ArtistAgentStatus  =   (checkAndSave(kDict, aKey: kLS_CP_ArtistAgentStatus , returnType: 0) as? NSString)!
        _ArtistEmail    =   (checkAndSave(kDict, aKey: kLS_CP_ArtistEmail , returnType: 0) as? NSString)!
        _ArtistId       =   (checkAndSave(kDict, aKey: kLS_CP_ArtistId , returnType: 0) as? NSString)!
        _ArtistName     =   (checkAndSave(kDict, aKey: kLS_CP_ArtistName , returnType: 0) as? NSString)!
        _CreatedBy      =   (checkAndSave(kDict, aKey: kLS_CP_CreatedBy , returnType: 0) as? NSString)!
        _LinkId  =   (checkAndSave(kDict, aKey: kLS_CP_LinkId , returnType: 0) as? NSString)!
        _AgentProfileImg    =   (checkAndSave(kDict, aKey: kLS_CP_AgentProfileImg , returnType: 0) as? NSString)!
        _ArtistProfileImg   =   (checkAndSave(kDict, aKey: kLS_CP_ArtistProfileImg , returnType: 0) as? NSString)!
        _ourl           =   (checkAndSave(kDict, aKey: kLS_CP_ourl , returnType: 0) as? NSString)!
        _delegate       =   kDelegate
        
        let paths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        let imgName     =   self._ArtistProfileImg.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
        
        if (imgName.trim() == "")
        {
            self._isThumbImgDownloadIntiated =   true
            self._isThumbImgDownloaded  =   true
            self._thumbImg      =    UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath))
            {
                self._isThumbImgDownloadIntiated =   true
                self._isThumbImgDownloaded  =   true
                self._thumbImg =   UIImage(contentsOfFile: imgPath)!
                
            }
        }
        
        let imgName1     =   self._ourl.stringByReplacingOccurrencesOfString("/", withString: "_")
        let imgPath1 = (paths[0] as String).stringByAppendingString("/\(imgName1)")
        
        if (imgName1.trim() == "")
        {
            self._isImgDownloadIntiated =   true
            self._isImgDownloaded  =   true
            
            self._Img =   UIImage(named: "NoImage.png")!
        }
        else
        {
            if (NSFileManager.defaultManager().fileExistsAtPath(imgPath1))
            {
                self._isImgDownloadIntiated =   true
                self._isImgDownloaded  =   true
                
                self._Img =   UIImage(contentsOfFile: imgPath1)!
            }
        }
        
        return self
    }
    
    
    func downloadThumbImg () {
        self._isThumbImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _ArtistProfileImg as String)!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isThumbImgDownloadIntiated    =   false
            }
            else
            {
                self._isThumbImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._thumbImg =   UIImage(data: kData!)!
                    
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._ArtistProfileImg.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._thumbImg, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._thumbImg =   UIImage(named: "NoImage.png")!
                    
                }
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
    func downloadImg () {
        self._isImgDownloadIntiated =   true
        NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: _ourl as String)!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
            
            if (err != nil)
            {
                self._isImgDownloadIntiated    =   false
            }
            else
            {
                self._isImgDownloaded  =   true
                if ((resp as! NSHTTPURLResponse).statusCode == 200)
                {
                    self._Img =   UIImage(data: kData!)!
                    
                    let paths = NSSearchPathForDirectoriesInDomains(
                        .DocumentDirectory, .UserDomainMask, true)
                    
                    let imgName     =   self._ourl.stringByReplacingOccurrencesOfString("/", withString: "_")
                    let imgPath = (paths[0] as String).stringByAppendingString("/\(imgName)")
                    
                    UIImageJPEGRepresentation(self._Img, 1.0)?.writeToFile(imgPath, atomically: true)
                }
                else
                {
                    self._Img =   UIImage(named: "NoImage.png")!
                    
                }
                self._delegate.ImageDownloadReqFinished()
            }
        }
    }
    
}
