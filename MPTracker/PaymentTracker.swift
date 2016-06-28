//
//  PaymentTracker.swift
//  MercadoPagoSDK
//
//  Created by Demian Tejo on 6/13/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

public class PaymentTracker: NSObject {

    static let MP_TRACK_TOKEN_URL = "https://api.mercadopago.com/v1/checkout/tracking"
    static let MP_TRACK_PAYMENTOFF_URL = "https://api.mercadopago.com/v1/checkout/tracking/off"

    
    var baseURL : String!
    init (baseURL : String) {
        super.init()
        self.baseURL = baseURL
    }

    public class func trackToken(token: String!, delegate : MPTrackerDelegate!){
        
        let obj:[String:AnyObject] = ["public_key": delegate.publicKey() , "token":token!,"sdk_flavor":(delegate.flavor()?.rawValue)!,"sdk_platform":"iOS","sdk_type":"native","sdk_version":delegate.sdkVersion()]
            
        self.request(PaymentTracker.MP_TRACK_TOKEN_URL, params: nil, body: JSON(obj).toString(), method: "POST", headers: nil, success: { (jsonResult) -> Void in
            
            }) { (error) -> Void in
                
        }
    }
    
    
    public class func trackPaymentOff(paymentId: String!, delegate : MPTrackerDelegate!){
        
        let obj:[String:AnyObject] = ["public_key":delegate.publicKey() , "token":paymentId!,"sdk_flavor":(delegate.flavor()?.rawValue)!,"sdk_platform":"iOS","sdk_type":"native","sdk_version":delegate.sdkVersion()]
        
        self.request(PaymentTracker.MP_TRACK_PAYMENTOFF_URL, params: nil, body: JSON(obj).toString(), method: "POST", headers: nil, success: { (jsonResult) -> Void in
            
            }) { (error) -> Void in
                
        }
    }
    
    public class func request(url: String, params: String?, body: AnyObject?, method: String, headers : NSDictionary? = nil,  success: (jsonResult: AnyObject?) -> Void,
        failure: ((error: NSError) -> Void)?) {
            
            var requesturl = url
            if params != nil {
                requesturl += "?" + params!
            }
            
            let finalURL: NSURL = NSURL(string: url)!
            let request : NSMutableURLRequest
            
                request = NSMutableURLRequest(URL: finalURL)
    
            
            request.URL = finalURL
            request.HTTPMethod = method
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if headers !=  nil && headers!.count > 0 {
                for header in headers! {
                    request.setValue(header.value as? String, forHTTPHeaderField: header.key as! String)
                }
            }
            
            if body != nil {
                request.HTTPBody = (body as! NSString).dataUsingEncoding(NSUTF8StringEncoding)
            }
        
    
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                if error == nil {
                do
                {
                    let responseJson = try NSJSONSerialization.JSONObjectWithData(data!,
                                                                                  options:NSJSONReadingOptions.AllowFragments)
                    success(jsonResult: responseJson)
                } catch {
                    
                    let e : NSError = NSError(domain: "com.mercadopago.sdk", code: NSURLErrorCannotDecodeContentData, userInfo: nil)
                    failure!(error: e)
                }
            } else {
                let response = String(error)
                print(response)
                
                if failure != nil {
                    failure!(error: error!)
                }
            }
        }
    }
    
}
