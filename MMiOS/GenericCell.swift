//
//  GenericCell.swift
//  MMiOS
//
//  Created by Mac on 11/8/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


class GenericCell: UITableViewCell{
    

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var songsCount: UILabel!
    var albumName: String = "Default"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        songsCount.textColor = UIColor.white
        self.backgroundColor = UIColor.clear
        myLabel.textColor = UIColor.white
        myImage.layer.cornerRadius = 10.0
        myImage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
