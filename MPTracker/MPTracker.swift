//
//  MPTracker.swift
//  MPTracker
//
//  Created by Demian Tejo on 5/9/16.
//  Copyright © 2016 Demian Tejo. All rights reserved.
//


public enum Flavor : Int {
    case Flavor_1 = 1
    case Flavor_2 = 2
    case Flavor_3 = 3
}


public protocol MPTrackerDelegate {
    
    func publicKey() -> String
    func sdkVersion() -> String
    func site() -> String
    func framework() -> String
}

public protocol MPPaymentTrackInformer {

    
    func  methodId() -> String
    func status() -> String
    func statusDetail() -> String
    func typeId() -> String
    func installments() -> String
    func issuerId() -> String
}
public class MPTracker {


    static var initialized : Bool = false

    private class func initialize (mpDelegate : MPTrackerDelegate!, flavor: Flavor!){
        MPTracker.initialized = true
        GATracker.sharedInstance.initialized(flowTrackInfo(mpDelegate, flavor: flavor))
        
    }
    
    public class func trackEvent(mpDelegate: MPTrackerDelegate!, flavor: Flavor!, screen: String! = "NO_SCREEN", action: String!, result: String?){
        if (!initialized){
            self.initialize(mpDelegate, flavor: flavor)
        }
        GATracker.sharedInstance.trackEvent(screen, action:action , label:result)
    }
    
    
    public class func trackPaymentEvent(mpDelegate: MPTrackerDelegate!, paymentInformer: MPPaymentTrackInformer, flavor: Flavor!, screen: String! = "NO_SCREEN", action: String!, result: String?){
        if (!initialized){
            self.initialize(mpDelegate, flavor: flavor)
        }
        GATracker.sharedInstance.trackPaymentEvent(screen, action: action, label: result, paymentInfo: paymentInformer)
    }
    
    
    private class func flowTrackInfo(mpDelegate: MPTrackerDelegate!, flavor: Flavor!) -> FlowTrackInfo {
    
        let flowInfo : FlowTrackInfo = FlowTrackInfo(flavor: flavor, publicKey: mpDelegate.publicKey(), site: mpDelegate.site(), sdkVersion: mpDelegate.sdkVersion(), framework: mpDelegate.framework())
        
        return flowInfo
    }
    

}
