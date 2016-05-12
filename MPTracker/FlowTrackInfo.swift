//
//  FlowTrackInfo.swift
//  MPTracker
//
//  Created by Demian Tejo on 5/10/16.
//  Copyright © 2016 Demian Tejo. All rights reserved.
//


public class FlowTrackInfo: NSObject {
    
    
    static let FLOW_FLAVOR : UInt = 0
    static let FLOW_PUBLIC_KEY : UInt = 0
    static let FLOW_SITE : UInt = 0
    static let FLOW_SDK_VERSION : UInt = 0
    static let FLOW_FRAMEWORK : UInt = 0
    
    var flavor : Flavor!
    var publicKey : String!
    var site : String!
    var sdkVersion : String!
    var framework : String!
    
    
    init(flavor : Flavor!, publicKey : String!, site : String!, sdkVersion : String!, framework : String!){
        self.flavor = flavor
        self.publicKey = publicKey
        self.site = site
        self.sdkVersion = sdkVersion
        self.framework = framework
    }
}
