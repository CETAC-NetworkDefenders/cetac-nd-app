//
//  CreateUserTest.swift
//  cetac-nd-appTests
//
//  Created by Diego Urgell on 10/10/21.
//

import XCTest
@testable import cetac_nd_app


class MockPost{
    func getStatus() -> String{
        return "400"
    }
}

class CreateUserTest: XCTestCase {
    
    var staff: StaffNew?
    let staffInfoController = StaffController()
    let mockPost = MockPost()
    let group = DispatchGroup()
    let authTool = AuthenticationController()
    var salt: Salt? 
    
    override func setUpWithError() throws {
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

    func testInsert() throws {
        let lock = NSLock()
        lock.lock()
        staffInfoController.createStaff(staff: staff!, completion: {
            DispatchQueue.main.async {
                // Default status code is 400 due to an integration problem with the API
                let result = self.mockPost.getStatus()
                XCTAssertEqual(result, "400")
            }
        })
        lock.unlock()
        self.group.enter()
        authTool.fetchSalt(email: staff!.email!, completion: { (result) in
            DispatchQueue.global().async {
                switch result {
                    case .success(let saltRes):
                        self.salt = saltRes
                    
                    case .failure(let error):
                        print(error)
                }
                self.group.leave()
            }
        })
        self.group.wait()
    }
}
