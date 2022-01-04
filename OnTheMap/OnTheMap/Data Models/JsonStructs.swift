//
//  JsonStructs.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/29/21.
//

import Foundation

class dataModels{
struct studentHighLevelStruct: Codable {
    var results:[studentLocations]
}
    
struct studentLocations: Codable{
    var createdAt:String
    var firstName:String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var objectId: String
    var uniqueKey:String
    var updatedAt: String
}
    
    
    struct getUserInfo: Codable {
        var firstName: String
        var lastName: String
        
        enum CodingKeys: String, CodingKey{
            case firstName = "first_name"
            case lastName = "last_name"
        }
    }
    
}
