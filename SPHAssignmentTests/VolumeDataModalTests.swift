//
//  VolumeDataModalTests.swift
//  SPHAssignmentTests
//
//  Created by Optimum  on 12/8/20.
//  Copyright © 2020 Jai. All rights reserved.
//

import XCTest
@testable import SPHAssignment

class VolumeDataModalTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Desc : it tests the initialization of Volume Data Modal with Expected data
          // Expected : modal should be initialized with the data parsed

    func testinitMethodwithCorrectData()
    {
        let modal = VolumeDataModal(year: "2008", q1Data: "0.432", q2Data: "0.34", q3Data: "0.455", q4Data: "0.45")
        XCTAssertNotNil(modal)
        XCTAssertEqual(modal?.q1Data ,0.432)
        XCTAssertEqual(modal?.q2Data ,0.34)
        XCTAssertEqual(modal?.totalVolume,1.677 )
        
    }
    // Desc : it tests the initialization of Volume Data Modal with unexpected data
             // Expected : modal should be initialized with the data parsed and q1 & q2 should be 0.0 as we passed improper values
    func testinitMethodwithUnexpectedData()
    {
        let modal = VolumeDataModal(year: "2008", q1Data: "", q2Data: "0.0", q3Data: "0.455", q4Data: "0.45")
        XCTAssertNotNil(modal)
        XCTAssertEqual(modal?.q1Data ,0.0)
        XCTAssertEqual(modal?.q2Data ,0.0)
        XCTAssertEqual(modal?.totalVolume,0.905 )
        
    }

}
