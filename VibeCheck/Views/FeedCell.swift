//
//  FeedCell.swift
//  VibeCheck
//
//  Created by MacBook Pro on 21.02.2026.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var documentID: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
