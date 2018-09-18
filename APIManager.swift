//
//  APIManager.swift
//  MoyaSample
//
//  Created By: Jatin Patel
//  Created on: 06/03/18 1:46 PM
//
//  Copyright © 2017 Jatin Patel. All rights reserved.
//
//

// https://github.com/Moya/Moya
// https://medium.com/@vsemenchenko/writing-network-layer-with-moya-for-swift-3aa039a6e693
// https://medium.com/@malcolmcollin/movie-app-swift-4-part-one-e6e03a993600

import Foundation
import UIKit
import Moya
import Alamofire
import SVProgressHUD
import SwiftyJSON


class APIManager: Alamofire.SessionManager {
    
    static let shared: APIManager = {
        
        let configuration = URLSessionConfiguration.default
        //        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 120 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 120 // as seconds, you can set your resource timeout
        //        configuration.requestCachePolicy = .useProtocolCachePolicy
        return APIManager(configuration: configuration)
        
    }()
    
}

class API {
    
    //    let pl = NetworkLoggerPlugin.init(verbose: true, cURL: nil, output: nil, requestDataFormatter: nil, responseDataFormatter: nil)
    
    //    static let provider = MoyaProvider<MyServerAPI>()
    static let provider = MoyaProvider<MyServerAPI>(manager: APIManager.shared, plugins: [NetworkLoggerPlugin(verbose: true)])
    
    //    static let provider = MoyaProvider<MyServerAPI>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    /// Use this method to call an API
    ///
    /// ````
    /// API.request(target: .getNeighborhoods(), success: { (response) in
    /// // parse your data
    /// print("parse your data", response)
    /// }, error: { (error) in
    /// // show error from server
    /// print("show error from server", error)
    /// }, failure: { (error) in
    /// // show Moya error
    /// print("show Moya error", error)
    /// })
    /// ````
    /// - Parameters:
    ///   - target: Your API Target.
    ///   - successCallback: Success block.
    ///   - errorCallback: Error block.
    ///   - failureCallback: failure block.
    static func request(target: MyServerAPI, isSilent:Bool = false, success successCallback: @escaping (JSON) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        // Progress is added to track. It is not working 100% so can be removed during final implementation.
        if !isSilent {
            SVProgressHUD.show()
        }
        provider.request(target, progress: { (response) in
            print(response.progress)
        }) { (result) in
            switch result {
            case .success(let response):
                // 1:
                
                SVProgressHUD.dismiss()
                print(response.statusCode)
                 if response.statusCode >= 200 && response.statusCode <= 300 {
                    if let json = try? JSON.init(data: response.data, options: JSONSerialization.ReadingOptions.allowFragments) {
                        successCallback(json)
                    }
                    else {
                        SVProgressHUD.dismiss()
                        let error = NSError(domain: "com.cosmic.networkLayer", code: 0, userInfo: [NSLocalizedDescriptionKey: "Parsing Error"])
                        errorCallback(error)
                    }
                } else {
                    // 2:
                    let error = NSError(domain:"com.indianic.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                // 3:
                SVProgressHUD.dismiss()
                if error.response?.statusCode == 401 {
                    UserDefaults.removeObject(forKey: USER_DATA)
                    appDelegateSharedInstance.userData = nil
                    
                    if let vc = UIViewControllerWithName(StoryBoardID.main,ViewControllerID.loginVC) as? LoginVC {
                        let newNav : UINavigationController = UINavigationController.init(rootViewController: vc)
                        appDelegateSharedInstance.window?.rootViewController = newNav
                        appDelegateSharedInstance.window?.makeKeyAndVisible()
                    }
                    MessageBar.show(.warning, message: "SESSION_EXPIRE".localized)
                    
                } else {
                    MessageBar.show(.error, message: error.localizedDescription)
                }
                failureCallback(error)
            }
        }
    }
}

// 1:
enum MyServerAPI {
    
    case userRegister(param: [String: Any])
    case login(param: [String: Any])
    case forgotPassword(param: [String: Any])
    case changePassword(param: [String: Any])
    case updateDashBoardSettings(param: [String: Any])
    case logout()
    case userCompleteProfile(param: [String: Any])
    case addUpdateImages(param: [String: Any])
    case uploadProfileVideo(param: [String: Any])
    case discoverUser(param: [String: Any])
    case getCountryList()
    case getStateListByCountryId(param: [String: Any])
    case getEducation()
    case sendRequest(param: [String: Any])
    case reportAbuse(param: [String: Any])
    case getUserProfile(param: [String: Any])
    case getNotificationList(param: [String: Any])
    case getCrushList(param: [String: Any])
    case getInterestList(param: [String: Any])
    case getRequestList(param: [String: Any])
    case acceptRejectRequest(param: [String: Any])
    case getAttornyClientList(param: [String: Any])
    case getUserSettings()
    case addQBDialogId(param: [String: Any])
    case getAttorneyRatingsList(param: [String: Any])
    case getApprovedAttorneyList(param: [String: Any])
    case postAttorneyRatting(param: [String: Any])
    case getBrintreeClientToken()
    case postBraintreePaymentNonce(param: [String: Any])
}


// 2:
extension MyServerAPI: TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL {
        guard let url = URL(string: SERVER.URL.development) else { fatalError("baseURL could not be configured") }
        return url
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .userRegister:
            return "userRegister"
        case .login:
            return "login"
        case .forgotPassword:
            return "forgotPasswordMail"
        case .changePassword:
            return "changePassword"
        case .updateDashBoardSettings:
            return "updateDashBoardSettings"
        case .logout:
            return "logout"
        case .userCompleteProfile:
            if let userID = appDelegateSharedInstance.userData.id {
                return "addEditProfile/" + userID
            }
            return "addEditProfile"
        case .addUpdateImages:
            if let userID = appDelegateSharedInstance.userData.id {
                return "addUpdateImages/" + userID
            }
            return "addUpdateImages"
        case .uploadProfileVideo:
            if let userID = appDelegateSharedInstance.userData.id {
                return "uploadProfileVideo/" + userID
            }
            return "uploadProfileVideo"
        case .discoverUser:
            if let userID = appDelegateSharedInstance.userData.id {
                return "discoverUser/" + userID
            }
            return "discoverUser"
        case .getCountryList:
            if let userType = appDelegateSharedInstance.userData.userType {
                return "getCountryList/" + userType
            }
            return "getCountryList/user"
        case .getStateListByCountryId(let param):
            if let countryId = param["countryId"] {
                return "getStateListByCountryId/\(countryId)"
            }
            return "getStateListByCountryId"
            
        case .getEducation:
            return "getEducation"
        case .sendRequest:
            return "sendRequest"
        case .reportAbuse:
            return "reportAbuse"
            
        case .getUserProfile(let param):
            
            if let userID = param[SERVER.RequestParam.GetProfileRequest.userID] as? String {
                return "getUserProfile/" + userID
            }
            else if let userID = appDelegateSharedInstance.userData.id {
                return "getUserProfile/" + userID
            }
            
            return "getUserProfile"
            
        case .getCrushList:
            return "getCrushList"
        case .getInterestList:
            return "getInterestList"
        case .getRequestList:
            return "getRequestList"
            
        case .acceptRejectRequest:
            return "acceptRejectRequest"
            
        case .getNotificationList:
            return "getNotificationLists"
        case .getAttornyClientList:
            return "getAttornyClientList"
            
        case .getUserSettings:
            return "getUserSettings"

        case .addQBDialogId:
            return "addQBDialogId"

        
        case .getAttorneyRatingsList:
            return "getAttorneyRatings"
        case .getApprovedAttorneyList:
            return "getApprovedAttorneyList"
            
        case .postAttorneyRatting:
            return "addReviews"
            
        case .getBrintreeClientToken:
            return "client_token"
        
        case .postBraintreePaymentNonce:
            return "checkout"

            
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .userRegister, .login, .forgotPassword, .changePassword, .updateDashBoardSettings, .userCompleteProfile, .addUpdateImages, .uploadProfileVideo, .discoverUser, .sendRequest, .reportAbuse, .getCrushList, .getInterestList, .getRequestList, .getNotificationList,.acceptRejectRequest, .getAttornyClientList, .getAttorneyRatingsList, .addQBDialogId, .getApprovedAttorneyList, .postAttorneyRatting, .postBraintreePaymentNonce:

            return .post
            
        case .logout, .getCountryList, .getEducation, .getUserProfile, .getStateListByCountryId, .getUserSettings, .getBrintreeClientToken:
            return .get
            
        }
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {

        case .userRegister(let param), .login(let param), .forgotPassword(let param), .changePassword(let param), .updateDashBoardSettings(let param), .discoverUser(let param), .sendRequest(let param), .reportAbuse(let param), .getCrushList(let param), .getInterestList(let param), .getRequestList(let param), .getNotificationList(param: let param), .acceptRejectRequest(let param), .getAttornyClientList(let param), .getAttorneyRatingsList(let param), .addQBDialogId(let param), .getApprovedAttorneyList(let param), .postAttorneyRatting(let param), .postBraintreePaymentNonce(let param):

            
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
            
        case .userCompleteProfile(let param):
            
            var aDictData = param
            var formData = fillFormDataSkippingFile(param: param)
            let data = UIImageJPEGRepresentation(aDictData["profile_url"] as! UIImage, 0.5)
            formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_url", fileName: "image.png", mimeType: "image/png"))
            if let userType = appDelegateSharedInstance.userData.userType {
                if userType == "attorney" {
                    let data = UIImageJPEGRepresentation(aDictData["license_photo"] as! UIImage, 0.5)
                    formData.append(MultipartFormData.init(provider: .data(data!), name: "license_photo", fileName: "image.png", mimeType: "image/png"))
                }
            }
            
            return .uploadMultipart(formData)
            
        case .addUpdateImages(let param):
            
            var aDictData = param
            var formData = fillFormDataSkippingFile(param: param)
            
            if let imgUserProfilePic1 = aDictData["profile_pic_1"] as? UIImage {
                
                let data = UIImageJPEGRepresentation(imgUserProfilePic1, 0.5)
                formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_pic_1", fileName: "profile_pic_1.png", mimeType: "image/png"))
            }
            
            if let imgUserProfilePic2 = aDictData["profile_pic_2"] as? UIImage {
                
                let data = UIImageJPEGRepresentation(imgUserProfilePic2, 0.5)
                formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_pic_2", fileName: "profile_pic_2.png", mimeType: "image/png"))
            }
            
            if let imgUserProfilePic3 = aDictData["profile_pic_3"] as? UIImage {
                
                let data = UIImageJPEGRepresentation(imgUserProfilePic3, 0.5)
                formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_pic_3", fileName: "profile_pic_3.png", mimeType: "image/png"))
            }
            
            if let imgUserProfilePic4 = aDictData["profile_pic_4"] as? UIImage {
                
                let data = UIImageJPEGRepresentation(imgUserProfilePic4, 0.5)
                formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_pic_4", fileName: "profile_pic_4.png", mimeType: "image/png"))
            }
            
            if let profile_pic_5 = aDictData["profile_pic_5"] as? UIImage {
                
                let data = UIImageJPEGRepresentation(profile_pic_5, 0.5)
                formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_pic_5", fileName: "profile_pic_5.png", mimeType: "image/png"))
            }
            
            if let profile_pic_6 = aDictData["profile_pic_6"] as? UIImage {
                
                let data = UIImageJPEGRepresentation(profile_pic_6, 0.5)
                formData.append(MultipartFormData.init(provider: .data(data!), name: "profile_pic_6", fileName: "profile_pic_6.png", mimeType: "image/png"))
            }
            
            return .uploadMultipart(formData)
            
        case .uploadProfileVideo(let param):
            
            var aDictData = param
            var formData = fillFormDataSkippingFile(param: param)
            
            if let urlVideo = aDictData["video_url"] as? URL {
                do {
                    let data = try NSData(contentsOf: urlVideo, options: NSData.ReadingOptions())
                    
                    formData.append(MultipartFormData.init(provider: .data(data as Data), name: "video_url", fileName: "video.mp4", mimeType: "video/mp4"))
                    
                } catch {
                    print(error)
                }
            }
            
            return .uploadMultipart(formData)
        case .logout, .getEducation, .getCountryList, .getUserProfile, .getStateListByCountryId, .getUserSettings, .getBrintreeClientToken:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
        
    }
    
    /// The headers to be used in the request.
    var headers: [String : String]? {
        switch self {
        case .userRegister, .login, .forgotPassword, .getCountryList, .getEducation, .getStateListByCountryId:
            return ["Content-Type": "application/json"]

        case .changePassword, .updateDashBoardSettings, .logout, .userCompleteProfile, .addUpdateImages, .uploadProfileVideo, .discoverUser, .sendRequest, .reportAbuse, .getUserProfile, .getCrushList, .getInterestList, .getRequestList, .getNotificationList, .acceptRejectRequest, .getAttornyClientList, .getUserSettings, .getAttorneyRatingsList, .addQBDialogId , .getApprovedAttorneyList, .postAttorneyRatting, .getBrintreeClientToken, .postBraintreePaymentNonce:
            return ["Authorization": appDelegateSharedInstance.userData.token!]
        
        }
    }
    
    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType {
        return .successCodes
    }
    
    internal func fillFormDataSkippingFile(param: [String: Any]) -> [Moya.MultipartFormData] {
        var aDictData = param
        
        if aDictData["profile_url"] != nil {
            aDictData.removeValue(forKey: "profile_url")
        }
        if aDictData["profile_pic_1"] != nil {
            aDictData.removeValue(forKey: "profile_pic_1")
        }
        if aDictData["profile_pic_2"] != nil {
            aDictData.removeValue(forKey: "profile_pic_2")
        }
        if aDictData["profile_pic_3"] != nil {
            aDictData.removeValue(forKey: "profile_pic_3")
        }
        if aDictData["profile_pic_4"] != nil {
            aDictData.removeValue(forKey: "profile_pic_4")
        }
        if aDictData["profile_pic_5"] != nil {
            aDictData.removeValue(forKey: "profile_pic_5")
        }
        if aDictData["profile_pic_6"] != nil {
            aDictData.removeValue(forKey: "profile_pic_6")
        }
        if aDictData["video_url"] != nil {
            aDictData.removeValue(forKey: "video_url")
        }
        if aDictData["license_photo"] != nil {
            aDictData.removeValue(forKey: "license_photo")
        }
        
        var formData = [Moya.MultipartFormData]()
        
        for strKey in aDictData.keys {
            
            formData.append(MultipartFormData(provider: .data((aDictData[strKey] as! String).data(using: .utf8)!), name: strKey))
        }
        
        return formData
    }
    
}
