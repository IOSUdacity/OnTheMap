//
//  mapData.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/15/21.
//

import Foundation
import MapKit

var decodedValing:[dataModels.studentHighLevelStruct]? = []

class mapData{

struct UrlRe {
    static  let  baseURL = URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")
}



    var decodedValues:dataModels.studentHighLevelStruct?

    var mapPoints = [MKPointAnnotation]()

//gets the data
//func completionHandling(data, response, error) ->

    class func getMapData<ResponseType: Decodable>(url: URL, responseStruct: ResponseType.Type, urlRequestParam: URLRequest?, completition: @escaping (ResponseType?, URLResponse?, Error?) -> Void)  {
        var urlRequest: URLRequest?
        
        if urlRequestParam == nil {
             urlRequest =  URLRequest(url: url)
           
        }else{
              urlRequest = urlRequestParam
            print("This is the login request")
           
          
        }
     

    let task = URLSession.shared.dataTask(with: urlRequest!)  {  (data, response, error)   in
    
            guard var data = data else{
                DispatchQueue.main.async{
                    completition(nil, nil, error)
            
                };   return  }
        
        
            let decoder = JSONDecoder()
        do{
            var ndata = data
            if urlRequestParam != nil{
                ndata = data.subdata(in: 5..<data.count)
            }
            
            
            
            
            var decodedValue = try decoder.decode(responseStruct, from: ndata)
            
        
            print("Printing downloaded Information\n\n")
            print(decodedValue)
            DispatchQueue.main.async{
            
            completition(decodedValue, response, nil)
            }
         
        } catch{
            print(error)
            completition(nil,nil, error)
            
        }
        
    }
    task.resume()
    return
}




    class func firstNameLastName<ResponseType : Decodable> (userId: String, responseStruct: ResponseType.Type, url:URL, completition: @escaping  ( ResponseType?, Error?)->Void){
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        

         let task =  URLSession.shared.dataTask(with: request){ (data, response, error) in
                guard let data = data else{
                   completition(nil, error)
                    return
                }
                let decoder = JSONDecoder()
                let cutData = data.subdata(in: 5..<data.count)
                
           
                    do {
                        let decodedData = try! decoder.decode(responseStruct.self, from: cutData)
                        completition(decodedData, nil)
                
                    } catch{
                        completition(nil,  error)
                    }
                }
       task.resume()
        
  
        }
    
   class func deleteSession(urlReq: URLRequest){
    
    var request = urlReq
    var xsrfCookie: HTTPCookie? = nil
    let sharedCookieStorage = HTTPCookieStorage.shared
        
    for cookie in sharedCookieStorage.cookies! {
        if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie}
    }
    if let xsrfCookie = xsrfCookie {
        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data else {
            print("data was empty")
            return
        }
        
        if error != nil {
            print("There was an error")
            print(error)
        }
        let newData = data.subdata(in: 5..<data.count)
       
        print("Printing data from Delete call")
        print(String(data: newData, encoding: .utf8)!)
    
    }
    task.resume()
        
    }

}
