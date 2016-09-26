//
//  JSONHandler.swift
//  MPTracker
//
//  Created by Demian Tejo on 9/26/16.
//  Copyright © 2016 Demian Tejo. All rights reserved.
//

import UIKit

class JSONHandler: NSObject {

    
    class func jsonCoding(jsonArray: [String:Any]) -> Any {
        var result : Any = ""
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: jsonArray, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            result = decoded
        }catch{
            print("ERROR CONVERTING ARRAY TO JSON, ERROR = \(error)")
        }
        return result

    }
    
    class func parseToJSON(data:Data) -> Any{
        var result : Any = []
        do{
            result = try JSONSerialization.jsonObject(with: data, options: [])
        }catch{
            print("ERROR PARSIBNG JSON, ERROR = \(error)")
        }
        return result
    }
    
}
