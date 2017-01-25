//
//  OneToOneTests.swift
//  Mapper
//
//  Created by Anderthan Hsieh on 10/6/16.
//  Copyright © 2016 anderthan. All rights reserved.
//

import XCTest

class OneToOneTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMappingOperator() {
        let dict : [String : Any] = [
            "identifier": 20,
            "vehicle_name": "Car",
            "vehicle": [
                "name": "TestCar"
            ]
        ]
        
        let json = JSON(obj: dict)
        
        do {
            let user = try TestUser(json: json)
            XCTAssertEqual(dict["identifier"] as! NSNumber, user.id)
            XCTAssertEqual(dict["vehicle_name"] as? String, user.vehicleName)
            XCTAssertEqual(user.vehicle?.name!, "TestCar")
        }
        catch {
            XCTAssert(false, "Unable to create a user from specified json above")
        }
    }
    
}