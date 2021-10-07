//
//  Staff.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import Foundation

class StaffSummary: Codable{
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
    
    func getName() -> String{
        return "\(firstLastName!) \(secondLastName!) \(firstName!)"
    }
}

class StaffSummaryList: Codable{
    var staffList: [StaffSummary]?
    
    func getStaffAt(index: Int) -> String{
        return staffList![index].getName()
    }
}

class StaffController {
    
    func fetchListing(accessLevel: String, completion: @escaping (Result<StaffSummaryList, Error>) -> Void){
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/staff"
        urlComponents.queryItems = [
            URLQueryItem(name: "listing", value: "listing"),
            URLQueryItem(name: "accessLevel", value: accessLevel)
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                let staffList = try? jsonDecoder.decode(StaffSummaryList.self, from: data)
                completion(.success(staffList!))
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
