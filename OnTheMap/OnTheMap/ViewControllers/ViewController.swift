//
//  ViewController.swift
//  PinSample
//
//  Created by Jason on 3/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import MapKit


var letsHopeThisworks:dataModels.studentHighLevelStruct?
public var mapPoints = [MKPointAnnotation]()

class ViewController: UIViewController, MKMapViewDelegate {
    /*
    @IBAction func addLocation(_ sender: Any) {
        performSegue(withIdentifier: addLocat, sender: sender     )
    }
     */
    
    @IBOutlet weak var mapView: MKMapView!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
     
        mapData.getMapData(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100&order=-updatedAt")!, responseStruct: dataModels.studentHighLevelStruct.self,  urlRequestParam: nil) {
            response, response1, error in
            

            guard error == nil else{
                
                let alert = UIAlertController(title: "Download Failure", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Please try again", style: .destructive, handler:nil))
                self.present(alert, animated: true)

                return
            }
     
            
            if let response = response{

                
                for x in 0..<response.results.count {
                    let lat = response.results[x].latitude
                    let long = response.results[x].longitude
                    
                    let lat_long = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                     let first = response.results[x].firstName
                    let medURL = response.results[x].mediaURL
                    
                    let point = MKPointAnnotation()
                    point.coordinate = lat_long
                    point.title = "\(first)"
                    point.subtitle = "\(medURL)"
                    
                   // self.mapPoints.append(point)
                    mapPoints.append(point)
                }
             //   self.mapView.addAnnotations(self.mapPoints)
                self.mapView.addAnnotations(mapPoints)
                } else {
                    print(error)
                }
            
        }
        


    }
    
    @IBAction func logOut(_ sender: Any) {
      
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session" )!)
        request.httpMethod = "DELETE"
        
        mapData.deleteSession(urlReq: request)
        
        self.dismiss(animated: true, completion:nil)
      //  performSegue(withIdentifier: "loginSegue", sender: self)
     // ^ the above segued and did not dissmiss
    }
    
  
    
    
    
    // MARK: - MKMapViewDelegate

    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
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
            //unwrapping the subtitle
            if let toOpen = view.annotation?.subtitle! {
                if let guardedURL =  NSURL(string: toOpen){
                    if (app.canOpenURL(guardedURL as URL)){
                            app.openURL(URL(string: toOpen)!)
                    }else {
                        print("URL was no valid")
                    }
                    
                }
                }
    }
    }
//    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//
//        if control == annotationView.rightCalloutAccessoryView {
//            let app = UIApplication.sharedApplication()
//            app.openURL(NSURL(string: annotationView.annotation.subtitle))
//        }
//    }

   
}
