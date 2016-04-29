//
//  Common.swift
//  Lenspire
//
//  Created by Thulasi on 27/07/15.
//  Copyright (c) 2015 Nesh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Defines -

//let CognitoRegionType           =   AWSRegionType.USEast1
//let FeedUploadRegionType    =   AWSRegionType.USWest2

let CognitoIdentityPoolId           =   "us-east-1:8ac2def9-8284-4c9b-ad51-3575710d70a5"
let S3Bucket_lens_dev_and_qa_attach_bucket  =   "lens-dev-and-qa-attach-bucket"
let S3Bucket_lens_dev_s3_150_150    =   "lens-dev-s3-150-150"
let S3Bucket_lens_dev_s3_bucket     =   "lens-dev-s3-bucket"

let GA_TrackId                      =   "UA-72674866-2"
let kAllowTracking                  =   "allowTracking"

let kLS_App_Name : String           =   "LENSPiRE"
let kLS_Err_Msg : String            =   "Unknown error occured. Please try again."
let kLS_No_Data : String            =   "No data."
let kLS_WB_Exists : String          =   "Winkboard with this name already exists."
let kLS_WB_Created : String         =   "Winkboard created successfully."
let kLS_WB_Updated : String         =   "Winkboard updated successfully."
let kLS_OK : String                 =   "OK"
let kLS_FeatureNotImplemented : String  =   "Feature not implemented yet."
let kLS_Noti_HomeHeadTapped : String    =   "kLS_Noti_HomeHeadTapped"
let kLS_Noti_ProfileUpdated : String    =   "kLS_Noti_ProfileUpdated"
let kLS_Noti_ArtistProfileUpdated : String  =   "kLS_Noti_Artist ProfileUpdated"
let kLS_SuccessMsgColor : UIColor       =   UIColor(red: 0.302, green: 0.533, blue: 0.13, alpha: 1)
let kLS_FailedMsgColor  : UIColor       =   UIColor.redColor()
let kLS_MsgColor : UIColor              =   UIColor.blackColor()

let kLS_Status_ACTIVE           =   "ACTIVE"
let kLS_Status_INACTIVE         =   "INACTIVE"
let kLS_Status_PENDING          =   "PENDING"
let kLS_Status_RDY_SIGN         =   "RDY_SIGN"
let kLS_Status_REJ_SIGN         =   "REJ_SIGN"
let kLS_Status_DELETED          =   "DELETED"
let kLS_Status_NODATA           =   "NODATA"

//let kLS_BaseURL : NSString      =   "https://test.lenspire.com/"
let kLS_BaseURL : NSString      =   "http://192.168.1.109:8080/"

let kLS_CM_Login    : NSString              =   "j_spring_security_check"
let kLS_CM_SignUp_JoinNow   : NSString      =   "signup/joinNow"
let kLS_CM_registration_GetRole   : NSString      =   "registration/getRole"
let kLS_CM_SignUp_GetPlan   : NSString      =   "signup/getPlan"
let kLS_CM_SignUp_SavePlan  : NSString      =   "signup/savePlan"
let kLS_CM_registration_SaveMember  : NSString      =   "registration/saveMember"
let kLS_CM_registration_SaveJoinMember  : NSString      =   "registration/saveJoinMember"
let kLS_CM_registration_resendIniviteCode  : NSString      =   "registration/resendIniviteCode"
let kLS_CM_registration_chkInvitationCode  : NSString      =   "registration/chkInvitationCode"
let kLS_CM_registration_saveUserInfo  : NSString      =   "registration/saveUserInfo"
let kLS_CM_registration_saveUserDetails  : NSString      =   "registration/saveUserDetails"
let kLS_CM_registration_getUserDetails  : NSString      =   "registration/getUserDetails"
let kLS_CM_registration_savePlanDetail  : NSString      =   "registration/savePlanDetail"

let kLS_CM_company_SaveCompany  : NSString      =   "company/saveCompany"
let kLS_CM_company_checkOrgNameAvailablilty  : NSString      =   "company/checkOrgNameAvailablilty"
let kLS_CM_SignUp_GetCountry    : NSString  =   "signup/getCountry"
let kLS_CM_SignUp_GetSpectiality    : NSString              =   "signup/getSpeciality"
let kLS_CM_SignUp_SaveUserDetails   : NSString              =   "signup/saveUserDetails"
let kLS_CM_SignUp_SaveUserProfileImage  : NSString          =   "signup/saveUserProfileImage"
let kLS_CM_registration_checkEmailAvailablilty  :   NSString      =   "registration/checkEmailAvailablilty"
let kLS_CM_ProductionBook_GetAllUserProductionBook : NSString  =   "productionbook/getAllUserProductionBook"
let kLS_CM_ProductionBook_GetProductionBooks : NSString     =   "productionbook/getProductionBooks"

let kLS_CM_ProductionBook_GetCrewArtist    : NSString       =   "productionbook/getCrewArtist"
//let kLS_CM_ProductionBook_GetCrewArtist    : NSString       =   "productionbook/getCrewArtist"

let kLS_CM_ProductionBook_GetScheduleLocation    : NSString =   "productionbook/getScheduleLocation"
let kLS_CM_ProductionBook_GetProductionBookUserList    : NSString =   "productionbook/getProductionBookUserList"
let kLS_CM_ProductionBook_AddArtistToCrew    : NSString     =   "productionbook/addArtistToCrew"
let kLS_CM_ProductionBook_CheckProductionBookExists    : NSString =   "productionbook/checkProductionBookExists"
let kLS_CM_ProductionBook_CreateProductionBook    : NSString =   "productionbook/createProductionBook"
let kLS_CM_Schedule_GetScheduleEvent    : NSString          =   "schedule/getScheduleEvent"
let kLS_CM_Schedule_CreateScheduleEvent    : NSString       =   "schedule/createScheduleEvent"
let kLS_CM_Schedule_UpdateScheduleEvent    : NSString       =   "schedule/updateScheduleEvent"
let kLS_CM_Schedule_GetConfirmedArtistByDate    : NSString  =   "schedule/getConfirmedArtistByDate"
let kLS_CM_Travel_GetItineraryDetails    : NSString         =   "travel/getItineraryDetails"
let kLS_CM_Callsheet_GetUserItineraryDetails    : NSString  =   "callsheet/getUserItineraryDetails"
let kLS_CM_ProductionBook_GetLocation    : NSString         =   "productionbook/getLocation"
let kLS_CM_Feed_GetFeeds    : NSString                      =   "feed/getFeeds"
let kLS_CM_ViewStory_GetViewStory    : NSString             =   "viewstory/getViewStory"
let kLS_CM_ViewStory_GetBehindTheSceneMedia    : NSString   =   "viewstory/getBehindTheSceneMedia"
let kLS_CM_WinkBoard_WinkboardList    : NSString            =   "winkboard/winkboardList"
let kLS_CM_WinkBoard_CreateWinkBoard    : NSString          =   "winkboard/createWinkBoard"
let kLS_CM_WinkBoard_WinkImg    : NSString                  =   "winkboard/winkImg"
let kLS_CM_WinkBoard_CheckWinkboardExists    : NSString     =   "winkboard/checkwinkboardExists"
let kLS_CM_WinkBoard_GetAllUserWinkedImages    : NSString   =   "winkboard/getAllUserWinkedImages"
let kLS_CM_WinkBoard_EditWinkBoard    : NSString            =   "winkboard/editWinkBoard"
let kLS_CM_WinkBoard_DeleteWinkBoard    : NSString          =   "winkboard/deleteWinkBoard"
let kLS_CM_WinkBoard_UseAsWinkboardCover    : NSString      =   "winkboard/useAsWinkboardCover"
let kLS_CM_WinkBoard_RemoveWinkedImg    : NSString          =   "winkboard/removeWinkedImg"
let kLS_CM_SignUp_GetSpectialities    : NSString            =   "signup/getSpecialities"
let kLS_CM_Story_GetStoryCredits    : NSString              =   "story/getStoryCredits"
let kLS_CM_Story_StoryList    : NSString                    =   "story/storyList"
let kLS_CM_Story_GetUserPortfolioList : NSString            =   "story/getUserPortfolioList"
let kLS_CM_Story_GetStoryListByPortfolio : NSString         =   "story/getStoryListByPortfolio"
let kLS_CM_Search_GetAutoComlpete    : NSString             =   "search/getAutoComplete"
let kLS_CM_Search_GetSearchData    : NSString               =   "search/getSearchData"
let kLS_CM_UserProfile_GetUserDetails    : NSString         =   "userprofile/getUserDetails"
let kLS_CM_Settings_GetNotificationSettings    : NSString   =   "settings/getNotificationSettings"
let kLS_CM_Notification_GetNotificationMessages    : NSString   =   "notification/getNotificationMessages"
let kLS_CM_Media_StoryMediaUplaod    : NSString             =   "media/storyMediaUpload"
let kLS_CM_Media_SetProfileImage    : NSString              =   "media/setProfileImage"
let kLS_CM_UserProfile_GetUserImages    : NSString          =   "userprofile/getUserImages"
let kLS_CM_UserProfile_DeleteUserImage    : NSString        =   "userprofile/deleteUserImage"
let kLS_CM_UserProfile_AddUserImage    : NSString           =   "userprofile/addUserImage"
let kLS_CM_UserProfile_EditUserProfile    : NSString        =   "userprofile/editUserProfile"
let kLS_CM_UserProfile_GetLinkedUsersList   : NSString      =   "userprofile/getLinkedUsersList"
let kLS_CM_Profile_SavePersonalInfo    : NSString           =   "profile/savePersonalInfo"
let kLS_CM_UserProfile_SaveDeviceInfo    : NSString         =   "userprofile/saveDeviceInfo"
let kLS_CM_Profile_SaveWorkdetail    : NSString             =   "profile/saveWorkdetail"
let kLS_CM_Profile_getRole    : NSString                    =   "profile/getRole"
let kLS_CM_Profile_getSpeciality    : NSString              =   "profile/getSpeciality"
let kLS_CM_Profile_getCountry    : NSString                 =   "profile/getCountry"
let kLS_CM_Callsheet_GetScheduleLocationsHotels    : NSString   =   "callsheet/getScheduleLocationsHotels"
let kLS_CM_Callsheet_GetConfirmedCrewArtist    : NSString   =   "callsheet/getConfirmedCrewArtist"
let kLS_CM_Callsheet_GetOutstandingConfirmDates    : NSString   =   "callsheet/getOutstandingConfirmDates"
let kLS_CM_Callsheet_AcceptdeclineConfirmDates    : NSString    =   "callsheet/acceptdeclineConfirmDates"
let kLS_CM_Callsheet_generateCallSheetPDF    : NSString     =   "callsheet/generateCallSheetPDF"
let kLS_CM_Callsheet_preLoginService : NSString             =   "preLoginService"

let kLS_CP_addSpecialty : NSString  =   "addSpecialty"
let kLS_CP_addionalrole : NSString  =   "addionalrole"
let kLS_CP_SpecialtyId  : NSString  =   "SpecialtyId"

let kLS_CP_Artist_AvailabilityTypeId  : NSString    =   "Artist_AvailabilityTypeId"
let kLS_CP_PB_Artist_AssignId  : NSString           =   "PB_Artist_AssignId"
let kLS_CP_PB_Artist_AvailabilityId  : NSString     =   "PB_Artist_AvailabilityId"
let kLS_CP_PB_Dt  : NSString    =   "PB_Dt"

let kLS_CP_acceptlinklistarr  : NSString  =   "acceptlinklistarr"
let kLS_CP_deletelinklistarr  : NSString  =   "deletelinklistarr"
let kLS_CP_imagename  : NSString  =   "imagename"
let kLS_CP_linkartistlistarr  : NSString  =   "linkartistlistarr"
let kLS_CP_rejectlinklistarr  : NSString  =   "rejectlinklistarr"
let kLS_CP_DeviceToken  : NSString  =   "DeviceToken"
let kLS_CP_jauthId  : NSString  =   "jauthId"
let kLS_CP_step  : NSString  =   "step"

let kLS_CP_BoardType : NSString =   "BoardType"
let kLS_CP_AgentProfileImg  : NSString  =   "AgentProfileImg"
let kLS_CP_ArtistProfileImg : NSString  =   "ArtistProfileImg"
let kLS_CP_id       : NSString  =   "id"
let kLS_CP_key      : NSString  =   "key"
let kLS_CP_userid   : NSString  =   "userid"
let kLS_CP_userId   : NSString  =   "userId"
let kLS_CP_UserId   : NSString  =   "UserId"
let kLS_CP_CastingUserId   : NSString  =   "CastingUserId"
let kLS_CP_DeviceType   : NSString  =   "DeviceType"
let kLS_CP_DeviceId : NSString  =   "DeviceId"
let kLS_CP_Artistid : NSString  =   "Artistid"
let kLS_CP_email    : NSString  =   "email"
let kLS_CP_Email    : NSString  =   "Email"
let kLS_CP_password : NSString  =   "password"
let kLS_CP_roleId   : NSString  =   "roleId"
let kLS_CP_lastName : NSString  =   "lastName"
let kLS_CP_searchName : NSString    =   "searchName"
let kLS_CP_phone    : NSString  =   "phone"
let kLS_CP_zipCode  : NSString  =   "zipCode"
let kLS_CP_imageurl : NSString  =   "imageurl"
let kLS_CP_status   : NSString  =   "status"
let kLS_CP_StatusType   : NSString  =   "StatusType"
let kLS_CP_success  : NSString  =   "success"
let kLS_CP_data  : NSString  =   "data"
let kLS_CP_Page  : NSString  =   "Page"
let kLS_CP_DataMsg  : NSString  =   "DataMsg"
let kLS_CP_OrgName  : NSString  =   "OrgName"
let kLS_CP_OrgId  : NSString  =   "OrgId"
let kLS_CP_orgName  : NSString  =   "orgName"
let kLS_CP_orgId  : NSString  =   "orgId"
let kLS_CP_nodata   : NSString  =   "nodata"
let kLS_CP_Attachments   : NSString  =   "Attachments"
let kLS_CP_Hotels   : NSString  =   "Hotels"
let kLS_CP_Locations    : NSString  =   "Locations"
let kLS_CP_PortfolioId  : NSString  =   "PortfolioId"
let kLS_CP_PortfolioUserId  : NSString  =   "PortfolioUserId"
let kLS_CP_StoryUserId  : NSString  =   "StoryUserId"
let kLS_CP_result   : NSString  =   "result"
let kLS_CP_invitationCode   : NSString  =   "invitationCode"

let kLS_CP_expiryDate   : NSString  =   "expiryDate"
let kLS_CP_trailUsedStatus   : NSString  =   "trailUsedStatus"
let kLS_CP_planId   : NSString  =   "planId"
let kLS_CP_planCd   : NSString  =   "planCd"
let kLS_CP_planName : NSString  =   "planName"
let kLS_CP_location : NSString  =   "location"
let kLS_CP_Location : NSString  =   "Location"
let kLS_CP_locationName : NSString  =   "locationName"
let kLS_CP_planCode     : NSString  =   "planCode"
let kLS_CP_countryId    : NSString  =   "countryId"
let kLS_CP_countryName  : NSString  =   "countryName"
let kLS_CP_callingCode  : NSString  =   "callingCode"
let kLS_CP_countryCode  : NSString  =   "countryCode"
let kLS_CP_j_username   : NSString  =   "j_username"
let kLS_CP_j_password   : NSString  =   "j_password"
let kLS_CP_rememberme   : NSString  =   "rememberme"
let kLS_CP_feedAccess   : NSString  =   "feedAccess"
let kLS_CP_followAccess : NSString  =   "followAccess"
let kLS_CP_primaryDesc  : NSString  =   "primaryDesc"
let kLS_CP_spaceUsed    : NSString  =   "spaceUsed"
let kLS_CP_winkAccess   : NSString  =   "winkAccess"
let kLS_CP_spectialityId    : NSString  =   "specialityId"
let kLS_CP_firstName        : NSString  =   "firstName"
let kLS_CP_firstname        : NSString  =   "firstname"
let kLS_CP_SpecialityCd     : NSString  =   "SpecialityCd"
let kLS_CP_specialtydesc    : NSString  =   "specialtydesc"
let kLS_CP_specialityCd     : NSString  =   "specialityCd"
let kLS_CP_specialityRole   : NSString  =   "specialityRole"
let kLS_CP_subscription_Amt : NSString  =   "subscription_Amt"
let kLS_CP_SpecialityDesc   : NSString  =   "SpecialityDesc"
let kLS_CP_specialityDesc   : NSString  =   "specialityDesc"
let kLS_CP_portfolioAccess  : NSString  =   "portfolioAccess"
let kLS_CP_secondaryDesc    : NSString  =   "secondaryDesc"
let kLS_CP_followerAccess   : NSString  =   "followerAccess"
let kLS_CP_authorizationToken   : NSString  =   "authorizationToken"
let kLS_CP_collaboratorAccess   : NSString  =   "collaboratorAccess"
let kLS_CP_contributorAccess    : NSString  =   "contributorAccess"
let kLS_CP_createStoryboard     : NSString  =   "createStoryboard"
let kLS_CP_solicitationAccess   : NSString  =   "solicitationAccess"
let kLS_CP_specialitySortOrder  : NSString  =   "specialitySortOrder"
let kLS_CP_AgencyName   : NSString  =   "AgencyName"
let kLS_CP_ArtistStatus : NSString  =   "ArtistStatus"
let kLS_CP_BrandName    : NSString  =   "BrandName"
let kLS_CP_PhoneNo      : NSString  =   "PhoneNo"
let kLS_CP_phoneNo      : NSString  =   "phoneNo"
let kLS_CP_CreatedBy    : NSString  =   "CreatedBy"
let kLS_CP_CreatedDate  : NSString  =   "CreatedDate"
let kLS_CP_profileAgentId   : NSString  =   "profileAgentId"
let kLS_CP_profileCity      : NSString  =   "profileCity"
let kLS_CP_profileCountry   : NSString  =   "profileCountry"
let kLS_CP_profileEmail     : NSString  =   "profileEmail"
let kLS_CP_profileMotto     : NSString  =   "profileMotto"
let kLS_CP_profilePhone     : NSString  =   "profilePhone"
let kLS_CP_profileName      : NSString  =   "profileName"
let kLS_CP_profileFirstName : NSString  =   "profileFirstName"
let kLS_CP_profileLastName  : NSString  =   "profileLastName"
let kLS_CP_profileRole      : NSString  =   "profileRole"
let kLS_CP_profileWebsite   : NSString  =   "profileWebsite"
let kLS_CP_profileZip       : NSString  =   "profileZip"
let kLS_CP_profileimagename : NSString  =   "profileimagename"
let kLS_CP_profileimagesize : NSString  =   "profileimagesize"
let kLS_CP_proflinkAcceptedlist : NSString  =   "proflinkAcceptedlist"
let kLS_CP_proflinkDeletedlist  : NSString  =   "proflinkDeletedlist"
let kLS_CP_profileSpecialtyId   : NSString  =   "profileSpecialtyId"
let kLS_CP_proflinkRejectedlist : NSString  =   "proflinkRejectedlist"
let kLS_CP_proflinkuserType     : NSString  =   "proflinkuserType"
let kLS_CP_deleteArtistlist     : NSString  =   "deleteArtistlist"

let kLS_CP_deleteInd    : NSString  =   "deleteInd"
let kLS_CP_DeleteInd    : NSString  =   "DeleteInd"
let kLS_CP_Description  : NSString  =   "Description"
let kLS_CP_FinalizeStatus   : NSString  =   "FinalizeStatus"
let kLS_CP_ShootFromDate    : NSString  =   "ShootFromDate"
let kLS_CP_ShootToDate      : NSString  =   "ShootToDate"
let kLS_CP_UsageFromDate    : NSString  =   "UsageFromDate"
let kLS_CP_UsageToDate      : NSString  =   "UsageToDate"
let kLS_CP_JobNumber    : NSString  =   "JobNumber"
let kLS_CP_Owner_UserEmail  : NSString  =   "Owner_UserEmail"
let kLS_CP_Owner_UserId     : NSString  =   "Owner_UserId"
let kLS_CP_OwnerId     : NSString  =   "OwnerId"
let kLS_CP_Owner_UserName   : NSString  =   "Owner_UserName"
let kLS_CP_PB_FromDt    : NSString  =   "PB_FromDt"
let kLS_CP_PB_Id    : NSString  =   "PB_Id"
let kLS_CP_PB_ToDt  : NSString  =   "PB_ToDt"
let kLS_CP_ProjectName  : NSString  =   "ProjectName"
let kLS_CP_ScheduleStatus  : NSString  =   "ScheduleStatus"
let kLS_CP_UsageTerms   : NSString  =   "UsageTerms"
let kLS_CP_Usage_FromDt : NSString  =   "Usage_FromDt"
let kLS_CP_Usage_ToDt   : NSString  =   "Usage_ToDt"
let kLS_CP_SortType     : NSString  =   "SortType"
let kLS_CP_SortId       : NSString  =   "SortId"
let kLS_CP_itineraryId : NSString   =   "itineraryId"
let kLS_CP_pbDate : NSString   =    "pbDate"
let kLS_CP_categoryId   : NSString  =   "categoryId"
let kLS_CP_categoryName : NSString  =   "categoryName"
let kLS_CP_flight   : NSString  =   "flight"
let kLS_CP_format   : NSString  =   "format"
let kLS_CP_fromDate : NSString  =   "fromDate"
let kLS_CP_fromLocation : NSString  =   "fromLocation"
let kLS_CP_fromTime : NSString  =   "fromTime"
let kLS_CP_hotel    : NSString  =   "hotel"
let kLS_CP_itineraryName    : NSString  =   "itineraryName"
let kLS_CP_notes    : NSString  =   "notes"
let kLS_CP_proddays : NSString  =   "proddays"
let kLS_CP_toDate   : NSString  =   "toDate"
let kLS_CP_toLocation   : NSString  =   "toLocation"
let kLS_CP_toTime   : NSString  =   "toTime"
let kLS_CP_travelId : NSString      =   "travelId"
let kLS_CP_ProductionbookId : NSString  =   "ProductionbookId"
let kLS_CP_CastingCode : NSString  =   "CastingCode"
let kLS_CP_CastingId : NSString  =   "CastingId"

let kLS_CP_ProductionBookId : NSString  =   "ProductionBookId"
let kLS_CP_productionBookId : NSString  =   "productionBookId"
let kLS_CP_Artist : NSString    =   "Artist"
let kLS_CP_artist : NSString    =   "artist"
let kLS_CP_ArtistName : NSString  =   "ArtistName"
let kLS_CP_artistName : NSString  =   "artistName"
let kLS_CP_Artist_CallTime  : NSString  =   "artist_CallTime"
let kLS_CP_Artist_Status    : NSString  =   "artist_Status"
let kLS_CP_CurrencyFreq     : NSString  =   "currencyFreq"
let kLS_CP_CurrencyRate : NSString  =   "currencyRate"
let kLS_CP_CurrencyType : NSString  =   "currencyType"
let kLS_CP_ModifiedBy   : NSString  =   "modifiedBy"
let kLS_CP_ModifiedDate : NSString  =   "modifiedDate"
let kLS_CP_pb_Artist_AssignId : NSString  =   "pb_Artist_AssignId"
let kLS_CP_pb_CastId    : NSString  =   "pb_CastId"
let kLS_CP_pb_Id : NSString         =   "pb_Id"
let kLS_CP_projectName  : NSString  =   "projectName"
let kLS_CP_shortlist    : NSString  =   "shortlist"
let kLS_CP_createdBy    : NSString  =   "createdBy"
let kLS_CP_createdDate  : NSString  =   "createdDate"
let kLS_CP_defaultFlag  : NSString  =   "defaultFlag"
let kLS_CP_artistCrew   : NSString  =   "artistCrew"
let kLS_CP_artistUserId : NSString  =   "artistUserId"
let kLS_CP_artistUserName : NSString  =   "artistUserName"
let kLS_CP_locationId   : NSString  =   "locationId"
let kLS_CP_scheduleDate : NSString  =   "scheduleDate"
let kLS_CP_scheduleDesc : NSString  =   "scheduleDesc"
let kLS_CP_scheduleId   : NSString  =   "scheduleId"
let kLS_CP_scheduleAction : NSString        =   "scheduleAction"
let kLS_CP_scheduleCrew : NSString        =   "scheduleCrew"
let kLS_CP_scheduleLocation : NSString        =   "scheduleLocation"
let kLS_CP_scheduleLocationId : NSString        =   "scheduleLocationId"
let kLS_CP_scheduleAttachment : NSString    =   "scheduleAttachment"
let kLS_CP_scheduleNotes : NSString         =   "scheduleNotes"
let kLS_CP_sortOrder : NSString             =   "sortOrder"
let kLS_CP_scheduleTime : NSString  =   "scheduleTime"
let kLS_CP_scheduleTitle  : NSString    =   "scheduleTitle"
let kLS_CP_CoverImg     : NSString  =   "CoverImg"
let kLS_CP_Desc         : NSString  =   "Desc"
let kLS_CP_SearchId     : NSString  =   "SearchId"
let kLS_CP_SearchObjDate  : NSString    =   "SearchObjDate"
let kLS_CP_StoryId      : NSString  =   "StoryId"
let kLS_CP_StoryName    : NSString  =   "StoryName"
let kLS_CP_ThumbnailURL : NSString  =   "ThumbnailURL"
let kLS_CP_URL      : NSString      =   "URL"
let kLS_CP_url      : NSString      =   "url"
let kLS_CP_storyId  : NSString      =   "storyId"
let kLS_CP_fileName : NSString      =   "fileName"
let kLS_CP_BigItem  : NSString      =   "BigItem"
let kLS_CP_Credits  : NSString      =   "Credits"
let kLS_CP_FileName : NSString      =   "FileName"
let kLS_CP_FilePath : NSString      =   "FilePath"
let kLS_CP_FileSize : NSString      =   "FileSize"
let kLS_CP_UserName : NSString      =   "UserName"
let kLS_CP_UserEmail : NSString     =   "UserEmail"
let kLS_CP_UserRole : NSString      =   "UserRole"
let kLS_CP_CreditsId    : NSString  =   "CreditsId"
let kLS_CP_CreditsName  : NSString  =   "CreditsName"
let kLS_CP_SetAccess    : NSString  =   "SetAccess"
let kLS_CP_Access   : NSString      =   "Access"
let kLS_CP_Name         : NSString  =   "Name"
let kLS_CP_PhotoshootId : NSString  =   "PhotoshootId"
let kLS_CP_PortfolioName    : NSString  =   "PortfolioName"
let kLS_CP_StoryDesc    : NSString  =   "StoryDesc"
let kLS_CP_access   : NSString      =   "access"
let kLS_CP_WinkBoardDesc    : NSString  =   "WinkBoardDesc"
let kLS_CP_WinkImageDesc    : NSString  =   "WinkImageDesc"
let kLS_CP_WinkBoardId      : NSString  =   "WinkBoardId"
let kLS_CP_WinkBoardName    : NSString  =   "WinkBoardName"
let kLS_CP_ArtistId     : NSString  =   "ArtistId"
let kLS_CP_ShareType     : NSString  =   "ShareType"
let kLS_CP_AcceptedBy   : NSString  =   "AcceptedBy"
let kLS_CP_AgentEmail   : NSString  =   "AgentEmail"
let kLS_CP_AgentId      : NSString  =   "AgentId"
let kLS_CP_AgentName    : NSString  =   "AgentName"
let kLS_CP_ArtistAgentStatus    : NSString  =   "ArtistAgentStatus"
let kLS_CP_ArtistEmail  : NSString  =   "ArtistEmail"
let kLS_CP_ArtistEnabled  : NSString  =   "ArtistEnabled"
let kLS_CP_LinkId       : NSString  =   "LinkId"
let kLS_CP_ArtistUserId     : NSString  =   "ArtistUserId"
let kLS_CP_ArtistUserName     : NSString  =   "ArtistUserName"
let kLS_CP_ArtistRole   : NSString  =   "ArtistRole"
let kLS_CP_ILike    : NSString      =   "ILike"
let kLS_CP_ImgDesc  : NSString      =   "ImgDesc"
let kLS_CP_WinkboardId  : NSString  =   "WinkboardId"
let kLS_CP_WinkboardDesc    : NSString  =   "WinkboardDesc"
let kLS_CP_WinkboardName    : NSString  =   "WinkboardName"
let kLS_CP_WinkboardLike    : NSString  =   "WinkboardLike"
let kLS_CP_WinkedDateTime   : NSString  =   "WinkedDateTime"
let kLS_CP_winkedDateTime   : NSString  =   "winkedDateTime"
let kLS_CP_CheckType    : NSString  =   "CheckType"
let kLS_CP_suggester    : NSString  =   "suggester"
let kLS_CP_start    : NSString      =   "start"
let kLS_CP_startKey    : NSString      =   "startKey"
let kLS_CP_value    : NSString      =   "value"
let kLS_CP_city     : NSString      =   "city"
let kLS_CP_company  : NSString      =   "company"
let kLS_CP_bust         : NSString      =   "bust"
let kLS_CP_Bust         : NSString      =   "Bust"
let kLS_CP_contactemail : NSString      =   "contactemail"
let kLS_CP_hips         : NSString      =   "hips"
let kLS_CP_Hips         : NSString      =   "Hips"
let kLS_CP_pantsize         : NSString      =   "pantsize"
let kLS_CP_personalMotto    : NSString      =   "personalMotto"
let kLS_CP_signupstep       : NSString      =   "signupstep"
let kLS_CP_sharemotto       : NSString      =   "sharemotto"
let kLS_CP_Specialtydetail   : NSString      =   "Specialtydetail"
let kLS_CP_AdditionalRoles   : NSString      =   "AdditionalRoles"
let kLS_CP_userdefaultImg   : NSString      =   "userdefaultImg"
let kLS_CP_country  : NSString      =   "country"
let kLS_CP_Country  : NSString      =   "Country"
let kLS_CP_creditedusers    : NSString  =   "creditedusers"
let kLS_CP_CreditsUserNameList    : NSString  =   "CreditsUserNameList"
let kLS_CP_UploadType    : NSString  =   "UploadType"
let kLS_CP_date     : NSString      =   "date"
let kLS_CP_desc     : NSString      =   "desc"
let kLS_CP_latLng   : NSString      =   "latLng"
let kLS_CP_latlng   : NSString      =   "latlng"
let kLS_CP_pbId     : NSString      =   "pbId"
let kLS_CP_time     : NSString      =   "time"
let kLS_CP_title    : NSString      =   "title"
let kLS_CP_desctag  : NSString      =   "desctag"
let kLS_CP_eyecolor : NSString      =   "eyecolor"
let kLS_CP_filename : NSString      =   "filename"
let kLS_CP_haircolor    : NSString  =   "haircolor"
let kLS_CP_height   : NSString      =   "height"
let kLS_CP_lastname : NSString      =   "lastname"
let kLS_CP_loc      : NSString      =   "loc"
let kLS_CP_ourl     : NSString      =   "ourl"
let kLS_CP_portfolioid  : NSString      =   "portfolioid"
let kLS_CP_portfolioname    : NSString  =   "portfolioname"
let kLS_CP_shoesize     : NSString      =   "shoesize"
let kLS_CP_speciality   : NSString      =   "speciality"
let kLS_CP_mission      : NSString      =   "mission"
let kLS_CP_Speciality   : NSString      =   "Speciality"
let kLS_CP_SubSpeciality   : NSString      =   "SubSpeciality"
let kLS_CP_sub_speciality   : NSString  =   "sub_speciality"
let kLS_CP_suitsize     : NSString      =   "suitsize"
let kLS_CP_Suits     : NSString      =   "Suits"
let kLS_CP_tags     : NSString      =   "tags"
let kLS_CP_turl     : NSString      =   "turl"
let kLS_CP_username     : NSString  =   "username"
let kLS_CP_userrole     : NSString  =   "userrole"
let kLS_CP_waist    : NSString      =   "waist"
let kLS_CP_Waist    : NSString      =   "Waist"
let kLS_CP_website  : NSString      =   "website"
let kLS_CP_weight   : NSString      =   "weight"
let kLS_CP_CoverUrl : NSString      =   "CoverUrl"
let kLS_CP_ImageId  : NSString      =   "ImageId"
let kLS_CP_ImageName  : NSString    =   "ImageName"
let kLS_CP_twitterlink  : NSString      =   "twitterlink"
let kLS_CP_instagramlink  : NSString    =   "instagramlink"
let kLS_CP_facebooklink  : NSString     =   "facebooklink"
let kLS_CP_profileTwitter  : NSString   =   "profileTwitter"
let kLS_CP_profileFacebook  : NSString  =   "profileFacebook"
let kLS_CP_profileInstagram  : NSString =   "profileInstagram"

let kLS_CP_activationFlag : NSString    =   "activationFlag"
let kLS_CP_countyId : NSString      =   "countyId"
let kLS_CP_enabled : NSString       =   "enabled"
let kLS_CP_eyeColor : NSString      =   "eyeColor"
let kLS_CP_EyeColor : NSString      =   "EyeColor"
let kLS_CP_failureFlag : NSString   =   "failureFlag"
let kLS_CP_gender : NSString        =   "gender"
let kLS_CP_Gender : NSString        =   "Gender"
let kLS_CP_hairColor : NSString     =   "hairColor"
let kLS_CP_HairColor : NSString     =   "HairColor"
let kLS_CP_middleName : NSString    =   "middleName"
let kLS_CP_modifiedBy : NSString    =   "modifiedBy"
let kLS_CP_modifiedDate : NSString  =   "modifiedDate"
let kLS_CP_primaryId : NSString     =   "primaryId"
let kLS_CP_userSpecialityId : NSString     =   "userSpecialityId"
let kLS_CP_specialityCode : NSString   =   "specialityCode"
let kLS_CP_userprofileImg : NSString   =   "userprofileImg"
let kLS_CP_storageSpaceBytes : NSString   =   "storageSpaceBytes"
let kLS_CP_addRoleIds : NSString    =   "addRoleIds"
let kLS_CP_addSpecIds : NSString    =   "addSpecIds"
let kLS_CP_addSpecCd : NSString     =   "addSpecCd"
let kLS_CP_addSpecDesc : NSString     =   "addSpecDesc"
let kLS_CP_secondaryId : NSString   =   "secondaryId"
let kLS_CP_shoe : NSString          =   "shoe"
let kLS_CP_Shoe : NSString          =   "Shoe"
let kLS_CP_suit : NSString          =   "suit"
let kLS_CP_Pantsize : NSString        =   "Pantsize"
let kLS_CP_Height : NSString        =   "Height"
let kLS_CP_Weight : NSString        =   "Weight"
let kLS_CP_Tel : NSString           =   "Tel"
let kLS_CP_Web : NSString           =   "Web"
let kLS_CP_Zip : NSString           =   "Zip"
let kLS_CP_AvailabilityIdList : NSString   =   "AvailabilityIdList"
let kLS_CP_DatesList : NSString   =   "DatesList"
let kLS_CP_memEmail : NSString  =   "memEmail"

let k_ProductionBookListKey  : NSString = "k_ProductionBookListKey"
let k_CallSheetListKey  : NSString = "k_CallSheetListKey"


enum Gillsans : CustomStringConvertible {
    case Italic
    case Bold
    case BoldItalic
    case LightItalic
    case Light
    case SemiBold
    case SemiBoldItalic
    case UltraBold
    case Default
    
    var description : String {
        switch self {
            // Use Internationalization, as appropriate.
        case .Italic:           return  "GillSans-Italic"
        case .Bold:             return  "GillSans-Bold"
        case .BoldItalic:       return  "GillSans-BoldItalic"
        case .LightItalic:      return  "GillSans-LightItalic"
        case .Light:            return  "GillSans-Light"
        case .SemiBold:         return  "GillSans-SemiBold"
        case .SemiBoldItalic:   return  "GillSans-SemiBoldItalic"
        case .UltraBold:        return  "GillSans-UltraBold"
        case .Default:          return  "GillSans"
        }
    }
}

// MARK: - Common Methods -

extension String {
    func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
        let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
        let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
        if let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) {
                return from ..< to
        }
        return nil
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.startIndex, within: utf16view)
        let to = String.UTF16View.Index(range.endIndex, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distanceTo(from), from.distanceTo(to))
    }
}

func getButtonImage(kTitle: String, kWidth: CGFloat, kHeight : CGFloat , kFont : UIFont)  -> UIImage {
    
    let klbl    =   UILabel(frame: CGRectMake(0,0,kWidth,kHeight))
    klbl.font   =   kFont
    klbl.text   =   kTitle.uppercaseString
    klbl.textAlignment  =   .Center
    klbl.backgroundColor    =   UIColor(red: 0.886, green: 0.902, blue: 0.269, alpha: 1)
    klbl.textColor  =   UIColor.blackColor()
    klbl.layer.cornerRadius =   kHeight / 4.0
    klbl.layer.masksToBounds  =   true
    
    UIGraphicsBeginImageContextWithOptions(klbl.frame.size, false, 0.0)
    klbl.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

func getRejectButtonImage(kTitle: String, kWidth: CGFloat, kHeight : CGFloat , kFont : UIFont)  -> UIImage {
    
    let klbl    =   UILabel(frame: CGRectMake(0,0,kWidth,kHeight))
    klbl.font   =   kFont
    klbl.text   =   kTitle.uppercaseString
    klbl.textAlignment  =   .Center
    klbl.backgroundColor    =   UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    klbl.textColor  =   UIColor.whiteColor()
    klbl.layer.cornerRadius =   kHeight / 4.0
    klbl.layer.masksToBounds  =   true
    
    UIGraphicsBeginImageContextWithOptions(klbl.frame.size, false, 0.0)
    klbl.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

func kGetButtonImage(kTitle: String, kWidth: CGFloat, kHeight : CGFloat , kFont : UIFont)  -> UIImage {
    
    let klbl    =   UILabel(frame: CGRectMake(0,0,kWidth,kHeight))
    klbl.font   =   kFont
    klbl.text   =   kTitle.uppercaseString
    klbl.textAlignment  =   .Center
    klbl.backgroundColor    =   UIColor(red: 0.902, green: 0.902, blue: 0.368, alpha: 1)
    klbl.textColor  =   UIColor.blackColor()
    klbl.layer.cornerRadius =   kHeight / 8.0
    klbl.layer.masksToBounds  =   true
    
    UIGraphicsBeginImageContextWithOptions(klbl.frame.size, false, 0.0)
    klbl.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}
extension UIImage {
    
    func convertToGrayScale() -> UIImage {
        let filter: CIFilter = CIFilter(name: "CIPhotoEffectMono")!
        filter.setDefaults()
        filter.setValue(CoreImage.CIImage(image: self)!, forKey: kCIInputImageKey)
        return UIImage(CGImage: CIContext(options:nil).createCGImage(filter.outputImage!, fromRect: filter.outputImage!.extent))
    }
}


func screenShot () -> UIImage {
    UIGraphicsBeginImageContextWithOptions(GetAppDelegate().window!.frame.size, false, 0.0)
    GetAppDelegate().window!.rootViewController?.view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

func screenShotOfView (kView : UIView) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(kView.frame.size, false, 0.0)
    kView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
}

func saveUserNameAndPwd(kUsrName:String,kPwd:String) {
    NSUserDefaults.standardUserDefaults().setObject(kUsrName, forKey: "kUsrName")
    NSUserDefaults.standardUserDefaults().setObject(kPwd, forKey: "kPwd")
    NSUserDefaults.standardUserDefaults().synchronize()
}
func saveRememberPwd(kNum:NSNumber) {
    NSUserDefaults.standardUserDefaults().setObject(kNum, forKey: "kIsRemPwd")
    NSUserDefaults.standardUserDefaults().synchronize()
}

func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluateWithObject(testStr)
    
    return result
    
}
func isPhoneValid(value: String) -> Bool {
    
//    let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//    let result =  phoneTest.evaluateWithObject(value)
//    
//    return result
    
    let charcter  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
    var filtered:NSString!
    let inputString:NSArray = value.componentsSeparatedByCharactersInSet(charcter)
    filtered = inputString.componentsJoinedByString("")
    return  value == filtered
    
}

func ShowAlert(kStr:String) {
    
    let alertController = UIAlertController(title: kLS_App_Name, message: kStr, preferredStyle: .Alert)
    
    let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(defaultAction)
    
    GetAppDelegate().window?.rootViewController!.presentViewController(alertController, animated: true, completion: nil)
}

func isIpad () -> Bool {
    return (UIDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
}
func getUTF8Data (data:NSData) -> NSData {
    
    return CommonMethods.data2UTF8String(data).dataUsingEncoding(NSUTF8StringEncoding)!
}
func clearCache () {
    NSURLCache.sharedURLCache().removeAllCachedResponses()
    NSURLCache.sharedURLCache().diskCapacity = 0
    NSURLCache.sharedURLCache().memoryCapacity = 0
}
func SharedAppController () -> AppController {
    let appDele : AppDelegate   = (UIApplication.sharedApplication().delegate as?AppDelegate)!
    return appDele.appController!
}
func addTransitionEffect() {
    let animation: CATransition = CATransition()
    animation.type  =   kCATransitionFade
    animation.duration  =   0.25
    animation.subtype   =   kCATransitionFromRight
    animation.timingFunction    =   CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    GetAppDelegate().window?.layer.addAnimation(animation, forKey: "fadeViewAnimation")
}

func addTransitionEffectToView(aView:UIView) {
    let animation: CATransition = CATransition()
    animation.type  =   kCATransitionFade
    animation.duration  =   0.20
    animation.subtype   =   kCATransitionFromRight
    animation.timingFunction    =   CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    aView.layer.addAnimation(animation, forKey: "fadeViewAnimation")
}

func GetAppDelegate() -> AppDelegate {
    return (UIApplication.sharedApplication().delegate as! AppDelegate)
}
func dateForDisplay(aDate:NSDate) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "dd-MMM-yy"
    return inputFormatter.stringFromDate(aDate)
}

func dateforRefreshDisplay () -> NSString{
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "h:mm a"
    return inputFormatter.stringFromDate(NSDate())
}

func productionbookCreateDate(aDate:NSString) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "MM/dd/yyyy"
    inputFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let kDate   =   inputFormatter.dateFromString(aDate as String)
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    return inputFormatter.stringFromDate(kDate!)
}
func productionbookSectionDateForDisplay(aDate:NSString) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    inputFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let kDate   =   inputFormatter.dateFromString(aDate as String)
    inputFormatter.dateFormat   =   "MMMM yyyy"
    return inputFormatter.stringFromDate(kDate!)
}
func dateForDisplay(aDate:NSString,returnFormat:String) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    inputFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let kDate   =   inputFormatter.dateFromString(aDate as String)
    inputFormatter.dateFormat   =   returnFormat
    return inputFormatter.stringFromDate(kDate!)
}

func dateStringForDisplay(aDate:NSDate,returnFormat:String) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   returnFormat
    return inputFormatter.stringFromDate(aDate)
}

func productionbookDetailDateForDisplay(aDate:NSString) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    inputFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let kDate   =   inputFormatter.dateFromString(aDate as String)
    inputFormatter.dateFormat   =   "dd MMM yyyy"
    return inputFormatter.stringFromDate(kDate!)
}
func scheduleDetailDateForDisplay(aDate:NSString) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    inputFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let kDate   =   inputFormatter.dateFromString(aDate as String)
    inputFormatter.dateFormat   =   "eee MM/dd"
    return inputFormatter.stringFromDate(kDate!)
}

func confirmOutstandingDateForDisplay(aDate:NSString) -> NSString {
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    inputFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    let kDate   =   inputFormatter.dateFromString(aDate as String)
    inputFormatter.dateFormat   =   "dd-MM-yyyy"
    return inputFormatter.stringFromDate(kDate!)
}
func getNextDate () -> NSString {
    let newDate1 =  NSDate().dateByAddingTimeInterval(60*60*24)
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    return inputFormatter.stringFromDate(newDate1)
}
func getDateAfterNintyDays () -> NSString {
    let newDate1 =  NSDate().dateByAddingTimeInterval(60*60*24*90)
    let inputFormatter:NSDateFormatter = NSDateFormatter()
    inputFormatter.dateFormat   =   "yyyy-MM-dd"
    return inputFormatter.stringFromDate(newDate1)
}
extension NSDate
{
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func daybeginning () -> NSDate {
        
        let gregrorian  =   NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekdayComponents   =   gregrorian!.components([.Day ,.Weekday,.Month,.Year], fromDate: self)
        
        let month: NSInteger   =   weekdayComponents.month
        let year: NSInteger    =   weekdayComponents.year
        let day: NSInteger      =   weekdayComponents.day
        
        
        weekdayComponents.day   =   day
        weekdayComponents.month =   month
        weekdayComponents.year  =   year
        weekdayComponents.hour      =   0
        weekdayComponents.minute    =   0
        return gregrorian!.dateFromComponents(weekdayComponents)!
    }
    
    func dayEndings () -> NSDate {
        let gregrorian  =   NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let weekdayComponents   =   gregrorian!.components([.Day ,.Weekday,.Month,.Year], fromDate: self)
        
        let month: NSInteger   =   weekdayComponents.month
        let year: NSInteger    =   weekdayComponents.year
        let day: NSInteger      =   weekdayComponents.day
        
        
        weekdayComponents.day   =   day
        weekdayComponents.month =   month
        weekdayComponents.year  =   year
        weekdayComponents.hour      =   23
        weekdayComponents.minute    =   59
        return gregrorian!.dateFromComponents(weekdayComponents)!
    }
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func isEqualToDte(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
        {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd : Int) -> NSDate
    {
        let secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    
    func addHours(hoursToAdd : Double) -> NSDate
    {
        let secondsInHours : NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
}

func widthForView(text:String, font:UIFont, height:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max , height))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.width
}
func getScheduleDateFromString (kStr : String) -> NSDate {
    
    var kString =   kStr.stringByReplacingOccurrencesOfString("00:00 AM", withString: "12:00 AM")
    kString     =   kStr.stringByReplacingOccurrencesOfString("00:00 PM", withString: "12:00 AM")
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return dateFormatter.dateFromString(kString)!
}

func getDateFromString (kStr : String) -> NSDate {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return dateFormatter.dateFromString(kStr)!
}

func saveUserID(kId:NSString) {
    NSUserDefaults .standardUserDefaults().setObject(kId, forKey: kLS_CP_UserId as String)
    NSUserDefaults.standardUserDefaults().synchronize()
}
func getUserID () -> NSString {
    return NSUserDefaults.standardUserDefaults().objectForKey(kLS_CP_UserId as String) as! NSString
}
func saveAuthToken(kToken:NSString) {
    NSUserDefaults .standardUserDefaults().setObject(kToken, forKey: "AuthTokenKey")
    NSUserDefaults.standardUserDefaults().synchronize()
}
func getAuthToken () -> NSString {
    return NSUserDefaults.standardUserDefaults().objectForKey("AuthTokenKey") as! NSString
}

func saveRecentSearch(kString:NSString) {
    let kArray   =   NSUserDefaults.standardUserDefaults().objectForKey("RecentSearchData")
    if (kArray == nil)
    {
        let kMutArray   =   NSMutableArray()
        kMutArray.addObject(kString)
        NSUserDefaults .standardUserDefaults().setObject(kMutArray, forKey: "RecentSearchData")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    else
    {
        let kMutArray   =   NSMutableArray(array: kArray as! NSArray)
        kMutArray.addObject(kString)
        NSUserDefaults .standardUserDefaults().setObject(kMutArray, forKey: "RecentSearchData")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}
func getRecentSearch () -> NSArray {
    let kArray  =   NSUserDefaults.standardUserDefaults().objectForKey("RecentSearchData")
    if (kArray == nil)
    {
        return NSArray()
    }
    else
    {
        return kArray as! NSArray
    }
}

func checkAndSave(kDict:NSDictionary,aKey:NSString,returnType: Int) -> AnyObject {
    if(kDict.objectForKey(aKey) == nil)
    {
        return getReturnValue(returnType)
    }
    else
    {
        if((kDict.objectForKey(aKey)!.isKindOfClass(NSNull)) == true)
        {
            return getReturnValue(returnType)
        }
        else
        {
            return kDict.objectForKey(aKey)!
        }
    }
}

func getReturnValue (returnType: Int) -> AnyObject {
    switch (returnType) {
    case 0:
        return ""
    case 1:
        return 0
    case 2:
        return true
    case 3:
        return []
    default:
        return ""
    }
}

// MARK: - AppController -
class AppController: NSObject {
    
    var appWindow: UIWindow?
    
    func loadStartupView () {
        
        appWindow?.rootViewController   =   nil
        let VC  =   EmailViewController()
        let nav =   UINavigationController(rootViewController: VC)
        appWindow?.rootViewController  =   nav
        addTransitionEffect()
    }
    
    
    func loadVerificationCodeView (code : String, email : String, userId : String) {
        appWindow?.rootViewController   =   nil
        let VC  =   EnterCodeViewController()
        VC.email    =   email
        VC.code     =   code
        VC.userID   =   userId
        VC.isFromURL    =   true
        let nav =   UINavigationController(rootViewController: VC)
        appWindow?.rootViewController  =   nav
        addTransitionEffect()
    }
    func loadHomeView () {
        
        appWindow?.rootViewController   =   nil
        let VC  =   LandController()
        appWindow?.rootViewController  =   UINavigationController(rootViewController: VC)
        addTransitionEffect()
    }
    
    func loadHomeViewFromRegistration () {
        
        appWindow?.rootViewController   =   nil
        let VC  =   LandController()
        VC.isFromRegistration   =   true
        appWindow?.rootViewController  =   UINavigationController(rootViewController: VC)
        addTransitionEffect()
    }
}

// MARK: - ServiceWrapper -

class ServiceWrapper: UIView, NSURLConnectionDelegate , NSURLConnectionDataDelegate {
    
    //  static let sharedMyManager =  ServiceWrapper(frame: UIScreen.mainScreen().bounds)
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var connection: NSURLConnection?
    var respData : NSMutableData?
    var completionHandler : ((AnyObject , String , Int) -> ())!
    var kReq : NSMutableURLRequest?
    var isRequestedAgain : Bool =   false
    
    func getRequest(kMethodName : NSString) -> NSMutableURLRequest {
        
        print("\(NSUserDefaults.standardUserDefaults().objectForKey("ServerSetting") as! NSString)\(kMethodName)")
        
        let kReq: NSMutableURLRequest =   NSMutableURLRequest(URL: NSURL(string: "\(NSUserDefaults.standardUserDefaults().objectForKey("ServerSetting") as! NSString)\(kMethodName)")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60)
        kReq.setValue("Mobile-App", forHTTPHeaderField: "User-agent")
        
        return kReq
    }
    
    func postToCloud (kMethodName : NSString , parm: NSMutableDictionary , completion : (AnyObject , String , Int) -> ()) -> ServiceWrapper {
        self.completionHandler          =   completion
        let kReq : NSMutableURLRequest  =   getRequest(kMethodName)
        
        kReq.HTTPMethod         =   "POST"
        var kString: NSString   =   ""
        
        switch (kMethodName){
        case kLS_CM_Login:
            kReq.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            kString     =   stringRepresentation(parm)
            let customAllowedSet =  NSCharacterSet(charactersInString:"\"#%/<>?\\^`{|}+").invertedSet
            kString =   kString.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)!
        case kLS_CM_registration_checkEmailAvailablilty:
            kReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
            kString         =   jsonRepresentation(parm)
            
        case kLS_CM_ProductionBook_GetAllUserProductionBook,
        kLS_CM_ProductionBook_GetProductionBooks,
        kLS_CM_ProductionBook_GetCrewArtist,
        kLS_CM_ProductionBook_GetScheduleLocation,
        kLS_CM_ProductionBook_GetProductionBookUserList,
        kLS_CM_ProductionBook_AddArtistToCrew,
        kLS_CM_ProductionBook_CheckProductionBookExists,
        kLS_CM_ProductionBook_CreateProductionBook,
        kLS_CM_Schedule_GetScheduleEvent,
        kLS_CM_Schedule_CreateScheduleEvent,
        kLS_CM_Schedule_UpdateScheduleEvent,
        kLS_CM_Schedule_GetConfirmedArtistByDate,
        kLS_CM_Travel_GetItineraryDetails,
        kLS_CM_Callsheet_GetUserItineraryDetails,
        kLS_CM_ProductionBook_GetLocation,
        kLS_CM_Feed_GetFeeds,
        kLS_CM_ViewStory_GetViewStory,
        kLS_CM_ViewStory_GetBehindTheSceneMedia,
        kLS_CM_WinkBoard_WinkboardList,
        kLS_CM_WinkBoard_CreateWinkBoard,
        kLS_CM_WinkBoard_WinkImg,
        kLS_CM_WinkBoard_CheckWinkboardExists,
        kLS_CM_WinkBoard_GetAllUserWinkedImages,
        kLS_CM_WinkBoard_EditWinkBoard,
        kLS_CM_WinkBoard_DeleteWinkBoard,
        kLS_CM_WinkBoard_UseAsWinkboardCover,
        kLS_CM_WinkBoard_RemoveWinkedImg,
        kLS_CM_SignUp_GetSpectialities,
        kLS_CM_Story_GetStoryCredits,
        kLS_CM_Story_StoryList,
        kLS_CM_Story_GetUserPortfolioList,
        kLS_CM_Story_GetStoryListByPortfolio,
        kLS_CM_Search_GetAutoComlpete,
        kLS_CM_Search_GetSearchData,
        kLS_CM_UserProfile_GetUserDetails,
        kLS_CM_Settings_GetNotificationSettings,
        kLS_CM_Notification_GetNotificationMessages,
        kLS_CM_Media_StoryMediaUplaod,
        kLS_CM_Media_SetProfileImage,
        kLS_CM_UserProfile_GetUserImages,
        kLS_CM_UserProfile_DeleteUserImage,
        kLS_CM_UserProfile_AddUserImage,
        kLS_CM_UserProfile_EditUserProfile,
        kLS_CM_UserProfile_GetLinkedUsersList,
        kLS_CM_Profile_SavePersonalInfo,
        kLS_CM_UserProfile_SaveDeviceInfo,
        kLS_CM_Profile_SaveWorkdetail,
        kLS_CM_Profile_getRole,
        kLS_CM_Profile_getSpeciality,
        kLS_CM_Profile_getCountry,
        kLS_CM_Callsheet_GetScheduleLocationsHotels,
        kLS_CM_Callsheet_GetConfirmedCrewArtist,
        kLS_CM_Callsheet_GetOutstandingConfirmDates,
        kLS_CM_Callsheet_AcceptdeclineConfirmDates,
        kLS_CM_Callsheet_generateCallSheetPDF,
        kLS_CM_Callsheet_preLoginService:
            kReq.setValue(getAuthToken() as String, forHTTPHeaderField: "X-Auth-Token")
            kReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
            kString         =   jsonRepresentation(parm)
        default:
            kReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
            kString         =   jsonRepresentation(parm)
        }
        
        let kData:NSData    =   kString.dataUsingEncoding(NSUTF8StringEncoding)!
        kReq.HTTPBody       =   kData
        kReq.addValue("\(kData.length)", forHTTPHeaderField: "Content-Length")
        kReq.addValue(((NSBundle.mainBundle().infoDictionary?["CFBundleVersion"])! as! String), forHTTPHeaderField: "CLIENT_VERSION")
        performRequest(kReq)
        
        return self
    }
    
    func performRequest  (kRequest: NSMutableURLRequest) {
        self.kReq   =   kRequest
        self.respData   =   NSMutableData()
        self.connection =   NSURLConnection(request: kRequest, delegate: self)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        if ((response as! NSHTTPURLResponse).statusCode == 200)
        {
        }
        else
        {
            self.completionHandler("", NSHTTPURLResponse.localizedStringForStatusCode((response as! NSHTTPURLResponse).statusCode), 97)
            self.cancelRequestTapped()
        }
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        if (error.code == -1005 && isRequestedAgain == false) {
            isRequestedAgain    =   true
            self.respData   =   NSMutableData()
            self.connection =   NSURLConnection(request: self.kReq!, delegate: self)
        }
        else
        {
            self.completionHandler("",error.localizedDescription,97)
            self.cancelRequestTapped()
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.respData?.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        let kData : NSData  =   NSData(data: self.respData!)
        let KStr:NSString   =    NSString(data: kData, encoding: NSASCIIStringEncoding)!
        //  let kData1 : NSData  =   KStr.dataUsingEncoding(NSUTF8StringEncoding)!
        let kConvData: NSData   =   getUTF8Data(kData)
        do
        {
            let kObj:AnyObject? = try NSJSONSerialization.JSONObjectWithData(kConvData, options: .AllowFragments)
            self.completionHandler(kObj!, "", 99)
        } catch let caught as NSError {
            self.completionHandler("","Request failed.",97)
        } catch {
            // Something else happened.
            // Insert your domain, code, etc. when constructing the error.
            self.completionHandler("","Unknown error occured.",97)
        }
        self.cancelRequestTapped()
    }
    
    func cancelRequestTapped () {
        self.connection?.cancel()
        self.connection =   nil
        self.respData   =   nil
        self.removeFromSuperview()
    }
    
    func stringRepresentation(dict : NSDictionary) -> NSString {
        let mutablePairs : NSMutableArray = NSMutableArray()
        for key in dict.allKeys
        {
            let kVal:NSString   =   dict.objectForKey(key) as! NSString
            mutablePairs.addObject("\(key)=\(kVal)")
        }
        return mutablePairs.componentsJoinedByString("&")
    }
    func jsonRepresentation(dict : NSDictionary) -> NSString {
        //        let mutablePairs : NSMutableArray = NSMutableArray()
        //        for key in dict.allKeys
        //        {
        //            let kVal   =   dict.objectForKey(key)
        //            mutablePairs.addObject("\"\(key)\":\"\(kVal)\"")
        //        }
        //        let kFinVal: NSString   =   mutablePairs.componentsJoinedByString(",")
        //        return "{\(kFinVal)}"
        
        var kStrData: NSData    =   NSData()
        do
        {
            kStrData = try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
        } catch let caught as NSError {
        } catch {
            
        }
        
        return  NSString(data: kStrData, encoding: NSUTF8StringEncoding)!
        
        
    }
    
}


class MaskView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let kView   :UIView         =   UIView(frame: CGRectMake(0, 0, isIpad() ? 120: 80 , isIpad() ? 120: 80))
        kView.backgroundColor       =   UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        kView.layer.cornerRadius    =   10.0
        self.addSubview(kView)
        
        let activity : UIActivityIndicatorView   =   UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activity.startAnimating()
        kView.addSubview(activity)
        activity.center =   kView.center
        kView.center    =   self.center
        
        SharedAppController().appWindow!.rootViewController?.view.addSubview(self)
    }
    
}

class ProcessView: UIView {
    
    var  i = 0
    
    var klbl1 : UILabel?
    var klbl2 : UILabel?
    var klbl3 : UILabel?
    
    let kColor1     =   UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
    let kColor2     =   UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.0)
    let kColor3     =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let kSize : CGFloat  =   12.0
        let kSpec : CGFloat  =   5.0
        let kModSize : CGFloat  =   16.0
        let kTempView   =   UIView(frame: CGRectMake(0, 0, kSize * 3.0 + kSpec * 2.0, kSize))
        self.addSubview(kTempView)
        let tempImgView =   UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        self.addSubview(tempImgView)
        
        klbl1   =   UILabel(frame: CGRectMake(0, 0, kSize, kSize))
        klbl2   =   UILabel(frame: CGRectMake(kSize  + kSpec, 0, kSize, kSize))
        klbl3   =   UILabel(frame: CGRectMake(kSize * 2.0 + kSpec * 2.0,0, kSize, kSize))
        
        klbl1?.backgroundColor  =   kColor1
        klbl1?.layer.cornerRadius   =   kSize * 0.5
        klbl1?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl1!)
        
        klbl2?.backgroundColor  =   kColor1
        klbl2?.layer.cornerRadius   =   kSize * 0.5
        klbl2?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl2!)
        
        klbl3?.backgroundColor  =   kColor1
        klbl3?.layer.cornerRadius   =   kSize * 0.5
        klbl3?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl3!)
        
        kTempView.center    =   tempImgView.center
        
        
        klbl1?.frame   =   CGRectMake(0, 0, kModSize, kModSize)
        klbl2?.frame   =   CGRectMake(kSize  + kSpec, 0, kSize, kSize)
        klbl3?.frame   =   CGRectMake(kSize * 2.0 + kSpec * 2.0,0, kSize, kSize)
        klbl1?.layer.cornerRadius   =   kModSize * 0.5
        klbl2?.layer.cornerRadius   =   kSize * 0.5
        klbl3?.layer.cornerRadius   =   kSize * 0.5
        klbl1?.center.x =   kSize * 0.5
        klbl2?.center.x =   kSize * 0.5 + kSize  + kSpec
        klbl3?.center.x =   kSize * 0.5 + kSize * 2.0 + kSpec * 2.0
        
        klbl1?.center.y =   kSize * 0.5
        klbl2?.center.y =   kSize * 0.5
        klbl3?.center.y =   kSize * 0.5
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.20, target: self, selector: #selector(ProcessView.update), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func update() {
        i += 1
        let kSize : CGFloat  =   12.0
        let kModSize : CGFloat  =   16.0
        let kSpec : CGFloat  =   6.0
        
        if (i == 3)
        {
            i = 0
        }
        
        switch self.i {
            
        case 0:
            self.klbl1?.frame   =   CGRectMake(0, 0, kModSize, kModSize)
            self.klbl2?.frame   =   CGRectMake(kSize  + kSpec, 0, kSize, kSize)
            self.klbl3?.frame   =   CGRectMake(kSize * 2.0 + kSpec * 2.0,0, kSize, kSize)
            self.klbl1?.layer.cornerRadius   =   kModSize * 0.5
            self.klbl2?.layer.cornerRadius   =   kSize * 0.5
            self.klbl3?.layer.cornerRadius   =   kSize * 0.5
            self.klbl1?.center.x =   kSize * 0.5
            self.klbl2?.center.x =   kSize * 0.5 + kSize  + kSpec
            self.klbl3?.center.x =   kSize * 0.5 + kSize * 2.0 + kSpec * 2.0
            
            self.klbl1?.center.y =   kSize * 0.5
            self.klbl2?.center.y =   kSize * 0.5
            self.klbl3?.center.y =   kSize * 0.5
            
            break
        case 1:
            self.klbl1?.frame   =   CGRectMake(0, 0, kSize, kSize)
            self.klbl2?.frame   =   CGRectMake(kSize  + kSpec, 0, kModSize, kModSize)
            self.klbl3?.frame   =   CGRectMake(kSize * 2.0 + kSpec * 2.0,0, kSize, kSize)
            self.klbl1?.layer.cornerRadius   =   kSize * 0.5
            self.klbl2?.layer.cornerRadius   =   kModSize * 0.5
            self.klbl3?.layer.cornerRadius   =   kSize * 0.5
            self.klbl1?.center.x =   kSize * 0.5
            self.klbl2?.center.x =   kSize * 0.5 + kSize  + kSpec
            self.klbl3?.center.x =   kSize * 0.5 + kSize * 2.0 + kSpec * 2.0
            
            self.klbl1?.center.y =   kSize * 0.5
            self.klbl2?.center.y =   kSize * 0.5
            self.klbl3?.center.y =   kSize * 0.5
            break
        case 2:
            self.klbl1?.frame   =   CGRectMake(0, 0, kSize, kSize)
            self.klbl2?.frame   =   CGRectMake(kSize  + kSpec, 0, kSize, kSize)
            self.klbl3?.frame   =   CGRectMake(kSize * 2.0 + kSpec * 2.0,0, kModSize, kModSize)
            self.klbl1?.layer.cornerRadius   =   kSize * 0.5
            self.klbl2?.layer.cornerRadius   =   kSize * 0.5
            self.klbl3?.layer.cornerRadius   =   kModSize * 0.5
            self.klbl1?.center.x =   kSize * 0.5
            self.klbl2?.center.x =   kSize * 0.5 + kSize  + kSpec
            self.klbl3?.center.x =   kSize * 0.5 + kSize * 2.0 + kSpec * 2.0
            
            self.klbl1?.center.y =   kSize * 0.5
            self.klbl2?.center.y =   kSize * 0.5
            self.klbl3?.center.y =   kSize * 0.5
            break
        default:
            break
        }
    }
}

class ImageLoadProcessView: UIView {
    
    var  i = 0
    
    var klbl1 : UILabel?
    var klbl2 : UILabel?
    var klbl3 : UILabel?
    var klbl4 : UILabel?
    
    //    let kColor1     =   UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.0)
    //    let kColor2     =   UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
    //    let kColor3     =   UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.0)
    //    let kColor4     =   UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    
    let kColor1     =   UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.0)
    let kColor2     =   UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    let kColor3     =   UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    let kColor4     =   UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let kSize : CGFloat  =   10.0
        let kSpec : CGFloat  =   2.0
        
        let kTempView   =   UIView(frame: CGRectMake(0, 0, kSize * 2.0 + kSpec, kSize * 2.0 + kSpec))
        self.addSubview(kTempView)
        let tempImgView =   UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        self.addSubview(tempImgView)
        
        klbl1   =   UILabel(frame: CGRectMake(0, 0, kSize, kSize))
        klbl2   =   UILabel(frame: CGRectMake(kSize  + kSpec, 0, kSize, kSize))
        klbl3   =   UILabel(frame: CGRectMake(kSize  + kSpec,kSize  + kSpec, kSize, kSize))
        klbl4   =   UILabel(frame: CGRectMake(0,kSize  + kSpec, kSize, kSize))
        
        klbl1?.backgroundColor  =   kColor1
        klbl1?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl1!)
        
        klbl2?.backgroundColor  =   kColor4
        klbl2?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl2!)
        
        klbl3?.backgroundColor  =   kColor3
        klbl3?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl3!)
        
        klbl4?.backgroundColor  =   kColor2
        klbl4?.layer.masksToBounds  =   true
        kTempView.addSubview(klbl4!)
        
        
        kTempView.center    =   tempImgView.center
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.20, target: self, selector: #selector(ProcessView.update), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func update() {
        i += 1
        
        if (i == 4)
        {
            i = 0
        }
        switch i {
        case 0:
            klbl1?.backgroundColor  =   kColor1
            klbl2?.backgroundColor  =   kColor4
            klbl3?.backgroundColor  =   kColor3
            klbl4?.backgroundColor  =   kColor2
            break
        case 1:
            klbl1?.backgroundColor  =   kColor2
            klbl2?.backgroundColor  =   kColor1
            klbl3?.backgroundColor  =   kColor4
            klbl4?.backgroundColor  =   kColor3
            break
        case 2:
            klbl1?.backgroundColor  =   kColor3
            klbl2?.backgroundColor  =   kColor2
            klbl3?.backgroundColor  =   kColor1
            klbl4?.backgroundColor  =   kColor4
            break
        case 3:
            klbl1?.backgroundColor  =   kColor4
            klbl2?.backgroundColor  =   kColor3
            klbl3?.backgroundColor  =   kColor2
            klbl4?.backgroundColor  =   kColor1
            break
        default:
            break
        }
    }
}

class MessageAlertView : UIView
{
    override init(frame: CGRect) {
        super.init(frame: UIScreen.mainScreen().bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showMessage (kMessage: String, kColor : UIColor) -> CGFloat{
        
        let height = heightForView(kMessage, font: UIFont.init(name: Gillsans.Default.description, size: 15.0)!, width: self.frame.size.width - 30)
        
        let descLbl         =   UILabel(frame: CGRectMake(15,30, self.frame.size.width - 30 , height + 20))
        descLbl.textColor   =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        descLbl.font        =   UIFont.init(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment   =   .Center
        descLbl.text        =   kMessage
        descLbl.numberOfLines   =   0
        descLbl.backgroundColor =   kColor
        descLbl.layer.masksToBounds =   true
        descLbl.layer.cornerRadius  =   4.0
        self.addSubview(descLbl)
        GetAppDelegate().window?.addSubview(self)
        self.performSelector(#selector(MessageAlertView.removeView), withObject: nil, afterDelay: 2.0)
        
        return height
    }
    
    func removeView () {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alpha  =   0
            }) { (isComplete) -> Void in
                self.removeFromSuperview()
        }
    }
}

class OustandingAlertView : UIView
{
    var kCompletionHandler : (() -> ())?
    var kbutton : UIButton!
    var descLbl : UILabel!
    var height : CGFloat!
    var kView : UIView!
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showMessage (yView : UIView, completion completionHandler : () -> ()) -> OustandingAlertView {
        kCompletionHandler  =   completionHandler
        let kMessage    =   "ALERT: You have outstanding confirmations on the crew."
        height = heightForView(kMessage, font: UIFont.init(name: Gillsans.Default.description, size: 15.0)!, width: self.frame.size.width - 110)
        
        if (height < 50) {
            height  =   50.0
        }
        else {
            height  =   height + 10.0
        }
        kView   =   UIView(frame: CGRectMake(5,0, self.frame.size.width - 10 , height))
        kView.backgroundColor   =   UIColor(white: 0, alpha: 0.6)
        kView.layer.masksToBounds =   true
        kView.layer.cornerRadius  =   4.0
        self.addSubview(kView)
        descLbl         =   UILabel(frame: CGRectMake(5,0, kView.frame.size.width - 100 , height))
        descLbl.textColor   =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        descLbl.font        =   UIFont.init(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment   =   .Left
        descLbl.lineBreakMode   =   .ByWordWrapping
        descLbl.text        =   kMessage
        descLbl.numberOfLines   =   0
        descLbl.backgroundColor =   UIColor.clearColor()
        
        kView.addSubview(descLbl)
        
        kView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OustandingAlertView.tapGestureAction)))
        
        kbutton         =   UIButton(type: .Custom)
        kbutton.frame       =   CGRectMake(kView.frame.size.width - 90, 5, 85, 40)
        kbutton.setTitle("Confirm", forState: .Normal)
        kbutton.setTitle("!", forState: .Selected)
        kbutton.titleLabel?.font    =   UIFont.init(name: Gillsans.Default.description, size: 15.0)
        kbutton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        kbutton.layer.cornerRadius  =   3.0
        kbutton.layer.borderWidth   =   1.0
        kbutton.layer.borderColor   =   UIColor.whiteColor().CGColor
        kbutton.addTarget(self, action: #selector(OustandingAlertView.confirmTapped(_:)), forControlEvents: .TouchUpInside)
        kView.addSubview(kbutton)
        
        kbutton.center.y    =   height / 2.0
        
        
        yView.addSubview(self)
        
        for gView in (self.superview?.subviews)! {
            if (gView == self) {
                gView.frame =   CGRectMake(0,UIScreen.mainScreen().bounds.size.height - 64 - height - 5, UIScreen.mainScreen().bounds.size.width, height)
                
                gView.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
                UIView.animateWithDuration(0.3, animations: {
                    gView.layer.transform = CATransform3DMakeScale(1,1,1)
                    },completion: { finished in
                        UIView.animateWithDuration(0.1, animations: {
                            gView.layer.transform = CATransform3DMakeScale(0.9,0.9,1)
                            },completion: { finished in
                                UIView.animateWithDuration(0.2, animations: {
                                    gView.layer.transform = CATransform3DMakeScale(1,1,1)
                                })
                        })
                })
            }
        }
        
        return self
    }
    
    func confirmTapped (sender : UIButton) {
        
        if (kbutton.selected) {
            
            UIView.animateWithDuration(0.30, animations: { () -> Void in
                self.kbutton.selected    =   false
                for gView in (self.superview?.subviews)! {
                    if (gView == self) {
                        gView.frame =   CGRectMake(0,UIScreen.mainScreen().bounds.size.height - 64 - self.height - 5, UIScreen.mainScreen().bounds.size.width, self.height)
                    }
                }
                self.kView.frame    =   CGRectMake(5,0, self.frame.size.width - 10 , self.height)
                self.kbutton.frame       =   CGRectMake(self.kView.frame.size.width - 90, 5, 85, 40)
                self.kbutton.layer.cornerRadius  =   3.0
                self.descLbl.frame       =   CGRectMake(5,0, self.kView.frame.size.width - 100 , self.height)
                
                }, completion: { (isComplete) -> Void in
                    if (isComplete) {
                        self.descLbl.hidden      =   false
                        addTransitionEffectToView(self.descLbl)
                    }
            })
            
            
        }
        else {
            self.kCompletionHandler!()
        }
        
    }
    
    func tapGestureAction () {
        if (kbutton.selected) {
            
            UIView.animateWithDuration(0.30, animations: { () -> Void in
                self.kbutton.selected    =   false
                for gView in (self.superview?.subviews)! {
                    if (gView == self) {
                        gView.frame =   CGRectMake(0,UIScreen.mainScreen().bounds.size.height - 64 - self.height - 5, UIScreen.mainScreen().bounds.size.width, self.height)
                    }
                }
                self.kView.frame        =   CGRectMake(5,0, self.frame.size.width - 10 , self.height)
                self.kbutton.frame       =   CGRectMake(self.kView.frame.size.width - 90, 5, 85, 40)
                self.kbutton.layer.cornerRadius  =   3.0
                self.descLbl.frame       =   CGRectMake(5,0, self.kView.frame.size.width - 100 , self.height)
                
                }, completion: { (isComplete) -> Void in
                    if (isComplete) {
                        self.descLbl.hidden      =   false
                        addTransitionEffectToView(self.descLbl)
                    }
            })
        }
        else {
            
            UIView.animateWithDuration(0.30, animations: { () -> Void in
                self.kbutton.selected    =   true
                for gView in (self.superview?.subviews)! {
                    if (gView == self) {
                        gView.frame =   CGRectMake(UIScreen.mainScreen().bounds.size.width - 50 - 5,UIScreen.mainScreen().bounds.size.height - 64 - 50 - 5,50 , 50)
                    }
                }
                self.kView.frame        =    CGRectMake(0,0, 50 , 50)
                self.kbutton.frame       =   CGRectMake(5, 5, 40, 40)
                self.kbutton.layer.cornerRadius  =   20.0
                self.descLbl.hidden      =   true
            })
        }
    }
    
}