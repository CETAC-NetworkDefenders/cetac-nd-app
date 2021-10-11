//
//  PatientsTests.swift
//  cetac-nd-appTests
//
//  Created by Diego Urgell on 11/10/21.
//

import XCTest
@testable import cetac_nd_app


class PatientsTests: XCTestCase {
    
    var userInfoController = UserController()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserList() throws {
        userInfoController.fetchListing(staffId: String(1), completition: { (result) in         DispatchQueue.main.async {
            switch result {
                case.success(let userList):
                    XCTAssertNotNil(userList)
                case.failure(let error):
                    print(error)
                }
           }
        })
    }
    
    // Obtener detalles de un usuario

}
