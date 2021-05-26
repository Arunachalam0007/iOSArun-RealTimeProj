//
//  KartCell.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class KartCell: UITableViewCell {

    @IBOutlet weak var kartImage: UIImageView!
    @IBOutlet weak var kartName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
