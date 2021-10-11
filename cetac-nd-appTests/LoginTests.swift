//
//  LoginTests.swift
//  cetac-nd-appTests
//
//  Created by Diego Urgell on 11/10/21.
//

import XCTest
@testable import cetac_nd_app


class LoginTests: XCTestCase {
    
    var authTool = AuthenticationController()

    func testWrongUser() throws {
        let lock = NSLock()
        lock.lock()
        authTool.authenticateStaff(id: 23, hashedPassword: "Password", completion: { (result) in
            DispatchQueue.main.async{
                switch result {
                    case .success(let accessLevel):
                        XCTAssertNil(accessLevel)
                    
                    case .failure(let error):
                        print(error)
                }
            }
        })
        lock.unlock()
    }

    func testWrongPassword() throws {
        let lock = NSLock()
        lock.lock()
        let staff = authTool.authenticate(email: "diego@gmail.com", password: "BadPassword")
        lock.unlock()
        XCTAssertNil(staff?.name)
    }
    
    func testGoodLogin() throws {
        let lock = NSLock()
        lock.lock()
        let staff = authTool.authenticate(email: "diego@gmail.com", password: "HolaMundo01%")
        lock.unlock()
        XCTAssertEqual(staff?.name, "Diego Enrique")
    }

}
