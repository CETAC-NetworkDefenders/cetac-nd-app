//
//  UserInfoTest.swift
//  cetac-nd-appTests
//
//  Created by user194238 on 10/11/21.
//

import XCTest
@testable import cetac_nd_app

var userInfoController = UserController()

class UserInfoTests : XCTestCase {

    func testUserList() throws {
        userInfoController.fetchListing(staffId: String(1), completition: { (result) in
            DispatchQueue.main.async {
                switch result {
                case.success(let userList):
                    XCTAssertNotNil(userList)
                case.failure(let error):
                    print(error)
                }
            }
        })
    }
    
    func testUserDetail() throws {
        userInfoController.fetchDetail(userId: 1, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case.success(let userDetail):
                    XCTAssertNotNil(userDetail)
                case.failure(let error):
                    print(error)
                }
            }
        })
    }
}
