//
//  CustomViews.swift
//  LENSPiRE
//
//  Created by Nesh Mac1 on 14/01/16.
//  Copyright © 2016 nesh. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapDisplayView: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate {
    var mapView: MKMapView?
    var kTitle : String = ""
    var kSubtitle : String = ""
    var kLat : String = ""
    var kLang   : String    =   ""
    var locationManager : CLLocationManager!
    var kCurrentLat : String    =   ""
    var kCurrentLang   : String    =   ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.whiteColor()
        
        let aButton     =   UIButton(frame: CGRectMake(0, 0, 30, 30))
        aButton.setImage(UIImage(named: "back.png"), forState: .Normal)
        aButton.addTarget(self, action: #selector(MapDisplayView.backBtnTapped), forControlEvents: .TouchUpInside)
        
        let aBarButtonItem  =   UIBarButtonItem(customView: aButton)
        self.navigationItem.setLeftBarButtonItem(aBarButtonItem, animated: true)
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 24))
        descLbl.text       =   kTitle.uppercaseString
        if (self.kTitle.isEmpty)
        {
            descLbl.text       =   kSubtitle.uppercaseString
        }
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   12
        
        let descLbl1        =   UILabel(frame: CGRectMake(0,24, self.view.frame.size.width - 100, 20))
        descLbl1.text       =   kSubtitle.uppercaseString
        descLbl1.textColor  =   UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
        descLbl1.font       =   UIFont(name: Gillsans.Italic.description, size: 13.0)
        descLbl1.textAlignment  =   .Center
        descLbl1.center.x    =   1
        descLbl1.center.y    =   34
        kTempView.addSubview(descLbl1)
        
        self.navigationItem.titleView   =   kTempView
        
        
        mapView     =   MKMapView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64))
        self.view.addSubview(mapView!)
        self.mapView!.delegate = self
        
        
        if (kLang.isEmpty == false)
        {
            let location = CLLocationCoordinate2D(latitude: Double(kLat)!, longitude: Double(kLang)!)
            
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location, span)
            self.mapView!.setRegion(region, animated: true)
            
            let info1 = CustomPointAnnotation()
            info1.coordinate = location
            info1.title = self.kTitle
            info1.subtitle = self.kSubtitle
            info1.imageName = "locate.png"
            
            self.mapView!.addAnnotation(info1)
            self.mapView!.selectAnnotation(info1, animated: true)
        }
        else
        {
            CLGeocoder().geocodeAddressString(kSubtitle) { (placemarks, error) -> Void in
                if let placemark = placemarks?[0]  {
                    dispatch_async(dispatch_get_main_queue(), {
                        let newYorkLocation = placemark.location?.coordinate
                        
                        let span = MKCoordinateSpanMake(0.01, 0.01)
                        let region = MKCoordinateRegionMake(newYorkLocation!, span)
                        self.mapView!.setRegion(region, animated: true)
                        
                        let info1 = CustomPointAnnotation()
                        info1.coordinate = newYorkLocation!
                        
                        info1.title = self.kTitle
                        info1.subtitle = self.kSubtitle
                        
                        if (self.kTitle.isEmpty)
                        {
                            info1.title  =   self.kSubtitle
                        }
                        
                        info1.imageName = "locate.png"
                        
                        self.mapView!.addAnnotation(info1)
                        self.mapView!.selectAnnotation(info1, animated: true)
                    })
                }
            }
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        kCurrentLat = String(locValue.latitude)
        kCurrentLang = String(locValue.longitude)
        locationManager.stopUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    func backBtnTapped () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let capital = view.annotation as! CustomPointAnnotation
        _ = capital.title
        _ = capital.subtitle
        
        let MapNavigation = MapNavigationView()
        MapNavigation.kCurrentLatStr = kCurrentLat
        MapNavigation.kCurrentLangStr = kCurrentLang
        MapNavigation.kLatStr = kLat
        MapNavigation.kLangStr = kLang

        let nav =   UINavigationController(rootViewController: MapNavigation)
        self.presentViewController(nav, animated: true, completion: nil)
        
     //   MessageAlertView().showMessage(kLS_FeatureNotImplemented, kColor: UIColor.blackColor())
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if !(annotation is CustomPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
        }
        else {
            anView!.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named:cpa.imageName)
        let btn = UIButton(type: .DetailDisclosure)
        anView!.rightCalloutAccessoryView = btn
        
        return anView
    }
    
    func addBounceAnimationToView(view: UIView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale") as CAKeyframeAnimation
        bounceAnimation.values = [ 0.05, 1.1, 0.9, 1]
        
        let timingFunctions = NSMutableArray(capacity: bounceAnimation.values!.count)
        
        for _ in 0 ..< bounceAnimation.values!.count {
            timingFunctions.addObject(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        }
        bounceAnimation.timingFunctions = timingFunctions as? [CAMediaTimingFunction]
        bounceAnimation.removedOnCompletion = false
        
        view.layer.addAnimation(bounceAnimation, forKey: "bounce")
    }
}

protocol TLSSegmentViewDelegate {
    func segementSelected (segment : TLSSegment, index : Int)
}

class MapNavigationView : UIViewController,UIWebViewDelegate{
    
    var kLatStr : String = ""
    var kLangStr   : String    =   ""
    var kCurrentLatStr : String    =   ""
    var kCurrentLangStr   : String    =   ""
    var processView : ImageLoadProcessView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor   =   UIColor.clearColor()
        
        self.navigationController?.navigationBarHidden  =   false

        let aBarButtonItem1  =   UIBarButtonItem(title: "DONE", style: UIBarButtonItemStyle.Done, target: self, action: #selector(MapNavigationView.doneBtnTapped))
        self.navigationItem.setRightBarButtonItem(aBarButtonItem1, animated: true)
        
        let kTempView       =   UIView(frame: CGRectMake(0,0,2, 44))
        let descLbl        =   UILabel(frame: CGRectMake(0,0, self.view.frame.size.width - 100, 44))
        descLbl.text       =   "Google Maps".uppercaseString
        descLbl.textColor  =   UIColor.blackColor()
        descLbl.numberOfLines   =   0
        descLbl.font        =   UIFont(name: Gillsans.Default.description, size: 15.0)
        descLbl.textAlignment  =   .Center
        kTempView.addSubview(descLbl)
        descLbl.center.x    =   1
        descLbl.center.y    =   22
        self.navigationItem.titleView   =   kTempView
        
        
        let webV:UIWebView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        if (kCurrentLangStr == ""){
            
        }
        else {
            webV.loadRequest(NSURLRequest(URL: NSURL(string: "http://maps.google.com/maps?saddr=\(kCurrentLatStr),\(kCurrentLangStr)&daddr=\(kLatStr),\(kLangStr)")!))
            webV.delegate = self
            self.view.addSubview(webV)
        }
    }
    
    func webViewDidStartLoad(webView : UIWebView) {
        processView     =   ImageLoadProcessView(frame: CGRectMake(0, 0, self.view.frame.size.width  , self.view.frame.size.height))
        self.view.addSubview(processView!)
    }
    
    func webViewDidFinishLoad(webView : UIWebView) {
        self.processView?.removeFromSuperview()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("Webview fail with error \(error)")
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("didReceiveMemoryWarning")
    }
    
    func doneBtnTapped () {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }

}

class TLSSegmentView : UIView {
    var delegate   : TLSSegmentViewDelegate!   =   nil
    var selectedColor : UIColor!
    var normalColor : UIColor!
    var font : UIFont!
    var segmentsArray : NSMutableArray  =   NSMutableArray()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    init(frame: CGRect, textColor : UIColor, selectedTextColor : UIColor, textFont : UIFont) {
        self.normalColor    = textColor
        self.selectedColor  = selectedTextColor
        self.font           =   textFont
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    func addSegments (array : NSArray) {
        
        var kTotalWidth : CGFloat   =   0.0
        var kSpaceReamin : CGFloat   =   0.0
        var additionSpace : CGFloat   =   0.0
        var isExceeding : Bool      =   false
        for kTitle in array {
            kTotalWidth =   kTotalWidth + widthForView(kTitle as! String, font: self.font)
            
            if (widthForView(kTitle as! String, font: self.font) > UIScreen.mainScreen().bounds.size.width / CGFloat(array.count)) {
                isExceeding =   true
            }
        }
        
        if (kTotalWidth < UIScreen.mainScreen().bounds.size.width) {
            kSpaceReamin    =   UIScreen.mainScreen().bounds.size.width - kTotalWidth
            additionSpace   =   kSpaceReamin / CGFloat(array.count)
            
        }
        
        var kStratX : CGFloat =   0.0
        
        for i in 0  ..< array.count  {
          
            if (isExceeding) {
                if (i == 0) {
                    kStratX = 0
                }
                else {
                    kStratX =  kStratX + CGFloat(widthForView(array[i - 1] as! String, font: self.font)) + additionSpace
                }
                let segment = TLSSegment(frame: CGRectMake(kStratX, 0, widthForView(array[i] as! String, font: self.font) +
                    additionSpace, self.frame.size.height), textColor: self.normalColor, selectedTextColor: self.selectedColor, textFont: self.font)
                segment.text    =   array[i] as? String
                segment.index   =   i
                segment.segmentMain =   self
                self.addSubview(segment)
                
                self.segmentsArray.addObject(segment)
            }
            else {
                
                let segment = TLSSegment(frame: CGRectMake(kStratX, 0, UIScreen.mainScreen().bounds.size.width / CGFloat(array.count), self.frame.size.height), textColor: self.normalColor, selectedTextColor: self.selectedColor, textFont: self.font)
                segment.text    =   array[i] as? String
                segment.index   =   i
                segment.segmentMain =   self
                self.addSubview(segment)
                
                self.segmentsArray.addObject(segment)
                
                kStratX =   kStratX + (UIScreen.mainScreen().bounds.size.width / CGFloat(array.count))
            }
            
            
        }
    }
    
    func selectSegementAtIndex(index:Int) {
        if (index < self.segmentsArray.count) {
            for var i = 0 ; i < self.segmentsArray.count ; i += 1 {
                let segment =   self.segmentsArray.objectAtIndex(i) as! TLSSegment
                if (index == i) {
                    segment.select()
                    delegate.segementSelected(segment, index: index)
                }
                else {
                    segment.unselect()
                }
            }
        }
    }
    
}


class TLSSegment : UILabel {
    var selectedColor : UIColor!
    var normalColor : UIColor!
    var kFont : UIFont!
    var index : Int =   0
    var segmentMain : TLSSegmentView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    init(frame: CGRect, textColor : UIColor, selectedTextColor : UIColor, textFont : UIFont) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
        self.normalColor    =   textColor
        self.selectedColor  =   selectedTextColor
        self.kFont           =   textFont
        self.font   =   kFont
        self.userInteractionEnabled =   true
        self.textAlignment  =   .Center
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TLSSegment.tapgestureFired)))
    }
    
    func unselect () {
        self.textColor  = self.normalColor
    }
    func select () {
        self.textColor  = self.selectedColor
    }
    
    func tapgestureFired () {
        self.segmentMain.selectSegementAtIndex(index)
    }
}

func widthForView(text:String, font:UIFont) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, 50))
    label.lineBreakMode = NSLineBreakMode.ByWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.width
}
