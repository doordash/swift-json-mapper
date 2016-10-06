//
//  OneToOne.swift
//  Mapper
//
//  Created by Anderthan Hsieh on 10/5/16.
//  Copyright © 2016 anderthan. All rights reserved.
//

import Foundation

/**
 Note: (Anderthan) - o2o stands for OneToOne relationship.  Given a JSON object, and a NSObject as a recipient, we want to map a nested JSON to it.  You can pass a set of rules (for example if we need to map nested objects, or map different keypaths to another keypath)
 **/
func o2o<T: NSObject>(lhs: String, rhs: String, cls: T.Type) -> SerializerRule {
    return o2o(lhs: lhs, rhs: rhs, cls: cls, rules: nil)
}

func o2o<T: NSObject>(lhs: String, rhs: String, cls: T.Type, rules: [SerializerRule]?) -> SerializerRule {
    func mappingRule(obj: JSON, recipient: NSObject) {
        if let fromJSON = obj.getKeyPath(lhs, raw: false) as? JSON {
            let generatedClass = T.init()
            if let rules = rules {
                for r in rules {
                    r(fromJSON, generatedClass)
                }
            }
            
            recipient.setValue(generatedClass, forKey: rhs)
        }
        else {
            print("Unable to get \(lhs) from \(obj)")
        }
    }
    
    return mappingRule
}
