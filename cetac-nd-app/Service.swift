//
//  Service.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 04/10/21.
//

import Foundation

struct Service: Decodable{
    var serviceName: String
    var description: String
    var image: String
}

struct ServiceGroup: Decodable{
    var groupName: String
    var iconImage: String
    var iconSelectedImage: String
    var services: [Service]
}

