//
//  GATracker.swift
//  MPTracker
//
//  Created by Demian Tejo on 5/9/16.
//  Copyright © 2016 Demian Tejo. All rights reserved.
//

import UIKit

public class GATracker: NSObject {

    static let sharedInstance = GATracker()
       static var gainitialized : Bool = false
  /*
    private override init(gaKey : GAKey!){
        let gai = GAI.sharedInstance()
		gai.trackerWithTrackingId(gaKey.rawValue)
        gai.trackUncaughtExceptions = true  // report uncaught exceptions
        gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
    }
    */
    internal func initialized(flowInfo : FlowTrackInfo!, gaKey : GAKey!){
        
        if (!GATracker.gainitialized){
            let gai = GAI.sharedInstance()
            gai.trackerWithTrackingId(gaKey.rawValue)
            gai.trackUncaughtExceptions = true  // report uncaught exceptions
            GATracker.gainitialized = true
         //   gai.logger.logLevel = GAILogLevel.Verbose  // remove before app release
            let tracker = GAI.sharedInstance().defaultTracker
            tracker.set(GAIFields.customDimensionForIndex(FlowTrackInfo.FLOW_FLAVOR), value: String(flowInfo.flavor.rawValue))
            tracker.set(GAIFields.customDimensionForIndex(FlowTrackInfo.FLOW_FRAMEWORK), value: flowInfo.framework)
            tracker.set(GAIFields.customDimensionForIndex(FlowTrackInfo.FLOW_PUBLIC_KEY), value: flowInfo.publicKey)
            tracker.set(GAIFields.customDimensionForIndex(FlowTrackInfo.FLOW_SDK_VERSION), value: flowInfo.sdkVersion)
        }
        


    }
    
    internal func trackScreen(screenName : String){
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: screenName)
    
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    
    internal func trackPaymentEvent(category: String!, action: String!, label: String!, value: NSNumber = 0, paymentInformer : MPPaymentTrackInformer){
        let tracker = GAI.sharedInstance().defaultTracker
        
        let eventTracker = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value)
        eventTracker.set(paymentInformer.installments(), forKey: GAIFields.customDimensionForIndex(PaymentTrackInfo.PAYMENT_INSTALLMENTS))
        eventTracker.set(paymentInformer.issuerId(), forKey: GAIFields.customDimensionForIndex(PaymentTrackInfo.PAYMENT_ISSUER_ID))
        eventTracker.set(paymentInformer.methodId(), forKey: GAIFields.customDimensionForIndex(PaymentTrackInfo.PAYMENT_METHOD_ID))
        eventTracker.set(paymentInformer.status(), forKey: GAIFields.customDimensionForIndex(PaymentTrackInfo.PAYMENT_STATUS))
        eventTracker.set(paymentInformer.statusDetail(), forKey: GAIFields.customDimensionForIndex(PaymentTrackInfo.PAYMENT_STATUS_DETAIL))
        eventTracker.set(paymentInformer.typeId(), forKey: GAIFields.customDimensionForIndex(PaymentTrackInfo.PAYMENT_TYPE_ID))

         tracker.send(eventTracker.build() as! [NSObject : AnyObject])
    }
    
    internal func trackEvent(category: String!, action: String!, label: String!, value: NSNumber = 0){
        let tracker = GAI.sharedInstance().defaultTracker
        
        let builder = GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value)
        
		tracker.send(builder.build() as [NSObject : AnyObject])
    }
}
