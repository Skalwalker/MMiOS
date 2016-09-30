//
//  MainMusicVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 29/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit

class MainMusicVC: UIViewController {

    @IBOutlet weak var playingMusicName: UILabel!
    @IBOutlet weak var libraryLabel: UILabel!
    @IBOutlet weak var albunsButton: UIButton!
   
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var playlistsButton: UIButton!
    
    @IBOutlet weak var tabBarMusics: UITabBarItem!
    
    var backColor = ColorWeel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        playingMusicName.text = "Ain't No Rest For The Wicked"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
    }

    func setColors(){
        
        let buttons = [artistsButton, albunsButton, playlistsButton]
        
        
        for button in buttons{
            button?.setTitleColor(UIColor.white, for: UIControlState.normal)
            button?.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: UIControlState.highlighted)
        }
        
        libraryLabel.textColor = UIColor.white


    }

}
