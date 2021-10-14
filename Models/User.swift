//
//  User.swift
//  cetac-nd-app
//
//  Created by user194238 on 10/7/21.
//

import Foundation

class UserSummary: Codable {
    var id: Int?
    var firstName: String?
    var firstLastName: String?
    var secondLastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "firstname"
        case firstLastName = "first_lastname"
        case secondLastName = "second_lastname"
    }
    
    func getName() -> String {
        return "\(firstLastName!) \(secondLastName!) \(firstName!)"
    }
}

struct UserSection {
    let letter: String
    let userList: [UserSummary]
}

class UserSummaryList: Codable {
    
    var userList: [UserSummary]?
    var userGroup: [UserSection]?
    
    enum CodingKeys: String, CodingKey {
        case userList
    }
    
    func getUserAt(section: Int, index: Int) -> String {
        return userGroup![section].userList[index].getName()
    }

    func buildGroups() -> Void {
        if userList == nil {
            userGroup = nil
            return
        }
        
        let groupedUsers = Dictionary(grouping: userList!, by: {String($0.firstLastName!.prefix(1))})
        let keys = groupedUsers.keys.sorted()
        userGroup = keys.map{UserSection(letter: $0, userList: groupedUsers[$0]!)}
        
    }
}

class UserDetail: Codable {
    var id: Int?
    var firstLastname: String?
    var secondLastname: String?
    var firstname: String?
    var gender: String?
    var maritalStatus: String?
    var phone: String?
    var cellphone: String?
    var birthDate: String?
    var birthPlace: String?
    var occupation: String?
    var religion: String?
    var zipCode: String?
    var street: String?
    var addressNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstLastname = "first_lastname"
        case secondLastname = "second_lastname"
        case firstname
        case gender
        case maritalStatus = "marital_status"
        case phone
        case cellphone
        case birthDate = "birth_date"
        case birthPlace = "birth_place"
        case occupation
        case religion
        case zipCode = "zip_code"
        case street
        case addressNumber = "address_number"
    }
}

class UserNew: Codable {
    var firstLastname: String?
    var secondLastname: String?
    var firstname: String?
    var gender: String?
    var maritalStatus: String?
    var phone: String?
    var cellphone: String?
    var birthDate: String?
    var birthPlace: String?
    var occupation: String?
    var religion: String?
    var zipCode: String?
    var street: String?
    var addressNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case firstLastname = "first_lastname"
        case secondLastname = "second_lastname"
        case firstname
        case gender
        case maritalStatus = "marital_status"
        case phone
        case cellphone
        case birthDate = "birth_date"
        case birthPlace = "birth_place"
        case occupation
        case religion
        case zipCode = "zip_code"
        case street
        case addressNumber = "address_number"
    }
}


class UserController {
    
    var urlComponents: URLComponents
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/user"
    }
    
    func fetchListing(staffId: String, completition: @escaping (Result<UserSummaryList, Error>) -> Void) {
       
        urlComponents.queryItems = [
            URLQueryItem(name: "listing", value: "listing"),
            URLQueryItem(name: "staffId", value: staffId)
        ]
        print(urlComponents)
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
//            let output = String(data: (data)!, encoding: String.Encoding.utf8) as String?
//            print(output)
            if let data = data {
                let output = String(data: (data), encoding: String.Encoding.utf8) as String?
                print(output)
                let userList = try? jsonDecoder.decode(UserSummaryList.self, from: data)
                completition(.success(userList!))
            }
            else if let error = error {
                completition(.failure(error))
            }
        }.resume()
    }
    
    func fetchDetail(userId: Int, completion: @escaping (Result<UserDetail, Error>) -> Void) {
        
        urlComponents.queryItems = [
            URLQueryItem(name: "userId", value: String(userId))
        ]
        print(urlComponents)
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            let output = String(data: (data)!, encoding: String.Encoding.utf8) as String?
            print(output)
            if let data = data {
                do {
                    let userDetailRes = try jsonDecoder.decode(UserDetail.self, from: data)
                    print(userDetailRes.firstname)
                    completion(.success(userDetailRes))
                } catch {
                    print(error)
                }
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func updateUser(user: UserDetail, completion: @escaping () -> Void) {
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(user)
        
        urlComponents.queryItems = nil
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "PATCH"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpStatus = response  as? HTTPURLResponse {
                if httpStatus.statusCode != 200 {
                    print("Expected 200, but returned \(httpStatus.statusCode)")
                    print(response!)
                    completion()
                }
                else {
                    completion()
                }
            }
            else if let error = error {
                print(error)
                completion()
            }
        }.resume()
    }
    
    func createUser(user: UserNew, completion: @escaping () -> Void) {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(user)
        
        urlComponents.queryItems = nil
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpStatus = response as? HTTPURLResponse {
                if httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    completion()
                }
                else {
                    completion()
                }
            }
            else if let error = error {
                print(error)
                completion()
            }
        }.resume()
    }
}
