//
//  MainMusicVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 29/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit

class MainMusicVC: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var playingMusicName: UILabel!
    @IBOutlet weak var libraryLabel: UILabel!
    @IBOutlet weak var albunsButton: UIButton!
   
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var playlistsButton: UIButton!
    @IBOutlet weak var buttonToPlaying: UIButton!
    
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var bottomView: UIView!
    
    
    var backColor = ColorWeel()
    var controller = AudioController()
    var musics = MusicsModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        setColors()
        
        //This should not be here
        UITabBar.appearance().tintColor = UIColor.black
        
        //This is a default prop.
        playingMusicName.text = "Ain't No Rest For The Wicked"
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
        hideBottomView()
      
    }

    func hideBottomView(){
        print(controller.getPlaying())
        if(controller.getPlaying() == false){
            bottomView.isHidden = true
            buttonToPlaying.isEnabled = false
        } else {
            bottomView.isHidden = false
            buttonToPlaying.isEnabled = true
        }
    }
    
    func setColors(){
        
        let buttons = [artistsButton, albunsButton, playlistsButton]
        let labels = [playingMusicName, libraryLabel]
        
        for button in buttons{
            button?.setTitleColor(UIColor.white, for: UIControlState.normal)
            button?.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: UIControlState.highlighted)
        }
        for label in labels{
            label?.textColor = UIColor.white
        }
        
        blurBottomView()
    }
    
    func blurBottomView(){
        if !UIAccessibilityIsReduceTransparencyEnabled(){
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = self.bottomView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.bottomView.addSubview(blurEffectView)
            self.bottomView.sendSubview(toBack: blurEffectView)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(musics.getSongQueryCount())
        return musics.getSongQueryCount()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! Cell
        let size = CGSize.init(width: 52.0, height: 52.0)
        
        // Configure the cell...
        cell.musicsLabel.text = self.musics.getSongsQuery().items?[indexPath.row].title
        cell.albumImage.image = self.musics.getSongsQuery().items?[indexPath.row].artwork?.image(at: size)
        cell.artistsLabel.text = self.musics.getSongsQuery().items?[indexPath.row].artist
        
        
        print(cell.musicsLabel.text)
        print(cell.albumImage.image)
        print(cell.artistsLabel.text)
        
        return cell
    }
}
