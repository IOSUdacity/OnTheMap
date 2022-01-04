//
//  LocationsTableViewController.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/22/21.
//

import UIKit

class LocationsTableViewController: UITableViewController {

    @IBOutlet var locationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func segueToAddMemes(_ sender: Any) {
        
        self.performSegue(withIdentifier: "addLocation", sender: self)
        
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session" )!)
        request.httpMethod = "DELETE"
        
        mapData.deleteSession(urlReq: request)
        
    
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(mapPoints.count)
        return mapPoints.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        if (mapPoints.count > 100){
            return 100}
        return mapPoints.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = locationTableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.locationPin?.image = UIImage(named: "icon_pin")
        cell.name?.text = mapPoints[indexPath.row].title
        cell.mediaLink?.text = mapPoints[indexPath.row].subtitle

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath){
        let link = mapPoints[indexPath.row].subtitle
        
        DispatchQueue.main.async{
            if let link = link {
                if let guardedURL = NSURL(string: link){
                            if UIApplication.shared.canOpenURL( guardedURL as URL){
                                    UIApplication.shared.open(URL(string: link)!)
                            } else {print("url is not valid, or does not start with https://")
                                    return
                                }
                }
            }
                
        }
        
    }

 

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
