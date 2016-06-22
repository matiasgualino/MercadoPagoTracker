//
//  MPTracker.swift
//  MPTracker
//
//  Created by Demian Tejo on 5/9/16.
//  Copyright © 2016 Demian Tejo. All rights reserved.
//


public enum Flavor : String {
    case Flavor_1 = "1"
    case Flavor_2 = "2"
    case Flavor_3 = "3"
}

public enum GAKey : String {
    case MLA = "UA-46085787-6"
    case MLB = "UA-46090222-6"
    case MLM = "UA-46090517-10"
    case MLC = "UA-46085697-7"
    case MCO = "UA-46087162-10"
    case MLV = "UA-46090035-10"
}


public protocol MPTrackerDelegate {
    
    func flavor() -> Flavor!
    func framework() -> String!
    func sdkVersion() -> String!
    func publicKey() -> String!
    func siteId() -> String!

}

public protocol MPPaymentTrackInformer {

    
    func methodId() -> String!
    func status() -> String!
    func statusDetail() -> String!
    func typeId() -> String!
    func installments() -> String!
    func issuerId() -> String!
    
    
}
public class MPTracker {


    static var initialized : Bool = false

    static var siteGAKey : GAKey?
    
    static var flavor : Flavor? = nil
    
    private class func initialize (mpDelegate : MPTrackerDelegate!){
        MPTracker.initialized = true
        siteGAKey = GAKey(rawValue: mpDelegate.siteId())
        GATracker.sharedInstance.initialized(flowTrackInfo(mpDelegate), gaKey: siteGAKey)
        MPTracker.flavor = mpDelegate.flavor()
    }
    
    public class func trackEvent(mpDelegate: MPTrackerDelegate!, screen: String! = "NO_SCREEN", action: String!, result: String?){
        if (!initialized){
            self.initialize(mpDelegate)
        }
        GATracker.sharedInstance.trackEvent(flavorText() + "/" + screen, action:action , label:result)
    }
    
    
    public class func trackPaymentEvent(token: String!, mpDelegate: MPTrackerDelegate!, paymentInformer: MPPaymentTrackInformer, flavor: Flavor!, screen: String! = "NO_SCREEN", action: String!, result: String?){
        if (!initialized){
            self.initialize(mpDelegate)
        }
        GATracker.sharedInstance.trackPaymentEvent(flavorText() + "/" + screen, action: action, label: result, paymentInformer: paymentInformer)
        PaymentTracker.trackToken(token, delegate: mpDelegate)
    }
    
    public class func trackPaymentOffEvent(paymentId: String!, mpDelegate: MPTrackerDelegate!, paymentInformer: MPPaymentTrackInformer, flavor: Flavor!, screen: String! = "NO_SCREEN", action: String!, result: String?){
        if (!initialized){
            self.initialize(mpDelegate)
        }
        MPTracker.trackEvent(mpDelegate, action: "", result: "")
        PaymentTracker.trackPaymentOff(paymentId, delegate: mpDelegate)
    }
    
    
    private class func flowTrackInfo(mpDelegate: MPTrackerDelegate!) -> FlowTrackInfo {
    
        let flowInfo : FlowTrackInfo = FlowTrackInfo(flavor: mpDelegate.flavor(), framework: mpDelegate.framework(), sdkVersion: mpDelegate.sdkVersion(), publicKey: mpDelegate.publicKey())
        
        return flowInfo
    }
    
    public class func trackScreenName(mpDelegate : MPTrackerDelegate!, screenName: String!){
        if (!initialized){
            self.initialize(mpDelegate)
        }
        GATracker.sharedInstance.trackScreen(flavorText() + "/" + screenName)
    }
    
    private class func flavorText() -> String{
        
        if (MPTracker.flavor != nil){
            return "F" + (MPTracker.flavor?.rawValue)!
        }else{
            return ""
        }
        
    }

}
