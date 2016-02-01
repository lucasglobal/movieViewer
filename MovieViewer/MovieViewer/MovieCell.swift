//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Lucas Andrade on 1/24/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var releaseDateLabelDynamic: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var buttonSeeMore: UIButton!
    @IBOutlet weak var votesLabelDynamic: UILabel!
    @IBOutlet weak var ratingLabelStatic: UILabel!
    @IBOutlet weak var voteLabelStatic: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var ratingsLabelDynamic: UILabel!
    @IBOutlet weak var labelMovieJustOne: UILabel!
    @IBOutlet weak var releaseDateLabelStatic: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
