//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Lucas Andrade on 1/24/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var labelMovieJustOne: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
