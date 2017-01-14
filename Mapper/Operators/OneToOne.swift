//
//  OneToOne.swift
//  Mapper
//
//  Created by Anderthan Hsieh on 10/5/16.
//  Copyright © 2016 anderthan. All rights reserved.
//

import Foundation


infix operator |~> : ConversionPrecedence
infix operator |~>? : ConversionPrecedence

/**
 Note: (Anderthan) - o2o stands for OneToOne relationship.  Given a JSON object, and a NSObject as a recipient, we want to map a nested JSON to it.  You can pass a set of rules (for example if we need to map nested objects, or map different keypaths to another keypath)
 **/
func |~><T: Serializable>(lhs: JSON, rhs: String) throws -> T {
    let mapping : SerializerRule<T> = o2o(rules: nil)
    if let result = mapping(lhs, rhs) {
        return result
    }
    else {
        throw MappingError.NilValue
    }
}

func |~>?<T: Serializable>(lhs: JSON, rhs: String) throws -> T? {
    let mapping : SerializerRule<T> = o2o(rules: nil)
    return mapping(lhs, rhs)
}

func o2o<T: Serializable>(rules: [SerializerRule<T>]?) -> SerializerRule<T> {
    func mappingRule(obj: JSON, keyPath: String) -> T? {
        if let fromJSON = obj.getKeyPath(keyPath, raw: false) as? JSON {
            do {
                let generatedClass = try T.init(json: fromJSON)
                return generatedClass
            }
            catch {
                return nil
            }
        }
        else {
            print("Unable to get \(keyPath) from \(obj)")
        }

        return nil
    }
    
    return mappingRule
}



