//
//  SearchTableViewCell.swift
//  jobInterview
//
//  Created by Tom Ben Ari on 28/11/2016.
//  Copyright © 2016 Tom Ben Ari. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    static let idendtifier = "cell"
    
    func configure(_ item : Item)  {
        nameLabel.text = item.title
        yearLabel.text = item.year
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
