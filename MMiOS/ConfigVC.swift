//
//  ConfigVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 30/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit

class ConfigVC: UIViewController {

    var backColor = ColorWeel()

    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor.fixedColor()
        settingsLabel.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
