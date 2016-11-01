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
    @IBOutlet weak var aboutMeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setColor()
        setFontSize()
        
        // Do any additional setup after loading the view.
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
    }

    
    func setColor(){
        let textBoxes = [textBoxOne, textBoxTwo, textBoxThree]
        
        for textBox in textBoxes{
            textBox?.textColor = UIColor.white
        }
        
        aboutMeLabel.textColor = UIColor.white
    }
    
    func setFontSize(){
        let textViews = [textBoxOne, textBoxTwo, textBoxThree]
        
        for textView in textViews{
            if UIScreen.main.bounds.size.height == 568 {
                // IPhone 5
                textView?.font = textView?.font?.withSize(14)
            } else if UIScreen.main.bounds.size.width == 375 {
                // iPhone 6
                textView?.font = textView?.font?.withSize(17)
            } else if UIScreen.main.bounds.size.width == 414 {
                // iPhone 6+
                textView?.font = textView?.font?.withSize(17)
            }
        }
        
    }

    @IBAction func gitHub(_ sender: AnyObject) {
        let url = NSURL(string: "https://github.com/Skalwalker/MMiOS")
        UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func unb(_ sender: AnyObject) {
        let url = NSURL(string: "http://www.unb.br")
        UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)

    }

}
