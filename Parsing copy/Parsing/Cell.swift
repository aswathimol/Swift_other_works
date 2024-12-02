//
//  Cell.swift
//  Parsing
//
//  Created by Aswathimol S(UST,IN) on 09/10/23.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet var labelView: UILabel!
    @IBOutlet var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        self.frame = CGRect(x: 10.0, y: self.frame.origin.y, width: 375, height: self.frame.size.height)
            super.layoutSubviews()

        }
   
}

