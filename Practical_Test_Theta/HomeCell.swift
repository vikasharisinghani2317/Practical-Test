//
//  HomeCell.swift
//  Practical_Test_Theta
//
//  Created by hyperlink on 08/02/22.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblAge : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
