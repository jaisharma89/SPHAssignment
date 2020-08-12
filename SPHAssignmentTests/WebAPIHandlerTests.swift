//
//  WebAPIHandlerTests.swift
//  CAssignmentTests
//
//  Copyright © 2020 Jai. All rights reserved.
//

import XCTest
@testable import SPHAssignment

class WebAPIHandlerTests: XCTestCase {
     var viewModal : HomeViewModel!
    let webHandler  = WebAPIHandler.getInstance()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData;
        webHandler.session = URLSession(configuration: configuration, delegate: webHandler , delegateQueue:OperationQueue.main)
    }
    
    override func tearDown() {
        
    }
    // Desc : it tests the Service methods with expected value
    // Expected : the Rcords Array should have 15 objects as we have static json response
    func testMakeRequestWithServerWithCorrectURL()
    {
        viewModal = HomeViewModel()
        let strHostAddress = Constants.networkHostURL
        let requestUrl = URL(string: strHostAddress)
        var records = [VolumeDataModal]()
        
        let expectation = self.expectation(description: "ResultAPI")
        
        webHandler.makeRequestWithServer(requestUrl!, session: webHandler.session) { (result) in
            
            switch result
            {
                
            case.Success(let data) :
                
                do {
                   if  let response = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String :AnyObject]
                    {
                        if let volumeData = response["result"] as? [String :AnyObject]
                        {
                           let recordsArr = volumeData["records"] as! [AnyObject]
                            for record in recordsArr
                            {
                                let time = record["quarter"] as! String
                                
                                let year = time.components(separatedBy: "-")[0]
                                
                                if records.filter({$0.year == year}).count <= 0
                                {
                                if let yearDataModal = self.viewModal.getVolumeDataYearly(recordsArr: recordsArr ,record: record )
                                {
                                    records.append(yearDataModal)
                                }
                                }
                            }
                            
                        }

                    }
                }
                catch _
                {
                    
                }
                expectation.fulfill()
                break
            case .Failure(let error) :
                if self.webHandler.networkStatus == .notReachable
                {
                    switch error {
                    case .noInternetConnection:
                        XCTAssert(true)
                        break
                    default:
                        XCTAssert(false)
                    }
                    expectation.fulfill()
                }
                break
            case .none:
                print("")
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            
            if self.webHandler.networkStatus == .notReachable
            {
                XCTAssert(true)
            }
            else
            {
                XCTAssertEqual(records.count, 11)
                XCTAssertNil(error)
            }
        }
        
        
    }
    // Desc : it tests the Service methods with wrong value
    // Expected : the Rcords Array should have 0 objects as there will be no response from url
    func testMakeRequestWithServerWithWrongURL()
    {
        
        let strHostAddress = "https://gist.githubusercontent.com/yuhong90/room-availability.json"
        let requestUrl = URL(string: strHostAddress)
        let records = [VolumeDataModal]()
        var webAPIError : WebError?
        let expectation = self.expectation(description: "ResultAPI")
        
        webHandler.makeRequestWithServer(requestUrl!, session: webHandler.session) { (result) in
            
            switch result
            {
                
            case.Success(let data) :
                
                do {
                   if  let response = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String :AnyObject]
                    {
                        if let volumeData = response["result"] as? [String :AnyObject]
                        {
                           let recordsArr = volumeData["records"] as! [AnyObject]
                            for _ in recordsArr
                            {
                                
                            }
                            
                        }

                    }
                }
                catch _
                {
                    
                }
                expectation.fulfill()
                break
            case .Failure( let error) :
                
                webAPIError = error
                expectation.fulfill()
                break
            case .none:
                print("")
            }
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(records.count, 0)
            
            if self.webHandler.networkStatus == .notReachable
            {
                switch webAPIError {
                case .noInternetConnection:
                    XCTAssert(true)
                    break
                default:
                    XCTAssert(false)
                }
                
                XCTAssertNotNil(webAPIError)
            }
            
            
        }
        
    }
}
