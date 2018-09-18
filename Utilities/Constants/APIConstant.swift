//
//  APIConstant.swift
//  StructureApp
// 
//  Created By: IndiaNIC Infotech Ltd
//  Created on: 13/11/17 10:25 AM - (indianic)
//  
//  Copyright © 2017 IndiaNIC Infotech Ltd. All rights reserved.
//  
//  


//
//   Define all your API related constant in this file.
//   Do not add any other constant if it is not related to the API.
//
//   All the data are structured in the form so that it can be easily understandable by any person.
//


import Foundation


/// This is the Structure for API
internal struct SERVER {
    
    // MARK: - API URL
    
    /// Structure for URL. This will have the API end point for the server.
    struct URL {
        
        /// Live Server Base URL
        /// ````
        /// API.URL.live
        /// ````
        static let live                                  = "https://www.google.co.in/"
        
        /// Development Server Base URL
        /// ````
        /// API.URL.development
        /// ````
        static let development                           = "http://10.2.1.11:5079/api/"
        
        static let developmentStaging                          = "http://node.indianic.com:4080/api/"
        
    }
    
    
    // MARK: - Basic Response keys
    
    /// Structure for API Response Keys. This will use to get the data or anything based on the key from the repsonse. Do not directly use the key rather define here and use it.
    struct Response {
        
        /// API success/failure key from the response
        /// ````
        /// API.Response.success
        /// ````
        static let settings                                  = "settings"
        
        
        static let success                                  = "status"
        
        /// Default message key from the response
        /// ````
        /// API.Response.message
        /// ````
        static let message                                  = "message"
        
        /// Default Status code key from the response
        /// ````
        /// API.Response.statusCode
        /// ````
        static let statusCode                               = "statusCode"
        
        /// Default key for Data from the response
        /// ````
        /// API.Response.data
        /// ````
        static let data                                     = "data"
        
    }
    
    
    // MARK: - Success Failure keys
    
    /// Structure for API Response Success or Failure. This will use to check that if API has responded success or failure
    struct Check {
        
        /// Default success response
        /// ````
        /// API.Check.success
        /// ````
        static let success                                   = "1"
        
        /// Default failure response
        /// ````
        /// API.Check.failure
        /// ````
        static let failure                                   = "0"
        
    }
    
    
    // MARK: - Request end points
    
    /// Structure for API Request/Method. Define any of your API endpoint/method here.
    struct Request {
        
        static let userRegister                                    = "userRegister"
        static let signUp                                          = "signup"
        
    }
    
    struct RequestParam {
        
        struct SignupRequest {
            
            static let email                                        = "email"
            static let password                                     = "password"
            static let device_id                                    = "device_id"
            static let device_type                                  = "device_type"
            static let full_name                                    = "full_name"
            static let fbId                                         = "fbId"
            static let user_type                                    = "user_type"
        }
        
        struct SignINRequest {
            
            static let email                                        = "email"
            static let password                                     = "password"
            static let device_id                                    = "device_id"
            static let device_type                                  = "device_type"
        }
        
        struct ChangePassword {
            
            static let oldPassword                                  = "oldPassword"
            static let newPassword                                  = "newPassword"
            static let userId                                       = "user_id"
        }
        
        struct Settings {
            
            static let newMatch                                    = "new_match"
            static let newMessage                                  = "new_message"
            static let newClients                                  = "new_clients"
        }
        
        struct BraintreePaymentPram {
            
            static let nonce                                    = "nonce"
            static let amount                                  = "amount"

        }
        
        struct CompleateProfile {
            
            static let fullName                                     = "full_name"
            static let username                                     = "username"
            static let about_me                                     = "about_me"
            static let birthday                                     = "birthday"
            static let live_in                                      = "live_in"
            static let citizen_of                                   = "citizen_of"
            static let education                                    = "education"
            static let gender                                       = "gender"
            static let interested_in                                = "interested_in"
            static let have_child                                   = "have_child"
            static let want_child                                   = "want_child"
            static let i_smoke                                      = "i_smoke"
            static let i_drink                                      = "i_drink"
            static let country_id                                   = "country_id"
            static let state_id                                     = "state_id"
            static let is_profile_complete                          = "is_profile_complete"
            static let profile_url                                  = "profile_url"
            
            static let nameOfFirm                                  = "name_of_firm"
            static let licenseNo                                   = "license_no"
            static let paypalEmailAddress                          = "paypal_email_address"
            static let licensePhoto                                = "license_photo"
        }
        
        
        struct AddUpdateImages {
            
            static let profile_pic_1                                = "profile_pic_1"
            static let profile_pic_2                                = "profile_pic_2"
            static let profile_pic_3                                = "profile_pic_3"
            static let profile_pic_4                                = "profile_pic_4"
            static let profile_pic_5                                = "profile_pic_5"
            static let profile_pic_6                                = "profile_pic_6"
            
        }
        
        struct UploadProfileVideo {
            
            static let video_url                                = "video_url"
        }
        
        struct Discover {
            
            static let citizenOf                                    = "citizen_of"
            static let education                                    = "education"
            static let ageRange                                     = "age_range"
            static let wantChild                                    = "want_child"
            static let iSmoke                                       = "i_smoke"
            static let iDrink                                       = "i_drink"
            static let userType                                     = "user_type"
            static let countryId                                    = "country_id"
            static let stateId                                      = "state_id"
            static let experience                                   = "experience"
            static let page                                         = "page"
            static let limit                                        = "limit"

        }
        
        struct AttorneyList {
            
            static let userID                                       = "id"
            static let page                                         = "page"
            static let limit                                        = "limit"
            static let countryId                                    = "country_id"
            static let stateId                                      = "state_id"
            static let experience                                   = "experience"

            
        }
        
        struct DiscoverDetail {
            
            static let crushId                                    = "crush_id"
        }
        
        struct ReportAbuse {
            
            static let abuserId                                    = "abuser_id"
            static let report                                      = "report"
        }
        
        struct FriendRequest {
            
            static let ids                                         = "ids"
            static let reqStatus                                   = "req_status"
        }
        
        struct GetProfileRequest {
            
            static let userID                                         = "id"

        }
        struct AddQBDialogId {
            
            static let intId                    = "int_id"
            static let attorneyId               = "attorney_id"
            static let grpDialgId               = "grp_dialg_id"
            static let dialgId                  = "dialg_id"
        }
        
        struct RateToAttorney {
            
            static let attorneyId               = "attorney_id"
            static let star               = "star"
            static let review                  = "review"
        }

    }
    
}
