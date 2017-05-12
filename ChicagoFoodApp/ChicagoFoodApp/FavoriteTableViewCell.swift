//
//  FavoriteTableViewCell.swift
//  ChicagoFoodApp
//
//  Created by zhang  zhihao on 5/10/17.
//  Copyright © 2017 YUNFEI YANG. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var facilityImage: UIImageView!
    @IBOutlet weak var facilityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
