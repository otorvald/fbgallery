//
//  AlbumListCell.swift
//  FBPhotoBrowser
//
//  Created by Max Bystryk on 06.09.17.
//  Copyright © 2017 max.bystryk.dev. All rights reserved.
//

import UIKit

class AlbumListCell: UITableViewCell {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
