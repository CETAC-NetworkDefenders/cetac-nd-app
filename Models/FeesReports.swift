//
//  SessionReports.swift
//  cetac-nd-app
//
//  Created by Iñigo Zepeda on 18/10/21.
//

import Foundation

class ContinousDataEntries: Codable {
    var labels: [String]?
    var values: [Double]?
}

class FeesReportController {
    var urlComponents: URLComponents
    var group = DispatchGroup()
    var rawData: ContinousDataEntries?
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/staff"
    }
    
    func fetchReportData(reportType: String, timespan: String, completion: @escaping (Result<ContinousDataEntries, Error>) -> Void) {
        
        urlComponents.queryItems = [
            URLQueryItem(name: "recovery_fees_report", value: reportType),
            URLQueryItem(name: "timespan", value: timespan)
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            let output = String(data: (data)!, encoding: String.Encoding.utf8) as String?
            print(output)

            //hacer json decode
            if let data = data{
                do{
                    let dataSet = try jsonDecoder.decode(ContinousDataEntries.self, from: data)
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
    
    func getReportData(reportType: String, timespan: String) -> ContinousDataEntries {
        group.enter()
        self.fetchReportData(reportType: reportType, timespan: timespan, completion: { (result) in
            DispatchQueue.global().async {
                switch result {
                    case .success(let dataSet):
                        self.rawData = dataSet
                    
                    case .failure(let error):
                        print(error)
                }
                self.group.leave()
            }
        })
        self.group.wait()
        
        return self.rawData!
    }
}

 
