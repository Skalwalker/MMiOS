//
//  CustomPlayerVC.swift
//  MMiOS
//
//  Created by William on 11/11/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import AVKit

class CustomPlayerVC: AVPlayerViewController {

    lazy var topView = UIView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        topView.backgroundColor = UIColor.clear
        self.topView.isHidden = true
        self.view.addSubview(topView)
        self.view.bringSubview(toFront: topView)
        topView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleTap)))
        self.showsPlaybackControls = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap() {
        
        // Show the control
        self.showsPlaybackControls = true
        
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
