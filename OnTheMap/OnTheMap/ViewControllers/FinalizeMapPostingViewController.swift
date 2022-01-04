//
//  FinalizeMapPostingViewController.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/17/21.
//

import UIKit
import MapKit

let group = DispatchGroup()


class FinalizeMapPostingViewController: UIViewController, MKMapViewDelegate {
    
    var points = MKPointAnnotation()
    var mediaLink:String?
    var mapPoints = [MKPointAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async{
            self.mapView.delegate = self
 
            self.mapPoints.append(self.points)
        self.mapView.addAnnotations(self.mapPoints)
            self.mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.points.coordinate.latitude, longitude: self.points.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta:25, longitudeDelta: 25)), animated: true)
        }
    }
    
@objc    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if segue.identifier == "toTBVC"{
            if  let mapVC = segue.destination as? ViewController{
          mapPoints.append(points)
            }
        }
    }
    
    var firstName:String?
    var lastName:String?
    
    @IBAction func postAnnotations(_ sender: Any) {
               
        
        group.enter()
      
            mapData.firstNameLastName(userId: "nil", responseStruct: dataModels.getUserInfo.self, url: URL(string: "https://onthemap-api.udacity.com/v1/users/3903878747")!){
                (response, error) in
                
                guard error != nil else{
                    let alert = UIAlertController(title: "Failed", message: "to Post new location", preferredStyle: .alert)
                    alert.addAction( UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                    
                    self.present(alert, animated:true)
                    return
                }
                if let fN = response?.firstName{
                    self.firstName =  fN
                }else{
                    self.firstName = ""
                }
                if let lN = response?.lastName {
                    self.lastName = lN
                }else{
                    self.lastName = ""
                }
                
               
                group.leave()
            }

        group.wait()
        
        do{
            let newLocation:dataModels.studentLocations = dataModels.studentLocations(createdAt: "2015-03-11T02:48:18.321Z", firstName: "\(self.firstName!)", lastName: "\(self.lastName!)", latitude: points.coordinate.latitude, longitude:points.coordinate.longitude, mapString: " string ", mediaURL: self.mediaLink ?? " mediaLink was null", objectId: "2332", uniqueKey: "22332", updatedAt: "23232")
        
        var request = URLRequest(url: URL(string:"https://onthemap-api.udacity.com/v1/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(newLocation)
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error{
                let alert = UIAlertController(title: "Failed", message: "to Post new location", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
                
                self.present(alert, animated:true)
                return
            }
            
            print("Printing data from POST\n")
            print(String(data: data!, encoding: .utf8))
         
        }
        task.resume()

        self.performSegue(withIdentifier:"toTBVC" , sender: self)
         
            
        }catch {
            let alert = UIAlertController(title: "Failed", message: "to Post new location", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
            
            self.present(alert, animated:true)
            
        }
    }

    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(URL(string: toOpen)!)
            }
        }
    }
    


}
