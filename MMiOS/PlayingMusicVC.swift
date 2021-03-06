//
//  PlayingMusicVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 06/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import MediaPlayer

class PlayingMusicVC: UIViewController{

    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var playingMusicLabel: UILabel!
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButtom: UIButton!
    @IBOutlet weak var backScreen: UIButton!
    
    var passedArtistName: String = ""
    var passedAlbumName: String = ""
    var passedMusicName: String = ""
    var passedImage: UIImage = #imageLiteral(resourceName: "mzi.zdsarhql.600x600-75")
    

    @IBOutlet weak var Volume: MPVolumeView!
    
    let backColor = ColorWeel()
    let control = AudioController()
    var reproductor = AVAudioPlayer()
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor.fixedColor()
        
        setFontSizes()
        setColors()
        wraperView()
        //Volume.value = reproductor.volume
    
      
        musicName.text = passedMusicName
        artistName.text = passedArtistName
        albumName.text = passedAlbumName
        albumImage.image = passedImage
        
        albumImage.layer.cornerRadius = 10.0
        albumImage.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setPausePlay()
    }
    
    
    func setColors(){
        
        let buttons: [UIButton: String] = [playButton: "Play",
                                           backButton: "FastBackwards",
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
    
    func setPausePlay(){
        if(control.getPlaying()){
            let image = UIImage(named: "Pause")?.withRenderingMode(.alwaysTemplate)
            playButton.setImage(image, for: .normal)
            playButton.tintColor = UIColor.white
        } else {
            let image = UIImage(named: "Play")?.withRenderingMode(.alwaysTemplate)
            playButton.setImage(image, for: .normal)
            playButton.tintColor = UIColor.white
        }
        
        

        
    }
    
    @IBAction func playMusic(_ sender: AnyObject) {
        if control.getPlaying(){
            control.pausePlaying()
            let image = UIImage(named: "Play")?.withRenderingMode(.alwaysTemplate)
            playButton.setImage(image, for: .normal)
            playButton.tintColor = UIColor.white
        } else {
            control.play()
            let image = UIImage(named: "Pause")?.withRenderingMode(.alwaysTemplate)
            playButton.setImage(image, for: .normal)
            playButton.tintColor = UIColor.white

        }
        
        
    }
    
    @IBAction func lastMusic(_ sender: AnyObject) {
        control.returnMusic()
        updateNames()
    }
    
    @IBAction func nextMusic(_ sender: AnyObject) {
        control.skipMusic()
        updateNames()
    }
    
    @IBAction func backScreenAnimOff(_ sender: AnyObject) {
        dismiss(animated: false, completion: nil)
    }
    
    func updateNames(){
        let music = control.itemNowPlaying()
        let size = CGSize.init(width: 52.0, height: 52.0)
        
        musicName.text = music?.title
        albumName.text = music?.albumTitle
        artistName.text = music?.artist
        albumImage.image = music?.artwork?.image(at: size)
    }
    
    
    //@IBAction func changeVolume(_ sender: AnyObject) {
    //    print(Volume.value)
    //}
    
    
    func wraperView(){
        let wrapperView = UIView(frame: Volume.bounds)
        wrapperView.backgroundColor = UIColor.clear;
        self.view.addSubview(wrapperView)
        wrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.sendSubview(toBack: wrapperView)
        wrapperView.addSubview(Volume)
        
    }
 
}
