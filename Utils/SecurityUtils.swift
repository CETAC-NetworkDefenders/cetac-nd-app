//
//  SecurityUtils.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 09/10/21.
//

import Foundation
import CryptoKit

class SecurityUtils{
    
    static func getSalt() -> String{
        let allowedChars = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        var randomString: String = ""
        
        for _ in 0..<16{
            let index = Int.random(in: 0..<allowedChars.count)
            randomString += String(allowedChars[index])
        }

        return randomString
    }
    
    static func hashPassword(clearTextPassword: String, salt: String) -> String{
        let saltedPassword = clearTextPassword + salt
        let passwordData = Data(saltedPassword.utf8)
        let hashedPassword = SHA256.hash(data: passwordData)
        let hashedPasswordString = hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashedPasswordString
    }
}
