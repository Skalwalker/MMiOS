//
//  Cell.swift
//  MMiOS
//
//  Created by Renato Nobre on 17/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore


class Cell: UITableViewCell{
    
    
    @IBOutlet weak var musicsLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artistsLabel: UILabel!

    var albumName: String = "Default"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        musicsLabel.textColor = UIColor.white
        artistsLabel.textColor = UIColor.white
       
        albumImage.layer.cornerRadius = 10.0
        albumImage.clipsToBounds = true
}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   
}
//
//protocol HideBottomView: class {
//    func hideBottomView()
//}
