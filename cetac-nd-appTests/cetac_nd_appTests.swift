//
//  cetac_nd_appTests.swift
//  cetac-nd-appTests
//
//  Created by Diego Urgell on 09/10/21.
//

import XCTest
@testable import cetac_nd_app

class cetac_nd_appTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testUserList() throws {
        userInfoController.fetchListing(staffId: String(1), completition: { (result) in         DispatchQueue.main.async {
            switch result {
                case.success(let userList):
                    self.userSummaryList = userList
                    XCTAssertNotNil(self.userSummaryList)
                case.failure(let error):
                    print(error)
                }
           }
        })
    }
}
