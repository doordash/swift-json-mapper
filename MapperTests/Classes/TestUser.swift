//
//  TestUser.swift
//  Mapper
//
//  Created by Anderthan Hsieh on 10/5/16.
//  Copyright © 2016 anderthan. All rights reserved.
//

import Foundation

class TestUser : NSObject {
    
    var id: NSNumber?
    var vehicleName : String?
    var vehicle : TestVehicle?
        
    override init() {
        super.init()
    }
    
}

class TestVehicle : NSObject {
    var name: String?
}
