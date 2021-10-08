//
//  Session.swift
//  cetac-nd-app
//
//  Created by user197499 on 10/7/21.
//

import Foundation

class SessionSummary: Codable {
    var record_id: Int?
    var session_date: Date?
    var firstName: String?
    var firstLastName: String?
    var secondLastName: String?
    
    enum CodingKeys: String, CodingKey {
        case record_id
        case session_date = "session_date"
        case firstName = "firstname"
        case firstLastName = "first_lastname"
        case secondLastName = "second_lastname"
    }
}

class SessionSummaryList: Codable {
    
    var sessionList: [SessionSummary]?
    
    enum CodingKeys: String, CodingKey {
        case sessionList
    }
    
}

class SessionController {
    func fetchListing(accessLevel: String, completion: @escaping (Result<SessionSummaryList, Error>) -> Void){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/session"
        urlComponents.queryItems = [
            URLQueryItem(name: "listing", value: "listing"),
            URLQueryItem(name: "accessLevel", value: accessLevel)
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                let sessionList = try? jsonDecoder.decode(SessionSummaryList.self, from: data)
                completion(.success(sessionList!))
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
        
    }
}
