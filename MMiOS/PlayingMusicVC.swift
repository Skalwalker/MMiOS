//
//  PlayingMusicVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 06/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit

class PlayingMusicVC: UIViewController {

    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playingMusicLabel: UILabel!
    
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButtom: UIButton!
   
    let backColor = ColorWeel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setColors()
        musicName.text = "Ain't No Rest For The Wicked"
        artistName.text = "Cage The Elephant"
        albumName.text = "Cage The Elephant"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
    }

    func setColors(){
        let buttons = [playButton, backButton, nextButtom]
      
        let labels = [musicName, albumName, artistName, playingMusicLabel]
        
        for label in labels{
            label?.textColor = UIColor.white
        }
        
        for button in buttons{
            
            button?.imageView?.alpha = 0.25
        }
    }
}
