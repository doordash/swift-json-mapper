//
//  SerializerRule.swift
//  Mapper
//
//  Created by Anderthan Hsieh on 10/2/16.
//  Copyright © 2016 anderthan. All rights reserved.
//

import Foundation

// A rule would be.. given a key and a JSON obj, return a value for that key
public typealias SerializerRule = (_ obj: JSON, _ key: String) -> Any?

public struct SerializerRuleIterator : IteratorProtocol {
    
    var currentIndexToPop = 0
    
    let rules : [SerializerRule]
    
    public mutating func next() -> SerializerRule? {
        // If we have an empty rules list, then we will return nil
        if rules.count == 0 { return nil }
        
        // If we have gone to the end of our list, we will return nil
        if currentIndexToPop > rules.count - 1 { return nil }
        
        // Should be a successful return, increment our currentIndex counter
        currentIndexToPop += 1
        return rules[currentIndexToPop]
    }
    
    init(_ rules: [SerializerRule]) {
        self.rules = rules
    }
}

public struct SerializerGenerator : Sequence {
    let rules: [SerializerRule]

    init(rules: [SerializerRule]) {
        self.rules = rules
    }
    
    public func makeIterator() -> SerializerRuleIterator {
        return SerializerRuleIterator(rules)
    }
}
