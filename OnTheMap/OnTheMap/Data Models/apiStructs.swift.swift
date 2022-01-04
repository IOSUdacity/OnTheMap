//
//  apiStructs.swift.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/14/21.
//

import Foundation


struct udacityResponse: Codable{
    var account: accountU
    var session: sessionU
   
    enum decodingCases: String, CodingKey{
        case udacityAccount = "account"
        case udacitySession = "session"
    }
}


struct accountU:Codable{
    var registered:Bool
    var key:String
}
struct sessionU:Codable{
    var id:String
    var expiration:String
}

