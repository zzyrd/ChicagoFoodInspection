//
//  AllFacilityTableViewCell.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 5/9/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import UIKit

class AllFacilityTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var facilityName: UILabel!
    @IBOutlet weak var facilityAddress: UILabel!
    @IBOutlet weak var facilityType: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
