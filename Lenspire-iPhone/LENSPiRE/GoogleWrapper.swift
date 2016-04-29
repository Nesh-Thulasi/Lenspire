//
//  GoogleWrapper.swift
//  LENSPiRE
//
//  Created by Jeni on 22/01/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation

class GooglePlacesVC: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{
    var searchBar : UISearchBar?
    var tblview : UITableView?
    var completionHandler : ((String) -> ())!
    var searchActive : Bool = false
    var data: NSArray!
    let mutablePairs : NSMutableArray = NSMutableArray()
    var selectedAddress =   ""
    
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func doneBtnTapped () {
        self.completionHandler(selectedAddress)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(GooglePlacesVC.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        
        let disabledAtt =   [NSForegroundColorAttributeName: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        let normAtt     =   [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName:  UIFont(name: Gillsans.Default.description, size: 15.0)!]
        
        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(GooglePlacesVC.doneBtnTapped))
        aBarButtonItem1.setTitleTextAttributes(disabledAtt, forState: UIControlState.Disabled)
        aBarButtonItem1.setTitleTextAttributes(normAtt, forState: UIControlState.Normal)
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        self.navigationItem.rightBarButtonItem?.enabled     =   false
        
        
        searchBar   =   UISearchBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 44))
        searchBar!.delegate = self
        searchBar!.returnKeyType =   UIReturnKeyType.Done
        searchBar!.enablesReturnKeyAutomatically =   false
        searchBar!.placeholder   =   "Search"
        self.view.addSubview(searchBar!)
        
        for kView in searchBar!.subviews {
            if (kView.isKindOfClass(UITextField) == true)
            {
                kView.backgroundColor   =   UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
                kView.layer.borderColor   =   UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.0).CGColor
                kView.layer.borderWidth     =   1.0
                (kView as! UITextField).textColor    =   UIColor.whiteColor()
                (kView as! UITextField).font    =   UIFont(name: Gillsans.Default.description, size: 15.0)
                
            }
        }
        
        tblview    =   UITableView(frame: CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 108), style: UITableViewStyle.Plain)
        tblview?.delegate      =   self
        tblview?.dataSource    =   self
        tblview?.separatorStyle =   .None
        tblview?.registerClass(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        tblview?.alwaysBounceVertical =   true
        self.view.addSubview(tblview!)        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GooglePlacesVC.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GooglePlacesVC.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    func keyboardWillShow (notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.tblview?.frame.size.height = (self.tblview?.frame.size.height)! - keyboardFrame.size.height - 20
        })
    }
    func keyboardWillHide (notification: NSNotification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.tblview?.frame.size.height = (self.tblview?.frame.size.height)! + keyboardFrame.size.height + 20
        })
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func getLocationCompletion (completion : (String) -> ()) {
        self.completionHandler  =   completion
    }
    
    
    // search bar delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        mutablePairs.removeAllObjects()
        
        if searchText.isEmpty
        {
            searchBar.resignFirstResponder()
        }
        else
        {
            searchBar.becomeFirstResponder()
            
            let urlPath : String = "https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyD7HXr5TBvsZXeogIssYQPlVjAPQg6H1lE&input=\(searchText)"
            
            NSURLConnection.sendAsynchronousRequest(NSURLRequest(URL: NSURL(string: urlPath)!), queue: NSOperationQueue.mainQueue()) { (resp, kData, err) -> Void in
                
                if (err != nil)
                {
                    print(err!.localizedDescription)
                }
                else
                {
                    if ((resp as! NSHTTPURLResponse).statusCode == 200)
                    {
                        do {
                            let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(kData!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                            
                            let kDict: NSArray?   =   jsonResult.objectForKey("predictions") as? NSArray
                            var i : Int
                            
                            for (i = 0; i < kDict?.count; i += 1)
                            {
                                let kNewDict: NSDictionary? = kDict?.objectAtIndex(i) as? NSDictionary
                                var desCripName : NSString
                                
                                desCripName = (kNewDict?.objectForKey("description"))! as! NSString
                                
                                if self.mutablePairs.containsObject(desCripName)
                                {
                                    
                                }
                                else
                                {
                                    self.mutablePairs.addObject(desCripName)
                                }
                            }
                        }
                        catch let error as NSError
                        {
                            print(error.localizedDescription)
                        }
                        
                    }
                    else
                    {
                        print( NSHTTPURLResponse.localizedStringForStatusCode((resp as! NSHTTPURLResponse).statusCode))
                    }
                }
                self.tblview?.reloadData()
            }
        }
        self.tblview?.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mutablePairs.count > 0
        {
            return mutablePairs.count
        }
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:ScheduleCell   =   (tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as? ScheduleCell)!
        
        for kTempView in cell.subviews {
            kTempView.removeFromSuperview()
        }
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        cell.selectedBackgroundView = bgColorView
        
        
        let descLbl        =   UILabel(frame: CGRectMake(20,0, self.view.frame.size.width - 40 , 40))
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font            =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Left
        cell.addSubview(descLbl)
        descLbl.text = mutablePairs[indexPath.row] as? String
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationItem.rightBarButtonItem?.enabled     =   true
        self.selectedAddress    =   mutablePairs[indexPath.row] as! String
        
        self.searchBar?.endEditing(true)
        
        /*
        let url : NSString = "https://maps.googleapis.com/maps/api/geocode/json?address=\(mutablePairs[indexPath.row])&sensor=true"
        let urlStr : NSString = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url1 : NSURL = NSURL(string: urlStr as String)!
        print(url1)
        
        let request2: NSURLRequest = NSURLRequest(URL: url1)
        let response1: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        
        do {
            let dataVal1: NSData = try NSURLConnection.sendSynchronousRequest(request2, returningResponse: response1)
            do {
                let jsonResult: NSDictionary = try NSJSONSerialization.JSONObjectWithData(dataVal1, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let karr: NSArray?   =   jsonResult.objectForKey("results") as? NSArray
                
                var desCripName : NSDictionary
                desCripName = (karr?.objectAtIndex(0).objectForKey("geometry")?.objectForKey("location"))! as! NSDictionary
                
                //                latLocation = desCripName.objectForKey("lat") as? Double
                //                longLocation = desCripName.objectForKey("lng") as? Double
                //
                //                locationManager.startUpdatingLocation()
                searchBar?.resignFirstResponder()
                
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
*/
        
    }
}

