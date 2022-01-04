//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/17/21.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, MKMapViewDelegate {

    var point = MKPointAnnotation()
   

    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var mediaLink: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var unwrappedMediaLink:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelAddLocation(_ sender: Any) {
    
        
        //   self.navigationController?.popViewController(animated: true)
      //  self.navigationController?.popoverPresentationController
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "finalizeLocation" {
            print("In Segue(finalizeLocation) Prepare")
         
            if let finalLoc = segue.destination as? FinalizeMapPostingViewController{
                finalLoc.points = self.point
                finalLoc.points.subtitle = unwrappedMediaLink
                
            }
        }else{
            print("Non finalization Segue")
    }
        // Pass the selected object to the new view controller.
    }
    

 
    @IBAction func addLocation(_ sender: Any) {
        
        if let link = mediaLink?.text, link == "Link"  {
            
            let alert = UIAlertController(title: "MediaLink Cannot be Empty", message: "Please enter a link.", preferredStyle: .actionSheet)
             alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                 print("link was empty")
             }))
             self.present(alert, animated:true)
      return
        } else{
            unwrappedMediaLink = mediaLink.text!
        }
   
        

        if let loc = location?.text {
      
            activityIndicator.startAnimating()
            
            CLGeocoder().geocodeAddressString(loc) { (response, error) in
                if let response = response{
                    if ((response.first?.location?.coordinate.longitude != nil) && (response.first?.location?.coordinate.latitude != nil )) {
                        let lat_long = CLLocationCoordinate2D(latitude: (response.first?.location?.coordinate.latitude)!, longitude: (response.first?.location?.coordinate.longitude)!)
                        self.point.coordinate = lat_long
                    }
                    self.point.subtitle = self.mediaLink?.text
                
                    
                     self.performSegue(withIdentifier: "finalizeLocation", sender: self)
                  
                }else {
                print("error = ");                print(error?.localizedDescription)
               let alert = UIAlertController(title: "Incorrect Location", message: "Please input a valid location", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: { action in
                    print(" in alert statement")
                }))
                
                self.present(alert, animated:true)
                }
            }
            
        }else {
            
            let alert = UIAlertController(title: "Location Not Valid", message: "Please enter a valid location.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again", style: .cancel , handler: { action in
             print("Location given was nil")
            }))
       
        }
         
        
    }
    
    


}
