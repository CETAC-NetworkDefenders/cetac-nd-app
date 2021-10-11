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

class StaffDetail: Codable {
    var id: Int?
    var firstLastname: String?
    var secondLastname: String?
    var firstname: String?
    var accessLevel: String?
    var cellphone: String?
    var zipCode: String?
    var street: String?
    var neighborhood: String?
    var addressNumber: Int?
    var specialty: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstLastname = "first_lastname"
        case secondLastname = "second_lastname"
        case firstname
        case cellphone
        case zipCode = "zip_code"
        case street
        case neighborhood
        case addressNumber = "address_number"
    }
    
    func isValid() -> String? {
        if self.cellphone!.range(of:#"\d{10}"#, options: .regularExpression) == nil{
            return "El número celular es incorrecto. Deben ser 10 digitos."
        }
        else if self.zipCode!.range(of:#"\d{5}"#, options: .regularExpression) == nil{
            return "El código postal es incorrecto. Deben ser 5 digitos."
        }
        else if self.addressNumber == nil {
            return "El número de la dirección es incorrecto. Debe tener de 1 a 5 digitos."
        }
        
        return nil
    }
}

class StaffNew: Codable {
    
    var firstLastname: String?
    var secondLastname: String?
    var firstname: String?
    var accessLevel: String?
    var cellphone: String?
    var zipCode: String?
    var street: String?
    var neighborhood: String?
    var addressNumber: String?
    var specialty: String?
    var email: String?
    var password: String?
    var salt: String?
    
    enum CodingKeys: String, CodingKey {
        case firstLastname = "first_lastname"
        case secondLastname = "second_lastname"
        case firstname
        case cellphone
        case zipCode = "zip_code"
        case street
        case neighborhood
        case addressNumber = "address_number"
        case accessLevel = "access_level"
        case email = "username"
        case password
        case salt
    }
    
    func isValid() -> String? { // returns nil if the staff is completely valid
        
        if self.cellphone!.range(of:#"\d{10}"#, options: .regularExpression) == nil{
            return "El número celular es incorrecto. Deben ser 10 digitos."
        }
        else if self.zipCode!.range(of:#"\d{5}"#, options: .regularExpression) == nil{
            return "El código postal es incorrecto. Deben ser 5 digitos."
        }
        else if self.addressNumber!.range(of:#"\d{1,5}"#, options: .regularExpression) == nil{
            return "El número de la dirección es incorrecto. Debe tener de 1 a 5 digitos."
        }
        else if self.email!.range(of:#"\S+@\S+\.\S+"#, options: .regularExpression) == nil{
            return "El correo electrónico es incorrecto."
        }
        else if self.password!.range(of:#"(?=.{8,})"#, options: .regularExpression) == nil{
            return "La contraseña debe tener al menos 8 caracteres."
        }
        else if self.password!.range(of:#"(?=.*[A-Z])"#, options: .regularExpression) == nil{
            return "La contraseña debe tener al menos una mayuscula."
        }
        else if self.password!.range(of:#"(?=.*[a-z])"#, options: .regularExpression) == nil{
            return "La contraseña debe tener al menos una minuscula."
        }
        else if self.password!.range(of:#"(?=.*\d)"#, options: .regularExpression) == nil{
            return "La contraseña debe tener al menos un digito."
        }
        else if self.password!.range(of:#"(?=.*[$%&?._-])"#, options: .regularExpression) == nil{
            return "La contraseña debe tener al menos un carácter especial ($%&?._-)."
        }
        else if self.accessLevel == "" {
            return "Seleccione un nivel de acceso"
        }
        
        return nil
    }
    
    func makeSecure(){
        self.salt = SecurityUtils.getSalt()
        self.password = SecurityUtils.hashPassword(clearTextPassword: self.password!, salt: self.salt!)
    }

}

class StaffController {
    
    var urlComponents: URLComponents
    
    init() {
        urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseURL
        urlComponents.path = "/default/staff"
    }
    
    func fetchListing(accessLevel: String, completion: @escaping (Result<StaffSummaryList, Error>) -> Void){
        
        urlComponents.queryItems = [
            URLQueryItem(name: "listing", value: "listing"),
            URLQueryItem(name: "access_level", value: accessLevel)
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
    
    func fetchDetail(staffId: Int, completion: @escaping (Result<StaffDetail, Error>) -> Void) {
        
        urlComponents.queryItems = [
            URLQueryItem(name: "staff_id", value: String(staffId))
        ]
        
        URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
            let jsonDecoder = JSONDecoder()

            if let data = data{
                do{
                    let staffDetailRes = try jsonDecoder.decode(StaffDetail.self, from: data)
                    completion(.success(staffDetailRes))
                } catch {
                    print(error)
                }
            }
            else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func updateStaff(staff: StaffDetail, completion: @escaping () -> Void) {
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(staff)

        urlComponents.queryItems = nil
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "PATCH"
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
    
    func createStaff(staff: StaffNew, completion: @escaping () -> Void){
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(staff)
        
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
