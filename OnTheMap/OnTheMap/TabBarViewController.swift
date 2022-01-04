//
//  TabBarViewController.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/21/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        print(UIApplication.shared.statusBarFrame.height)//44 for iPhone x, 20 for other iPhones
               navigationController?.navigationBar.barTintColor = .red


                
        let logoutButton = UIBarButtonItem(barButtonSystemItem: <#T##UIBarButtonItem.SystemItem#>, target: self, action: #selector())
      
        let addPointButton =
        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapsOnAdd))
        
       
        navigationItem.rightBarButtonItems = [addPointButton]

    
        
               let toolBar = UIToolbar()
      
               var items = [UIBarButtonItem]()
        
               items.append(
                   UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
                )
        items.append(
            
            UIBarButtonItem(barButtonSystemItem: .redo, target: nil, action: #selector(tapsOnAdd))
                    
                    )
               items.append(
                   UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapsOnAdd))
               )
               toolBar.setItems(items, animated: true)
               toolBar.tintColor = .red
               toolBar.backgroundColor = .red
               view.addSubview(toolBar)

               toolBar.translatesAutoresizingMaskIntoConstraints = false
       
        if #available(iOS 11.0, *) {
                 let guide = self.view.safeAreaLayoutGuide
                 toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
                 toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
                 toolBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
                 toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
                     }
             else {
                 NSLayoutConstraint(item: toolBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
                 NSLayoutConstraint(item: toolBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
                 NSLayoutConstraint(item: toolBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true

                 toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
             }
*/
        
    }

   @objc func tapsOnAdd(){
        print("godDman owrking")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
