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
        
        setFontSizes()
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
        
        let buttons: [UIButton: String] = [playButton: "Play", backButton: "FastBackwards",
                                           nextButtom: "FastFoward"]
        
        let labels = [musicName, albumName, artistName, playingMusicLabel]

        for (button, imageName) in buttons{
            let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            button.setImage(image, for: .normal)
            button.tintColor = UIColor.white
        }
        
        
        for label in labels{
            label?.textColor = UIColor.white
        }
    }
    
    func setFontSizes(){
        
        let labels = [albumName, artistName]
        
        for label in labels{
           if UIScreen.main.bounds.size.height == 568 {
                // IPhone 5
                label?.font = label?.font.withSize(17)
            } else if UIScreen.main.bounds.size.width == 375 {
                // iPhone 6
                label?.font = label?.font.withSize(22)
            } else if UIScreen.main.bounds.size.width == 414 {
                // iPhone 6+
                label?.font = label?.font.withSize(27)
            }
        }
        
        if UIScreen.main.bounds.size.height == 568 {
            // IPhone 5
            musicName.font = musicName.font.withSize(20)
        } else if UIScreen.main.bounds.size.width == 375 {
            // iPhone 6
            musicName.font = musicName.font.withSize(25)
        } else if UIScreen.main.bounds.size.width == 414 {
            // iPhone 6+
            musicName.font = musicName.font.withSize(30)
        }
        
        
    }
}
