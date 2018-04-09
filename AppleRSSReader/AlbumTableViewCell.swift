//
//  AlbumTableViewCell.swift
//  AppleRSSReader
//
//  Created by Dominic Pilla on 10/15/17.
//  Copyright © 2017 Dominic Pilla. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var favoriteStar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFavoriteTap(_:)))
        favoriteStar.addGestureRecognizer(tapGesture)
        
        favoriteStar.isUserInteractionEnabled = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func handleFavoriteTap(_ gesture: UIGestureRecognizer) {
        if let image = favoriteStar.image {
            if image.isEqual(UIImage(named: "hollow-star.png")) {
                favoriteStar.image = UIImage(named: "filled-star.png")
            } else {
                favoriteStar.image = UIImage(named: "hollow-star.png")
            }
        }
    }
}
