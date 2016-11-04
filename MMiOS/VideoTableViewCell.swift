//
//  VideoTableViewCell.swift
//  MMiOS
//
//  Created by William on 28/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit


class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoDuration: UILabel!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videosThumbnail: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        videoDuration.textColor = UIColor.white
        videoTitle.textColor = UIColor.white
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
