//
//  AboutMeVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 30/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit

class AboutMeVC: UIViewController {

    var backColor = ColorWeel()
    @IBOutlet weak var textBoxOne: UITextView!
    @IBOutlet weak var textBoxTwo: UITextView!
    @IBOutlet weak var textBoxThree: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textBoxes = [textBoxOne, textBoxTwo, textBoxThree]
        
        for textBox in textBoxes{
            textBox?.textColor = UIColor.white
        }
        
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
