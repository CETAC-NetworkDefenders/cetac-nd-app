//
//  CreateUserTests.swift
//  cetac-nd-appTests
//
//  Created by Diego Urgell on 10/10/21.
//

import XCTest
@testable import cetac_nd_app

var globalSelectedTab: Int? = 0
var services: [ServiceGroup]?
var currentSession: CurrentStaff?
let baseURL = "v1z089eb11.execute-api.us-west-2.amazonaws.com"

class ValidateNewUserTests: XCTestCase {
    
    var staff: StaffNew?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.staff = StaffNew()

        self.staff!.firstLastname = "Jiménez"
        self.staff!.secondLastname = "Urgell"
        self.staff!.firstname = "Saray"
        self.staff!.accessLevel = "thanatologist"
        self.staff!.cellphone = "5512345678"
        self.staff!.zipCode = "12345"
        self.staff!.street = "Calle Saray"
        self.staff!.neighborhood =  "Colonia Saray"
        self.staff!.addressNumber = "25"
        self.staff!.email = "saray@gmail.com"
        self.staff!.password = "HolaMundo01%"
    }
    
    func testValidUser() throws {
        let valid = staff!.isValid()
        XCTAssertNil(valid)
    }

    func testEmailNoDomain() throws {
        self.staff!.email = "bad@.com"
        let valid = staff!.isValid()
        XCTAssertNotNil(valid)
        self.staff!.email = "good@email.com"
    }

    func testWeakPassword() throws {
        self.staff!.password = "Hola"
        let valid = staff!.isValid()
        XCTAssertNotNil(valid)
        self.staff!.password = "HolaMundo01%"
    }
    
    func testBadCellphone() throws {
        self.staff!.cellphone = "123A"
        let valid = staff!.isValid()
        XCTAssertNotNil(valid)
        self.staff!.cellphone = "5512345678"
    }
    
    func testBadZipCode() throws {
        self.staff!.zipCode = "123A"
        let valid = staff!.isValid()
        XCTAssertNotNil(valid)
        self.staff!.zipCode = "12345"
    }
    
    func testBadAddressNum() throws {
        self.staff!.zipCode = "Numero"
        let valid = staff!.isValid()
        XCTAssertNotNil(valid)
        self.staff!.zipCode = "25"
    }

}
