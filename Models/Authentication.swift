//
//  Authentication.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import Foundation

class Salt: Codable {
    var id: Int?
    var salt: String?
}

class CurrentStaff: Codable {
    var accessLevel: String?
    var name: String?
    var userId: String?
    
    enum CodingKeys: String, CodingKey {
        case accessLevel = "access_level"
        case name = "firstname"
    }
}

class AuthenticationController {
    
    var urlComponents: URLComponents
    let group = DispatchGroup()
    var salt: Salt?
    var staff: CurrentStaff?
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/auth"
    }
    
    func fetchSalt(email: String, completion: @escaping (Result<Salt, Error>) -> Void){
        urlComponents.queryItems = [
            URLQueryItem(name: "email", value: email)
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                let salt = try? jsonDecoder.decode(Salt.self, from: data)
                completion(.success(salt!))
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func authenticateStaff(id: Int, hashedPassword: String, completion: @escaping (Result<CurrentStaff, Error>) -> Void){
        urlComponents.queryItems = [
            URLQueryItem(name: "password", value: hashedPassword),
            URLQueryItem(name: "id", value: String(id))
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                let currUser = try? jsonDecoder.decode(CurrentStaff.self, from: data)
                completion(.success(currUser!))
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func authenticate(email: String, password: String) -> CurrentStaff? {
        self.salt = Salt()

        // First obtain the salt, enter the Dispatch Group to wait for the request to finish.
        self.group.enter()
        self.fetchSalt(email: email, completion: { (result) in
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
        
        print(self.salt!.salt)
        
        // If user is not found, credentials are wrong
        if salt!.salt != nil{
            // Otherwise, hash the password using the received salt and send the id and password
            let securedPassword = SecurityUtils.hashPassword(clearTextPassword: password, salt: salt!.salt!)
            
            print(securedPassword)

            // Then make the request to get the user id and the access_level, but once again enter Dispatch Group.
            self.group.enter()
            self.authenticateStaff(id: salt!.id!, hashedPassword: securedPassword, completion: { (result) in
                DispatchQueue.global().async {
                    switch result {
                        case .success(let staffRes):
                            self.staff = staffRes
                        
                        case .failure(let error):
                            print(error)
                    }
                    self.group.leave()
                }
            })
        }
        self.group.wait()
        let id: Int = self.salt!.id!
        self.staff?.userId = String(id)
        return self.staff
    }
}
