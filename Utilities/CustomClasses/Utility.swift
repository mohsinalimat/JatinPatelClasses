//
//  Utility.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 11/11/17 10:06 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit
import SVProgressHUD
import Moya

public struct Utility {
    
    
    /// App's name (if applicable).
    public static var appDisplayName: String? {
        // http://stackoverflow.com/questions/28254377/get-app-name-in-swift
        return Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
    
    /// This will return a App Vendor UUID
    public static var appVendorUUID: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    /// App's bundle ID (if applicable).
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    /// StatusBar height
    public static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// App current build number (if applicable).
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// Application icon badge current number.
    public static var applicationIconBadgeNumber: Int {
        get {
            return UIApplication.shared.applicationIconBadgeNumber
        }
        set {
            UIApplication.shared.applicationIconBadgeNumber = newValue
        }
    }
    
    /// App's current version (if applicable).
    public static var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// Current battery level.
    public static var batteryLevel: Float {
        return CURRENT_DEVICE.batteryLevel
    }
    
    /// Screen height.
    public static var screenHeight: CGFloat {
        #if os(iOS) || os(tvOS)
            return UIScreen.main.bounds.height
        #elseif os(watchOS)
            return CURRENT_DEVICE.screenBounds.height
        #endif
    }
    
    /// Screen width.
    public static var screenWidth: CGFloat {
        #if os(iOS) || os(tvOS)
            return UIScreen.main.bounds.width
        #elseif os(watchOS)
            return CURRENT_DEVICE.screenBounds.width
        #endif
    }
    
    /// Current orientation of device.
    public static var deviceOrientation: UIDeviceOrientation {
        return CURRENT_DEVICE.orientation
    }
    
    /// Check if app is running in debug mode.
    public static var isInDebuggingMode: Bool {
        // http://stackoverflow.com/questions/9063100/xcode-ios-how-to-determine-whether-code-is-running-in-debug-release-build
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    /// Check if multitasking is supported in current device.
    public static var isMultitaskingSupported: Bool {
        return UIDevice.current.isMultitaskingSupported
    }
    
    /// Current status bar network activity indicator state.
    public static var isNetworkActivityIndicatorVisible: Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
        }
    }
    
    /// Check if device is registered for remote notifications for current app (read-only).
    public static var isRegisteredForRemoteNotifications: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    /// Check if application is running on simulator (read-only).
    public static var isRunningOnSimulator: Bool {
        // http://stackoverflow.com/questions/24869481/detect-if-app-is-being-built-for-device-or-simulator-in-swift
        #if (arch(i386) || arch(x86_64)) && (os(iOS) || os(watchOS) || os(tvOS))
            return true
        #else
            return false
        #endif
    }
    
    /// Status bar visibility state.
    public static var isStatusBarHidden: Bool {
        get {
            return UIApplication.shared.isStatusBarHidden
        }
        set {
            UIApplication.shared.isStatusBarHidden = newValue
        }
    }
    
    /// Key window (read only, if applicable).
    public static var keyWindow: UIView? {
        return UIApplication.shared.keyWindow
    }
    
    ///  Most top view controller (if applicable).
    public static var mostTopViewController: UIViewController? {
        get {
            return UIApplication.shared.keyWindow?.rootViewController
        }
        set {
            UIApplication.shared.keyWindow?.rootViewController = newValue
        }
    }
    
    /// Class name of object as string.
    ///
    /// - Parameter object: Any object to find its class name.
    /// - Returns: Class name for given object.
    public static func typeName(for object: Any) -> String {
        let objectType = type(of: object.self)
        return String.init(describing: objectType)
    }
    
    
    /// Called when user takes a screenshot
    ///
    /// - Parameter action: a closure to run when user takes a screenshot
    public static func didTakeScreenShot(_ action: @escaping (_ notification: Notification) -> Void) {
        // http://stackoverflow.com/questions/13484516/ios-detection-of-screenshot
        _ = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: OperationQueue.main) { notification in
            action(notification)
        }
    }
    
    public static func getStringFromDate(_ format : String , date : Date) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)
    }
    
    public static func getDateFromString(_ date : String , dateFormat : String) -> Date {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: date) else {
            return Date()
        }
        return date
    }
    

    public static func UIViewControllerWithName (_ storyBoardName : String, _ viewControllerName : String) -> UIViewController {
        
        return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerName)
    }
    
    public static func rediractionToSidemenu () {
        
        let sideMenuVC = Utility.UIViewControllerWithName(StoryBoardID.dashboard, ViewControllerID.sideMenuVC) as! SideMenuVC
        let homeVC = Utility.UIViewControllerWithName(StoryBoardID.discoverHome, ViewControllerID.discoverVC) as! DiscoverVC
        let dashboardVC = Utility.UIViewControllerWithName(StoryBoardID.attorney, ViewControllerID.attorneyDashboardVC) as! AttorneyDashboardVC
        
        var newNav : UINavigationController!
        
        if let userType = appDelegateSharedInstance.userData.userType {
            if userType == "user" {
                 newNav  = UINavigationController.init(rootViewController: homeVC)
            } else {
                 newNav  = UINavigationController.init(rootViewController: dashboardVC)
            }
        }
        newNav.isNavigationBarHidden = true
        appDelegateSharedInstance.mainSideMenuViewController = LGSideMenuController.init(rootViewController: newNav, leftViewController: sideMenuVC, rightViewController: nil)
        appDelegateSharedInstance.mainSideMenuViewController?.leftViewBackgroundColor = UIColor.white
        appDelegateSharedInstance.mainSideMenuViewController?.leftViewPresentationStyle = .slideBelow
        appDelegateSharedInstance.mainSideMenuViewController?.leftViewWidth = UIScreen.main.bounds.size.width * 0.70
        appDelegateSharedInstance.mainSideMenuViewController?.isLeftViewSwipeGestureEnabled = false
        appDelegateSharedInstance.window?.rootViewController = appDelegateSharedInstance.mainSideMenuViewController
    }
    
    // Quickblox login
    public static func loginWithQB(completionBlock : @escaping ((Bool) -> Void)){
        
        let aUser = QBUUser.init()
        aUser.login = appDelegateSharedInstance.userData.email
        aUser.password = "loveInternational"
        
         SVProgressHUD.show()
        ServicesManager.instance().logIn(with: aUser) { (isLogin, strError) in
            UserDefaults.set(isLogin, forKey: IS_QB_LOGIN)
            if isLogin {
               appDelegateSharedInstance.registerForPushNotification()
            }
             SVProgressHUD.dismiss()
            completionBlock(isLogin)
        }
    }
    
    public static func createQBChatDialogID(_ friendQBId : String, _ dialogId : String = "", completionHandler : @escaping ((QBChatDialog) -> Void)){
        
        guard let aFriendID = UInt(friendQBId) else {
            return
        }
        
        if dialogId != "" {
            ServicesManager.instance().chatService.fetchDialog(withID: dialogId) { (existingDialogID) in
                 if let aChatDialogId = existingDialogID {
                    completionHandler(aChatDialogId)
                }
            }
        } else {
            ServicesManager.instance().chatService.createPrivateChatDialog(withOpponentID: aFriendID) { (qbResponse, chatDialogId) in
                if let error = qbResponse.error?.error?.localizedDescription{
                    print("Error creating private chat dialog",error)
                    MessageBar.show(.error, message: "SomethingWentWrong".localized)
                }
                if let aChatDialogId = chatDialogId{
                    completionHandler(aChatDialogId)
                }
            }
        }
    }
    
    public static func sessionExpire(moyaError: (MoyaError)) {
        
        if moyaError.response?.statusCode == 401 {
            UserDefaults.removeObject(forKey: USER_DATA)
            appDelegateSharedInstance.userData = nil
            
            if let vc = UIViewControllerWithName(StoryBoardID.main,ViewControllerID.loginVC) as? LoginVC {
                let newNav : UINavigationController = UINavigationController.init(rootViewController: vc)
                appDelegateSharedInstance.window?.rootViewController = newNav
                appDelegateSharedInstance.window?.makeKeyAndVisible()
            }
            MessageBar.show(.warning, message: "SESSION_EXPIRE".localized)
            
        } else {
             
        }
    }
   
}
