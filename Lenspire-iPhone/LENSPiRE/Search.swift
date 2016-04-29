//
//  SearchView.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 25/01/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation
import UIKit


class NewSearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource , SearchDataObjDelegate {
    
    var processView : ProcessView?
    var noLbl : UILabel?
    var searchBar: UISearchBar!
    var searchActive : Bool = false
    var filtered:[String] = []
    var data = ["San Francisco","New York","San Jose","Chicago","Los Angeles","Austin","Seattle"]
    var listTblView : UITableView?
    var suggessionsTblView : UITableView?
    var listObjects : NSArray   =   NSArray()
    var suggObjects : NSArray   =   NSArray()
    var noRecentSearchLbl : UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor   =   UIColor.whiteColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewSearchViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewSearchViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "menu.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(NewSearchViewController.menuBtnTapped), forControlEvents: .TouchUpInside)
        
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let kImgView    =   UIImageView(frame: CGRectMake(0, 0, 38, 38))
        kImgView.image  =   UIImage(named: "lenspire-logo.png")
        kImgView.userInteractionEnabled =   true
        kImgView.contentMode    =   .ScaleAspectFit
        kImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewSearchViewController.headBtnTapped)))
        
        self.navigationItem.titleView   =   kImgView
        
        
        searchBar   =   UISearchBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        searchBar.delegate = self
        searchBar.returnKeyType =   UIReturnKeyType.Done
        searchBar.enablesReturnKeyAutomatically =   false
        searchBar.placeholder   =   "Search"
        self.view.addSubview(searchBar)
        
        for kView in searchBar.subviews {
            if (kView.isKindOfClass(UITextField) == true)
            {
                kView.backgroundColor   =   UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
                kView.layer.borderColor   =   UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.0).CGColor
                kView.layer.borderWidth     =   1.0
                (kView as! UITextField).textColor    =   UIColor.whiteColor()
                (kView as! UITextField).font    =   UIFont(name: Gillsans.Default.description, size: 15.0)
                
            }
        }
        
        self.listObjects =  getRecentSearch()
        
        listTblView    =   UITableView(frame: CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - self.navigationController!.navigationBar.frame.size.height - 44 - 20), style: UITableViewStyle.Plain)
        listTblView?.delegate      =   self
        listTblView?.dataSource    =   self
        listTblView?.separatorStyle =   .None
        listTblView?.registerClass(SearchListCell.self, forCellReuseIdentifier: "LandProdCell")
        listTblView?.alwaysBounceVertical =   false
        self.view.addSubview(listTblView!)
        
        noRecentSearchLbl        =   UILabel(frame: CGRectMake(0, 0, listTblView!.frame.size.width  , listTblView!.frame.size.height))
        noRecentSearchLbl!.text       =   "No recent search data found."
        noRecentSearchLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        noRecentSearchLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
        noRecentSearchLbl!.textAlignment  =   .Center
        listTblView!.addSubview(noRecentSearchLbl!)
        suggessionsTblView    =   UITableView(frame: CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - self.navigationController!.navigationBar.frame.size.height - 44 - 20), style: UITableViewStyle.Plain)
        suggessionsTblView?.delegate      =   self
        suggessionsTblView?.dataSource    =   self
        suggessionsTblView?.separatorStyle =   .None
        suggessionsTblView?.backgroundColor =   UIColor.clearColor()
        suggessionsTblView?.registerClass(SearchSuggCell.self, forCellReuseIdentifier: "LandProdCell")
        suggessionsTblView?.alwaysBounceVertical =   false
        self.view.addSubview(suggessionsTblView!)
        self.suggessionsTblView?.hidden =   true
        
    //    searchBar.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let keyboardSize = (notification.userInfo! as NSDictionary).objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size
        self.suggessionsTblView?.frame  =   CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height  - 44 - CGFloat((keyboardSize?.height)!))
        self.listTblView!.frame    =   CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height  - 44 - CGFloat((keyboardSize?.height)!))
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.suggessionsTblView?.frame  =   CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)
        self.listTblView!.frame    =   CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height  - 44)
    }
    func menuBtnTapped () {
        presentLeftMenuViewController()
    }
    
    func headBtnTapped () {
        NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_HomeHeadTapped, object: nil)
    }
    
    func ImageDownloadReqFinished () {
        self.listTblView?.reloadData()
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == suggessionsTblView)
        {
            return suggObjects.count
        }
        else
        {
            return listObjects.count
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("LandProdCell")!
        
        
        if (tableView == suggessionsTblView)
        {
            cell.backgroundColor    =   UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            let str: String = (suggObjects.objectAtIndex(indexPath.row) as! NSDictionary).objectForKey("value") as! String
            cell.textLabel?.text = "\(str)"
            cell.textLabel?.numberOfLines   =   0
            cell.textLabel?.font    =   UIFont(name: Gillsans.Default.description, size: 15.0)
            cell.textLabel?.backgroundColor   =   UIColor.clearColor()
            cell.textLabel?.textColor   =   UIColor.whiteColor()
            
        }
        else
        {
            noRecentSearchLbl!.hidden    =   true
            for kTempView in cell.subviews {
                kTempView.removeFromSuperview()
            }
            
            let searchObj    =   listObjects.objectAtIndex(indexPath.row) as! String
            
            
            let descLbl        =   UILabel(frame: CGRectMake(20,0, self.view.frame.size.width - 40 , 50))
            descLbl.text       =   searchObj
            descLbl.textColor  =   UIColor.blackColor()
            descLbl.numberOfLines   =   0
            descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
            descLbl.textAlignment  =   .Left
            cell.addSubview(descLbl)
            
            let sepImg      =   UIImageView(frame: CGRectMake(0, 49, self.view.frame.size.width, 1))
            sepImg.backgroundColor  =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            cell.addSubview(sepImg)
            
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == suggessionsTblView)
        {
            let str: String = (suggObjects.objectAtIndex(indexPath.row) as! NSDictionary).objectForKey("value") as! String
            self.searchBar.text =   str
            
            self.suggObjects =   NSArray()
            self.suggessionsTblView?.reloadData()
            suggessionsTblView?.hidden  =   true
            
            self.searchBar.endEditing(true)
            
            saveRecentSearch(str)
            
            self.listObjects =   getRecentSearch()
            self.listTblView?.reloadData()
            
            let searchVC    =   SearchDetailViewController()
            searchVC.searchText =   str
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        else
        {
            let str: String = listObjects.objectAtIndex(indexPath.row) as! String
            
            let searchVC    =   SearchDetailViewController()
            searchVC.searchText =   str
            
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchActive = true;
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        self.suggObjects =   NSArray()
        self.suggessionsTblView?.reloadData()
        suggessionsTblView?.hidden  =   true
        self.searchBar.endEditing(true)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        suggessionsTblView?.hidden  =   false
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible   =   true
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),kLS_CP_firstname, searchText] , forKeys: [kLS_CP_UserId,kLS_CP_suggester,kLS_CP_searchName])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Search_GetAutoComlpete, parm: dict1, completion: { result , desc , code in
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible   =   false
            self.suggObjects =   NSArray()
            if ( code == 99)
            {
                print("\(result)")
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    
                    let kResults  =   result.objectForKey(kLS_CP_result)
                    if (kResults!.isKindOfClass(NSArray) == true)
                    {
                        self.suggObjects =   NSArray(array: (kResults as? NSArray)!)
                        
                    }
                    
                }
            }
            self.suggessionsTblView?.reloadData()
        })
    }
    
}

class SearchListCell: UITableViewCell {
    
}
class SearchSuggCell: UITableViewCell {
    
}

class SearchDetailViewController: UIViewController, SearchDataObjDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout{
    
    var objectsList : NSMutableArray?
    var collView: UICollectionView?
    var kPagingKey : NSString   =   ""
    var kStartKey : NSString    =   ""
    var kWidth : CGFloat?
    var isLoadingFinished : Bool?
    var loadedKeys : NSMutableArray?
    var isFirstTime : Bool  =   true
    var currentServiceReq   =   ServiceWrapper()
    var processView : ProcessView?
    var noLbl : UILabel?
    
    var searchText : NSString   =   ""
    
    override func viewDidLoad() {
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        objectsList    =   NSMutableArray()
        isLoadingFinished  =   false
        loadedKeys  =   NSMutableArray()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(SearchDetailViewController.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   searchText.uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
        let kSpac : CGFloat  = 3.0
        kWidth  =   (self.view.frame.size.width - (3 * kSpac)) / 2
        
        
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = kSpac
        layout.minimumInteritemSpacing = kSpac
        
        layout.sectionInset = UIEdgeInsets(top: kSpac, left: kSpac, bottom: kSpac, right: kSpac)
        
        collView = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: layout)
        collView!.dataSource   = self
        collView!.delegate     = self
        collView!.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        collView!.registerClass(SearchCollViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        
        collView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collView!)
        
        getFeedDetails(kPagingKey, bKey: kStartKey)
    }
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getFeedDetails (aKey: NSString, bKey : NSString) {
        if (isFirstTime == true)
        {
            noLbl        =   UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
            noLbl!.text       =   "No result found."
            noLbl!.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
            noLbl!.font       =   UIFont(name: Gillsans.Default.description, size: 15.0)
            noLbl!.textAlignment  =   .Center
            self.view.addSubview(noLbl!)
            self.noLbl!.hidden    =   true
            processView     =   ProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height - 64))
            self.view.addSubview(processView!)
        }
        
        loadedKeys?.addObject(aKey)
        
        
        let dict1: NSMutableDictionary   =   NSMutableDictionary(objects: [getUserID(),aKey, searchText, bKey] , forKeys: [kLS_CP_UserId,kLS_CP_start,kLS_CP_searchName,kLS_CP_startKey])
        
        ServiceWrapper(frame: CGRectZero).postToCloud(kLS_CM_Search_GetSearchData, parm: dict1, completion: { result , desc , code in
            self.processView?.removeFromSuperview()
            if ( code == 99)
            {
                self.processView?.removeFromSuperview()
                print("\(result)")
                var isSuccess : Bool =    false
                if (result.isKindOfClass(NSDictionary) == true && result.allKeys.count > 0 )
                {
                    let kResults  =   result.objectForKey(kLS_CP_result)
                    
                    if (kResults!.isKindOfClass(NSNull) == false && kResults!.isKindOfClass(NSArray) == true)
                    {
                        isSuccess   =   true
                        self.isFirstTime =   false
                        if (result.objectForKey("start") != nil)
                        {
                            self.kPagingKey         =   "\(result.objectForKey("start")!)"
                            self.kStartKey         =   "\(result.objectForKey("startkey")!)"
                        }
                        else
                        {
                            self.isLoadingFinished =   true
                        }
                        
                        if (kResults?.count < 5)
                        {
                            self.isLoadingFinished =   true
                        }
                        
                        let brandDescriptor: NSSortDescriptor = NSSortDescriptor(key: kLS_CP_firstname as String, ascending: true)
                        let sortDescriptors: NSArray =  NSArray(object: brandDescriptor)
                        let sortedArray: NSArray = NSArray(array: (kResults as? NSArray)!).sortedArrayUsingDescriptors(sortDescriptors as! [NSSortDescriptor])
                        
                        let kTempArr : NSMutableArray   =   NSMutableArray()
                        for kDict in sortedArray {
                            
                            let searchObj : SearchDataObj   =   SearchDataObj().setDetails(kDict as! NSDictionary, kDelegate: self as SearchDataObjDelegate, kImgWidth: self.kWidth!)
                            
                            kTempArr.addObject(searchObj)
                            
                        }
                        
                        self.objectsList?.addObjectsFromArray(kTempArr as [AnyObject])
                        self.collView?.reloadData()
            
                    }
                }
                if (isSuccess == false || self.objectsList!.count == 0)
                {
                    if (self.isFirstTime == true)
                    {
                        self.isFirstTime =   false
                        self.noLbl!.hidden    =   false
                    }
                }
            }
            else
            {
                if (self.isFirstTime == true)
                {
                    self.isFirstTime        =   false
                    self.noLbl!.hidden      =   false
                    if((desc as NSString).isKindOfClass(NSNull) == false)
                    {
                        self.noLbl!.text      =   desc
                    }
                }
            }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func menuBtnTapped () {
        presentLeftMenuViewController()
    }
    func headBtnTapped () {
        NSNotificationCenter.defaultCenter().postNotificationName(kLS_Noti_HomeHeadTapped, object: nil)
    }
    func ImageDownloadReqFinished () {
        self.collView?.reloadData()
    }
    
    // MARK: - Collectionview Handlers -
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return objectsList!.count
    }
    
    //MARK: - CollectionView Waterfall Layout Delegate Methods (Required)
    
    //** Size for the cells in the Waterfall Layout */
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        // create a cell size from the image size, and return the size
        let feedObj: SearchDataObj    =   objectsList?.objectAtIndex(indexPath.row) as! SearchDataObj
        return CGSize(width: feedObj._imgWidth, height: feedObj._imgHeight)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! SearchCollViewCell
        
        let feedObj: SearchDataObj    =   objectsList?.objectAtIndex(indexPath.row) as! SearchDataObj
        cell.bgImg.frame        =   CGRect(x: 0, y: 0, width: feedObj._imgWidth , height: feedObj._imgHeight)
        cell.bgImg.image        =   UIImage()
        cell.backgroundColor    =   UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)

        cell.processView?.hidden    =   false
        if (feedObj._isThumbImgDownloadIntiated == false)
        {
            feedObj.downloadThumbImg()
        }
        if ((feedObj._isThumbImgDownloadIntiated) == true && (feedObj._isThumbImgDownloaded == true))
        {
            cell.bgImg.image    =   feedObj._thumbImg
            cell.processView?.hidden    =   true
        }
        
        if ((loadedKeys?.containsObject(kPagingKey) == false) && (isLoadingFinished == false) && (indexPath.row == objectsList!.count-5))
        {
            self.getFeedDetails(self.kPagingKey, bKey: self.kStartKey)
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
 
    }
    
}

class SearchCollViewCell: UICollectionViewCell {
    
    var bgImg: UIImageView!
    var feedObj: SearchDataObj?
    var processView : ImageLoadProcessView?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textFrame = CGRect(x: 0, y: 0, width: frame.size.width , height: frame.size.height)
        
        bgImg   =   UIImageView(frame: textFrame)
        bgImg.backgroundColor   =   UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        contentView.addSubview(bgImg)
        
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.frame.size.width  , self.frame.size.height))
        self.addSubview(processView!)
    }
}
