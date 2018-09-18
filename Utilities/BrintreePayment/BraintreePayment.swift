//
//  BraintreePayment.swift
//  LoveInternational
//
//  Created by indianic on 24/08/18.
//  Copyright © 2018 indianic. All rights reserved.
//

import UIKit
import BraintreeDropIn
import Braintree


class BraintreePaymentHelper: NSObject {

    func callBraintreeToForPayment(_ viewController : UIViewController, brintreeToken : String, paymentPriceAmount : String, success successCallback: @escaping (Bool,String) -> Void, error errorCallback: @escaping (Bool,String) -> Void) {
        
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: brintreeToken, request: request)
        { [unowned viewController] (controller, result, error) in
            
            if let error = error {
                errorCallback(false,error.localizedDescription)
            } else if (result?.isCancelled == true) {
                errorCallback(false,"cancelled")
            } else if let nonce = result?.paymentMethod?.nonce {
                successCallback(true,nonce)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        viewController.present(dropIn!, animated: true, completion: nil)
    }
    
}
