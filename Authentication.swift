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
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/auth"
    }
    
    func fetchSalt(email: String, completion: @escaping (Result<Salt, Error>) -> Void){
        urlComponents.queryItems = [
            URLQueryItem(name: "username", value: email)
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
}
