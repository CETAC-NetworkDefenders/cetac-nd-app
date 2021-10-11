//
//  GetUserTest.swift
//  cetac-nd-appTests
//
//  Created by Diego Urgell on 10/10/21.
//

import XCTest
@testable import cetac_nd_app

class GetUserTest: XCTestCase {
    
    var userList: StaffSummaryList?
    var staff: StaffNew?
    let staffInfoController = StaffController()
    var salt: Salt?
    let group = DispatchGroup()
    let authTool = AuthenticationController()
    var retrieveUser = StaffDetail()

    override func setUpWithError() throws {
        self.staff = StaffNew()
        self.staff!.firstLastname = "Zepeda"
        self.staff!.secondLastname = "Ceballos"
        self.staff!.firstname = "Iñigo Enrique"
        self.staff!.accessLevel = "admin_support"
        self.staff!.cellphone = "5509876543"
        self.staff!.zipCode = "12345"
        self.staff!.street = "Calle Iñigo"
        self.staff!.neighborhood =  "Colonia Iñigo"
        self.staff!.addressNumber = "88"
        self.staff!.email = "inigo@gmail.com"
        self.staff!.password = "HolaMundo01%"
    }

    func testGetSalt() throws {
        let lock = NSLock()
        lock.lock()
        self.group.enter()
        staffInfoController.createStaff(staff: staff!, completion: {self.group.leave()})
        self.group.wait()
        // If it is possible to obain the salt of the registered user, then he was correctly added to the DB.
        self.group.enter()
        authTool.fetchSalt(email: "inigo@gmail.com", completion: { (result) in
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
        
        XCTAssertNotNil(self.salt)
        lock.unlock()
    }

    func testUserDetail() throws {
        let staffId = 267
        self.group.enter()
        staffInfoController.fetchDetail(staffId: staffId, completion: { (result) in
            DispatchQueue.global().async {
                switch result {
                case .success(let staffDetail):
                    XCTAssertEqual(staffDetail.firstname, "Diego Alejandro")
                case .failure(let error):
                    print(error)
                }
            }
            self.group.leave()
        })
        
        self.group.wait()
    }
    
    func testUserSummary() throws {
        self.group.enter()
        staffInfoController.fetchListing(accessLevel: "admin", completion: { (result) in
            DispatchQueue.global().async {
                switch result {
                case .success(let staffList):
                    XCTAssertNotNil(staffList)
                case .failure(let error):
                    print(error)
                }
            }
            self.group.leave()
        })
        self.group.wait()
    }
}
