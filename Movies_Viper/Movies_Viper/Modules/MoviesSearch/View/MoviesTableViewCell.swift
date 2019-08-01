//
//  MoviesTableViewCell.swift
//  Movies_Viper
//
//  Created by Luigy Vega on 8/1/19.
//  Copyright © 2019 Luigy Vega. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
