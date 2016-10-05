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

        
        settingsLabel.textColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
