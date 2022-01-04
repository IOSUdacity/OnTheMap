//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/12/21.
//

import UIKit

class LoginViewController: UIViewController, LocalizedError {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    struct idkWhatToNameYou: Codable{
        var udacity: usrPass
    }
    struct usrPass: Codable {
        var user:String
        var pass:String
        enum name: String, CodingKey{
            case user = "username"
            case pass = "password"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = ""
       password.text=""
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(email.text!)\", \"password\": \"\(password.text!)\"}}".data(using: .utf8)
    
     
    
        mapData.getMapData(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!, responseStruct: udacityResponse.self, urlRequestParam: request) {
            (response, response1, error) in
            
            guard let response = response else {
                      
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: "Login Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                 alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,  handler: {action in
                     
                 }) )
                   
                 self.present(alert, animated:true)
                    
                }
                return
            }
            print("Printign Key 75300698254")
           print( response.account.key)
            
            let newResponse = response1 as! HTTPURLResponse
            let statusResponse = Int(exactly: newResponse.statusCode)!
            
            guard statusResponse == 200 else{
  
               DispatchQueue.main.async{
                let alert = UIAlertController(title: "Login Attempt", message: "Login was unsuccessful, please try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel,  handler: {action in
                    print("login was unsuccesful")
                }) )
                self.present(alert, animated:true) }
                return  }
                                   
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: "loggedIn", sender: nil)
            }
            
        }
            
     
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        DispatchQueue.main.async{
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com")!, options: [:], completionHandler: nil)
        }
    }
    @IBAction func loginThroughFacebook(_ sender: Any) {
        
    }
    

}
