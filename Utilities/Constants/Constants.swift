//
//  Constants.swift
//  StructureApp
// 
//  Created By:  IndiaNIC Infotech Ltd
//  Created on: 10/11/17 4:00 PM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


import Foundation
import UIKit


enum LastSeenViewController {
    case None
    case SignUpVC
    case DiscoverVC
    case ConnectionsVC
    case AttorneyListVC
}

var appDelegateSharedInstance: AppDelegate {
    
    return UIApplication.shared.delegate as! AppDelegate
}

/// General object of Application Delegate
let APP_DELEGATE: AppDelegate                   =   UIApplication.shared.delegate as! AppDelegate

/// General object of FileManager
let FILE_MANAGER                                =   FileManager.default

/// General object of Main Bundle
let MAIN_BUNDLE                                 =   Bundle.main

/// General object of Main Thread
let MAIN_THREAD                                 =   Thread.main

/// General object of Main Screen
let MAIN_SCREEN                                 =   UIScreen.main

/// General object of UserDefaults
//let USER_DEFAULTS                               =   UserDefaults.standard

/// General object of UIApplication
let APPLICATION                                 =   UIApplication.shared

/// General object of Current Device
let CURRENT_DEVICE                              =   UIDevice.current

/// General object of Current Landuage
let CURRENT_LANGUAGE                            =   NSLocale.current.languageCode

/// General object of Network Activity Indicator
let NETWORK_ACTIVITY                            =   APPLICATION.isNetworkActivityIndicatorVisible
/// Storyboard name

let USER = "User"
let DASHBOARD = "Dashboard"
let SETTINGS = "Settings"

public let appName = "Loveternational"
public let kAllowedFileTypes = ["png", "jpeg", "jpg", "xls", "doc", "docx", "pdf", "txt"]
public let kBaseURL : String = "http://ec2-54-219-227-142.us-west-1.compute.amazonaws.com:5063/api/"
public let kBaseURL2 : String = "http://node.indianic.com:4080/api/"
public let kBaseURL1 : String = "http://10.2.4.127:5063/api/"

public let kBraintreePaymentURLSchemas : String = "com.loveternational.payment"




// QUICKBLOX KEYS
let QB_APP_ID : UInt = 72579
let QB_AUTH_KEY = "KBxZPOVwwJfxyV2"
let QB_AUTH_SECRET = "7y7jeeYaaRJ68mM"
let QB_ACCOUNT_KEY = "Fy87n8MEXQ4ZyKUP9BZL"


//let UserDefaults = Foundation.UserDefaults.standard

// Max limits for validation
let MAX_LENGTH_FOR_PHONE_NO = 10
let MAX_LENGTH_FOR_PASSWORD = 40
let MAX_LENGTH_FOR_REVIEW = 100
let MAX_LENGTH_FOR_ABOUT_US = 100
let MAX_LENGTH_FOR_DISTANCE = 5
let MAX_LENGTH_FOR_PIN_NO = 6

// User Data Keys...
let USER_FILTERS = "userFilters"
let USER_DATA = "userData"
let IS_QB_LOGIN = "isUserQbLogin"
let USER_DEVICE_TOKEN = "deviceToken"
let USER_SUBSCRIBTION_STATUS = "userSubscribtionStatus"

struct EncryptionKey {
    
    /// EncryptionKey for RNCryptor
    ///
    ///     EncryptionKey.kay
    ///
    static let key                                 = "vjkd#g&m36@k8?j3m2dvm0ke5f"
    
}

let UIViewControllerWithName : (_ storyBoardID: String, _ viewControllerID : String) -> UIViewController? = {storyBoardName,viewControllerID in
    
    return UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewController(withIdentifier: viewControllerID)
}


let ddMMyyy = "dd/MM/yyyy"
let yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
let yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
let MMMMddyyyyhhssaaa = "MMMM dd, yyyy hh:ss aaa"
let yyyy = "yyyy"


let UserDefaults = Foundation.UserDefaults.standard

struct AlertMessage {
    
        static let kAlertMsgRequestTimeOut = "Request time out please try again later"
        static let kAlertMsgSomeThingWentWrong = "Something went wrong please try again later"
    
        static let kAlertMsgLogout = "Are you sure you want to logout? Once you have logged out, you will no longer receive notifications."
        static let kAlertMessageRequiredField: (String) -> String = { name in
                return "Please enter \(name)"
            }
    
    }


struct Constant {
    
        static let AppName = "Loveternational"
    static let maxRecordDuration = 15.0
    

    struct AppKeys {
        
        static let kGoogleApiKey = ""
        static let kGooglePlaceApiKey = ""
        static let appLink = "https://itunes.apple.com/gb/app/messenge/id3106397?mt=8"
        static let appID = ""
        static let reviewString = ""
        
    }
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
        static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    }
    
    struct FontName {
        static let kFontOpenSansRegular = "OpenSans-Regular"
        static let kFontOpenSansMedium = ""
        static let kFontOpenSansBold = "OpenSans-Bold"
        static let kFontOpenSansSemiBold = "OpenSans-SemiBold"
    }
    
    
    struct NoDataFound {
        static let kCompanyMessage = "No company found."
        static let kUpcomingAppointmentMessage = "No upcoming Appointment is available."
        static let kPastAppointmentMessage = "No appointment found."
        static let kTimeSlotMessage = "No TimeSlot available."
    }
    
    
    
    struct NotificationType {
       
        static let kProfilePicsUploaded = "profilePicsUploaded"
        static let kProfilePicsUploadModelKey = "ProfilePicsUploadProfilePics"
        
        static let kProfileVideoUploaded = "profileVideoUploaded"
        static let kVideoUploadProfileVideoKey = "VideoUploadProfileVideo"
        
        static let kNotificationPush = "NotificationPush"
    }
    
    
    struct API {
        static let kBaseURLWithAPIName : (String) -> String = {name in
            return "\(kBaseURL)\(name)"
        }
    }
}
