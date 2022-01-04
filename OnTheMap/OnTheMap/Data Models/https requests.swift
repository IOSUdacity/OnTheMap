//
//  https request.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/10/21.
//

import Foundation
import MapKit

/*
 
structs to parse with Codable

we will need MKLocalSearchCompletion
shareTask.


We will need the url

we will need

send request dataTask
collect the informatoin
*/
/*
struct UrlRe {
    static  let  baseURL = URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")
}

struct studentHighLevelStruct: Codable {
    var results:[studentLocations]
}
struct studentLocations: Codable{
    var createdAt:String
    var firstName:String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var objectId: String
    var uniqueKey:String
    var updatedAt: String
}


//gets the data

func tryingThisOut(){
   // var decodedValues:[studentLocations]

    let decoder = JSONDecoder()
        //put in @escaping
    let task = URLSession.shared.dataTask(with: UrlRe.baseURL!)  {  (data, response, error) in
            guard let data = data else{
                print("error")
               return
            }
        do{
                print(data)

            var decodedValues = try decoder.decode(studentHighLevelStruct.self, from: data)
            print("1")
            //prints John the first array portion of it
            print(decodedValues.results[0])
            return
        } catch{
            print("2")
            print(error)
            return
        }
        }
    task.resume()
    
    }
 */

//POSTing new location

/*
let newStudent:studentLocations = studentLocations(createdAt: "Jack", firstName: "AlsoJack", latitude: 40.7617, longitude: -130.4216, mapString: "MountainView, CA", mediaURL: "www.google.com", objectId: "32322", uniqueKey: "232", updatedAt: "23232")

    func postStudentLocation(){
    
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(newStudent)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else{
                return
            }
            
            print(response)
            
        }
        
        task.resume()
}
*/



