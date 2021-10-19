//
//  UsersReports.swift
//  cetac-nd-app
//
//  Created by user194238 on 10/18/21.
//

import Foundation

class DataEntries: Codable {
    var labels: [String]?
    var values: [Int]?
}

class UsersReportController {
    var urlComponents: URLComponents
    var group = DispatchGroup()
    var rawData: DataEntries?
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/staff"
    }
    
    func fetchReportData(reportType: String, timespan: String, completion: @escaping (Result<DataEntries, Error>) -> Void) {
        urlComponents.queryItems = [
            URLQueryItem(name: "users_report", value: reportType),
            URLQueryItem(name: "timespan", value: timespan)
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            let output = String(data: data!, encoding: String.Encoding.utf8) as String?
            print(output)
            
            if let data = data {
                do {
                    let dataSet = try jsonDecoder.decode(DataEntries.self, from: data)
                    completion(.success(dataSet))
                } catch {
                    print(error)
                }
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getReportData(reportType: String, timespan: String) -> DataEntries {
        group.enter()
        self.fetchReportData(reportType: reportType, timespan: timespan, completion: { (result) in
            DispatchQueue.global().async {
                switch result {
                case .success(let dataSet):
                    self.rawData = dataSet
                
                case.failure(let error):
                    print(error)
                }
                self.group.leave()
            }
        })
        self.group.wait()
        
        return self.rawData!
    }
}
