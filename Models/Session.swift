//
//  Session.swift
//  cetac-nd-app
//
//  Created by Iñigo Zepeda on 10/7/21.
//

import Foundation

class SessionSummary: Codable {
    var session_id: Int?
    var session_date: String?
    var intervention_type: String?
    
    enum CodingKeys: String, CodingKey {
        case session_id = "id"
        case session_date = "session_date"
        case intervention_type = "intervention_type"
    }
}

class SessionSummaryList: Codable {
    
    var sessionList: [SessionSummary]?
    
    enum CodingKeys: String, CodingKey {
        case sessionList
    }
}


class SessionDetail: Codable {
    
    var tool: String?
    var interventionType: String?
    var sessionNumber: Int?
    var evaluation: String?
    var sessionDate: String?
    var motive: String?
    var serviceType: String?
    var recoveryFee: Double?
    var recordId: Int?
    var isOpen: Bool?
    
    enum CodingKeys: String, CodingKey {
        case tool
        case interventionType = "intervention_type"
        case sessionNumber = "session_number"
        case evaluation
        case sessionDate = "session_date"
        case motive
        case recoveryFee = "recovery_fee"
        case recordId = "record_id"
        case serviceType = "service_type"
        case isOpen = "is_open"
    } 
        
    func isValid() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if tool == nil || tool == ""{
            return "Seleccione una herramienta."
        }
        else if interventionType == nil || interventionType == ""{
            return "Seleccione un tipo de intervención."
        }
        else if evaluation == nil || evaluation == ""{
            return "Proporcione la evaluación de la sesión."
        }
        else if formatter.date(from: sessionDate!) == nil{
            return "La fecha de la sesión debe estar en formato YYYY-mm-dd"
        } else if motive == nil || motive == ""{
            return "Seleccione un motivo de intervención"
        }
        else if recoveryFee == nil {
            return "Proporcione la cuota de recuperación"
        }
        return nil
    }
}

class SessionController {
    
    var urlComponents: URLComponents
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/session"
    }
    
    func fetchListing(id: Int, completion: @escaping (Result<SessionSummaryList, Error>) -> Void){

        urlComponents.queryItems = [
            URLQueryItem(name: "listing", value: "listing"),
            URLQueryItem(name: "userId", value: String(id))
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                let output = String(data: (data), encoding: String.Encoding.utf8) as String?
                print(output)
                let sessionList = try? jsonDecoder.decode(SessionSummaryList.self, from: data)
                completion(.success(sessionList!))
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchDetail(id: Int, completion: @escaping (Result<SessionDetail, Error>) -> Void){

        urlComponents.queryItems = [
            URLQueryItem(name: "sessionId", value: String(id))
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                let output = String(data: (data), encoding: String.Encoding.utf8) as String?
                print(output)
                let sessionList = try? jsonDecoder.decode(SessionDetail.self, from: data)
                completion(.success(sessionList!))
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func createSession(session: SessionDetail, completion: @escaping () -> Void){
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(session)
        
        urlComponents.queryItems = nil
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        request.setValue("\(String(describing: jsonData?.count))", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpStatus = response as? HTTPURLResponse {
                if  httpStatus.statusCode != 200 {
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
