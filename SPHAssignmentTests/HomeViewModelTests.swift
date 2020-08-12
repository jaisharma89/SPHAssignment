//
//  SPHAssignmentTests.swift
//  SPHAssignmentTests
//
//  Created by Optimum  on 11/8/20.
//  Copyright © 2020 Jai. All rights reserved.
//

import XCTest
import CoreData
@testable import SPHAssignment

class HomeViewModelTests: XCTestCase {
       var viewModal : HomeViewModel!
       
       var session : MockURLSession!

    override func setUpWithError() throws {
        viewModal = HomeViewModel()
               session = MockURLSession()
               viewModal.webHandlerInstance = MockWebHandler()
               viewModal.webHandlerInstance.session = session
    }

    override func tearDownWithError() throws {
       viewModal = nil
        session = nil
    }
    // Desc : it tests the parsing and storing the values functionality in modal with expected response
    // Expected : Records arr should should have 2 objects as we passed in the mocked json response
    func testGetRecordswithExpectedResponse()
    {
        session.data = mockExpectedData
        session.response = HTTPURLResponse(url: URL(string: Constants.networkHostURL)!, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
        viewModal.webHandlerInstance.session = session
        
        viewModal.getRecords() { (success, webError) in
            XCTAssertEqual(success, true)
            XCTAssertNil(webError)
            XCTAssertEqual(self.viewModal.records.count, 2)
        }
        
        
    }
    // Desc : it tests the parsing and storing the values functionality in modal with unexpected response
    // Expected : Records arr should should have 0 objects and block show should return false
    func testGetRecordswithUnExpectedResponse()
    {
        session.data = mockUnExpectedData
        session.response = HTTPURLResponse(url: URL(string: Constants.networkHostURL)!, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
        viewModal.webHandlerInstance.session = session
        
        viewModal.getRecords() { (success, webError) in
            XCTAssertEqual(success, false)
            XCTAssertNotNil(webError)
            XCTAssertEqual(self.viewModal.records.count, 0)
        }
        
        
    }
    // Desc : it tests the parsing and storing the values functionality in modal with unexpected response
    // Expected : Records arr should should have 11 objects and block show should return success
   func testGetRecordswithIdealResponse()
    {
        session.data = modalIdeal
        session.response = HTTPURLResponse(url: URL(string: Constants.networkHostURL)!, statusCode: 200,
                                           httpVersion: nil, headerFields: nil)!
        viewModal.webHandlerInstance.session = session
        
        viewModal.getRecords() { (success, webError) in
            XCTAssertEqual(success, true)
            XCTAssertNil(webError)
            XCTAssertEqual(self.viewModal.records.count, 11)
        }
        
    }
    // Desc : it tests the parsing and storing the collecting yearly data
    // Expected : Records arr should should have  object with year 2008 as passed in mock data and properties value should match with json
    func testgetVolumeDataYearlyExpectedData()
    {
        if  let response = try? JSONSerialization.jsonObject(with: modalIdeal, options: []) as? [String :AnyObject]
        {
            if  let data = response["result"] as? [String:AnyObject]
            {
                let recordsArr = data["records"] as! [AnyObject]
                let record = recordsArr[0]
                
                let modal = viewModal.getVolumeDataYearly(recordsArr: recordsArr, record: record as AnyObject)!
                XCTAssertEqual(modal.year, "2008")
                XCTAssertEqual(modal.q1Data, 0.171586)
                XCTAssertEqual(modal.q2Data, 0.248899)
            }
            
        }
        
    }
    // Desc : it tests the parsing and storing the collecting yearly data with unexpected data
       // Expected : Records arr should should have  object with year 2008 as passed in mock data and properties value should match with json
    func testgetVolumeDataYearlyUnexpected()
        {
            if  let response = try? JSONSerialization.jsonObject(with: mockExpectedData, options: []) as? [String :AnyObject]
            {
                if  let data = response["result"] as? [String:AnyObject]
              {
                let recordsArr = data["records"] as! [AnyObject]
                let record = recordsArr[0]
                    
                let modal = viewModal.getVolumeDataYearly(recordsArr: recordsArr, record: record as AnyObject)!
                XCTAssertEqual(modal.year, "2008")
                XCTAssertEqual(modal.q1Data, 0.0)
                XCTAssertEqual(modal.q2Data, 0.248899)

                }
                
            }
            
        }


}
// Mocked data
var mockExpectedData = Data("""
{
  "result": {
    "records": [
      {
        "volume_of_mobile_data": "",
        "quarter": "2008-Q1",
        "_id": 15
      },
      {
        "volume_of_mobile_data": "0.248899",
        "quarter": "2008-Q2",
        "_id": 16
      },
      {
        "volume_of_mobile_data": "0.439655",
        "quarter": "2008-Q3",
        "_id": 17
      },
      {
        "volume_of_mobile_data": "0.683579",
        "quarter": "2008-Q4",
        "_id": 18
      },
      {
        "volume_of_mobile_data": "1.066517",
        "quarter": "2009-Q1",
        "_id": 19
      },
      {
        "volume_of_mobile_data": "1.357248",
        "quarter": "2009-Q2",
        "_id": 20
      },
      {
        "volume_of_mobile_data": "1.695704",
        "quarter": "2009-Q3",
        "_id": 21
      },
      {
        "volume_of_mobile_data": "2.109516",
        "quarter": "2009-Q4",
        "_id": 22
      }
    ],
  }
}
""".utf8)
var mockUnExpectedData = Data("""
[
]
""".utf8)
private let modalIdeal = Data("""
      {
        "result": {
          "records": [
            {
              "volume_of_mobile_data": "0.171586",
              "quarter": "2008-Q1",
              "_id": 15
            },
            {
              "volume_of_mobile_data": "0.248899",
              "quarter": "2008-Q2",
              "_id": 16
            },
            {
              "volume_of_mobile_data": "0.439655",
              "quarter": "2008-Q3",
              "_id": 17
            },
            {
              "volume_of_mobile_data": "0.683579",
              "quarter": "2008-Q4",
              "_id": 18
            },
            {
              "volume_of_mobile_data": "1.066517",
              "quarter": "2009-Q1",
              "_id": 19
            },
            {
              "volume_of_mobile_data": "1.357248",
              "quarter": "2009-Q2",
              "_id": 20
            },
            {
              "volume_of_mobile_data": "1.695704",
              "quarter": "2009-Q3",
              "_id": 21
            },
            {
              "volume_of_mobile_data": "2.109516",
              "quarter": "2009-Q4",
              "_id": 22
            },
            {
              "volume_of_mobile_data": "2.3363",
              "quarter": "2010-Q1",
              "_id": 23
            },
            {
              "volume_of_mobile_data": "2.777817",
              "quarter": "2010-Q2",
              "_id": 24
            },
            {
              "volume_of_mobile_data": "3.002091",
              "quarter": "2010-Q3",
              "_id": 25
            },
            {
              "volume_of_mobile_data": "3.336984",
              "quarter": "2010-Q4",
              "_id": 26
            },
            {
              "volume_of_mobile_data": "3.466228",
              "quarter": "2011-Q1",
              "_id": 27
            },
            {
              "volume_of_mobile_data": "3.380723",
              "quarter": "2011-Q2",
              "_id": 28
            },
            {
              "volume_of_mobile_data": "3.713792",
              "quarter": "2011-Q3",
              "_id": 29
            },
            {
              "volume_of_mobile_data": "4.07796",
              "quarter": "2011-Q4",
              "_id": 30
            },
            {
              "volume_of_mobile_data": "4.679465",
              "quarter": "2012-Q1",
              "_id": 31
            },
            {
              "volume_of_mobile_data": "5.331562",
              "quarter": "2012-Q2",
              "_id": 32
            },
            {
              "volume_of_mobile_data": "5.614201",
              "quarter": "2012-Q3",
              "_id": 33
            },
            {
              "volume_of_mobile_data": "5.903005",
              "quarter": "2012-Q4",
              "_id": 34
            },
            {
              "volume_of_mobile_data": "5.807872",
              "quarter": "2013-Q1",
              "_id": 35
            },
            {
              "volume_of_mobile_data": "7.053642",
              "quarter": "2013-Q2",
              "_id": 36
            },
            {
              "volume_of_mobile_data": "7.970536",
              "quarter": "2013-Q3",
              "_id": 37
            },
            {
              "volume_of_mobile_data": "7.664802",
              "quarter": "2013-Q4",
              "_id": 38
            },
            {
              "volume_of_mobile_data": "7.73018",
              "quarter": "2014-Q1",
              "_id": 39
            },
            {
              "volume_of_mobile_data": "7.907798",
              "quarter": "2014-Q2",
              "_id": 40
            },
            {
              "volume_of_mobile_data": "8.629095",
              "quarter": "2014-Q3",
              "_id": 41
            },
            {
              "volume_of_mobile_data": "9.327967",
              "quarter": "2014-Q4",
              "_id": 42
            },
            {
              "volume_of_mobile_data": "9.687363",
              "quarter": "2015-Q1",
              "_id": 43
            },
            {
              "volume_of_mobile_data": "9.98677",
              "quarter": "2015-Q2",
              "_id": 44
            },
            {
              "volume_of_mobile_data": "10.902194",
              "quarter": "2015-Q3",
              "_id": 45
            },
            {
              "volume_of_mobile_data": "10.677166",
              "quarter": "2015-Q4",
              "_id": 46
            },
            {
              "volume_of_mobile_data": "10.96733",
              "quarter": "2016-Q1",
              "_id": 47
            },
            {
              "volume_of_mobile_data": "11.38734",
              "quarter": "2016-Q2",
              "_id": 48
            },
            {
              "volume_of_mobile_data": "12.14232",
              "quarter": "2016-Q3",
              "_id": 49
            },
            {
              "volume_of_mobile_data": "12.86429",
              "quarter": "2016-Q4",
              "_id": 50
            },
            {
              "volume_of_mobile_data": "13.29757",
              "quarter": "2017-Q1",
              "_id": 51
            },
            {
              "volume_of_mobile_data": "14.54179",
              "quarter": "2017-Q2",
              "_id": 52
            },
            {
              "volume_of_mobile_data": "14.88463",
              "quarter": "2017-Q3",
              "_id": 53
            },
            {
              "volume_of_mobile_data": "15.77653",
              "quarter": "2017-Q4",
              "_id": 54
            },
            {
              "volume_of_mobile_data": "16.47121",
              "quarter": "2018-Q1",
              "_id": 55
            },
            {
              "volume_of_mobile_data": "18.47368",
              "quarter": "2018-Q2",
              "_id": 56
            },
            {
              "volume_of_mobile_data": "19.97554729",
              "quarter": "2018-Q3",
              "_id": 57
            },
            {
              "volume_of_mobile_data": "20.43921113",
              "quarter": "2018-Q4",
              "_id": 58
            }
          ],
        }
      }
      """.utf8)
// MARK: Mocking URLSession and URLSessionDataTask
class MockURLSession: URLSession {
    var cachedUrl: URL?
    var data : Data?
    var response : HTTPURLResponse!
    var error :WebError?
    override init ()
    {
        
    }
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return MockURLSessionDataTask {
            completionHandler(self.data,self.response ,self.error)
        }
            
    }
    
}
class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
class MockWebHandler : WebAPIHandler
{
  override func getNetworkStatus () -> Bool
    {
        return true
    }
}

