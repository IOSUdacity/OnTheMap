//
//  TableViewCell.swift
//  OnTheMap
//
//  Created by Jack McCabe on 12/22/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    

    @IBOutlet weak var locationCellView: UIView?
    
    
    @IBOutlet weak var locationPin: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var mediaLink: UILabel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
