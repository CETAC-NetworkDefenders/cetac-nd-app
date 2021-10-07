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

struct StaffSection{
    let letter: String
    let staffList: [StaffSummary]
}

class StaffSummaryList: Codable{
    
    var staffList: [StaffSummary]?
    var staffGroup: [StaffSection]?
    
    enum CodingKeys: String, CodingKey {
        case staffList
    }
    
    func getStaffAt(section: Int, index: Int) -> String{
        return staffGroup![section].staffList[index].getName()
    }
    
    func buildGroups() -> Void{
        if staffList == nil{
            staffGroup = nil
            return
        }
            
        let groupedStaff = Dictionary(grouping: staffList!, by: {String($0.firstLastName!.prefix(1))})
        let keys = groupedStaff.keys.sorted()
        staffGroup = keys.map{StaffSection(letter: $0, staffList: groupedStaff[$0]!) }

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
