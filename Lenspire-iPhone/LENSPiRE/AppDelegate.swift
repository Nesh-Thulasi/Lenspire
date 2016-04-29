//
//  AppDelegate.swift
//  Lenspire
//
//  Created by Thulasi on 27/07/15.
//  Copyright (c) 2015 Nesh. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appController: AppController?
    var loginDetails: LoginDetails?
    var devToken: String =   ""
    var tracker : GAITracker!
    var kURL    :   String =  ""
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let appDefaults = [kAllowTracking: true]
        NSUserDefaults.standardUserDefaults().registerDefaults(appDefaults)
        // User must be able to opt out of tracking
        
        GAI.sharedInstance().optOut =   NSUserDefaults.standardUserDefaults().boolForKey(kAllowTracking)
        GAI.sharedInstance().dispatchInterval    =   -1
        GAI.sharedInstance().trackUncaughtExceptions    =   true
        self.tracker    =   GAI.sharedInstance().trackerWithName("Lenspire", trackingId: GA_TrackId)
        /*
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        */
        
        // Override point for customization after application launch.
        window          =   UIWindow(frame: UIScreen.mainScreen().bounds)
        appController   =   AppController()
        appController!.appWindow   =   window
        appController!.loadStartupView()
        
        window?.makeKeyAndVisible()
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USEast1,
            identityPoolId:"us-east-1:8ac2def9-8284-4c9b-ad51-3575710d70a5")
        let configuration = AWSServiceConfiguration(region:.USWest2, credentialsProvider:credentialsProvider)
        AWSServiceManager.defaultServiceManager().defaultServiceConfiguration = configuration
        
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("ServerSetting") == nil) {
            NSUserDefaults.standardUserDefaults().setObject("https://test.lenspire.com/", forKey: "ServerSetting")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        kURL    =   NSUserDefaults.standardUserDefaults().objectForKey("ServerSetting") as! String
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.defaultsChanged(_:)), name: NSUserDefaultsDidChangeNotification, object: nil)
        
        Fabric.with([Crashlytics.self])
        return true
    }
    
    
    func defaultsChanged(notification:NSNotification){
        if let defaults = notification.object as? NSUserDefaults {
            //get the value for key here
            
            if (kURL != defaults.objectForKey("ServerSetting") as! String) {
                kURL    =   NSUserDefaults.standardUserDefaults().objectForKey("ServerSetting") as! String
                SharedAppController().loadStartupView()
            }
            
        }
    }

    /*
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0 ..< deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        devToken    =   tokenString
        print("tokenString: \(tokenString)")
    }
    
    func application(application: UIApplication,didFailToRegisterForRemoteNotificationsWithError error: NSError) {
            NSLog("Failed to get token; error: %@", error)
    }
   */
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    
        let kString =   url.absoluteURL.absoluteString.stringByReplacingOccurrencesOfString("lenspire://", withString: "")
        let kArr    =   kString.componentsSeparatedByString("&")
        if (kArr.count == 3) {
            if ((kArr[0] as String).componentsSeparatedByString("=")[0] == "code" && (kArr[1] as String).componentsSeparatedByString("=")[0] == "email" && (kArr[2] as String).componentsSeparatedByString("=")[0] == "userId")
            {
                let code    =   (kArr[0] as String).componentsSeparatedByString("=")[1]
                let email   =   (kArr[1] as String).componentsSeparatedByString("=")[1]
                let userId   =   (kArr[2] as String).componentsSeparatedByString("=")[1]
                
                SharedAppController().loadVerificationCodeView(code, email: email, userId: userId)
            }
        }
        return true
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

