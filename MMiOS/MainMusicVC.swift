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
    @IBOutlet weak var playingImageView: UIImageView!
   
    @IBOutlet weak var playOrPause: UIButton!
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var playlistsButton: UIButton!
    @IBOutlet weak var buttonToPlaying: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var songsLabel: UILabel!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorMsg: UILabel!
    
    
    var backColor = ColorWeel()
    var controller = AudioController()
    var musics = MusicsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor.fixedColor()
        setColors()
        hideBottomView()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        

    
        //This should not be here
        UITabBar.appearance().tintColor = UIColor.black
        
        
        playingImageView.layer.cornerRadius = 10.0
        playingImageView.clipsToBounds = true
        
        
        
        if (tableView.numberOfRows(inSection: 0) == 0){
            blurMainView()
        }
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let music = controller.itemNowPlaying()
        let size = CGSize.init(width: 52.0, height: 52.0)
        self.playingImageView.image = music?.artwork?.image(at: size)
        self.playingMusicName.text = music?.title
        
        controller.checkForPlaying()
        hideBottomView()
        
        self.tableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: AnyObject) {
        self.tableView.reloadData()
        
        if (tableView.numberOfRows(inSection: 0) != 0){
            errorView.isHidden = true
        }
    }
      
    func hideBottomView(){
        if(controller.getLocalPlaying() == false){
            self.bottomView.isHidden = true
            self.buttonToPlaying.isEnabled = false
        } else {
            self.bottomView.isHidden = false
            self.buttonToPlaying.isEnabled = true
        }
    }
    
    func setColors(){
        
        let buttons = [artistsButton, albunsButton, playlistsButton]
        let labels = [playingMusicName, libraryLabel, songsLabel]
        
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
    
    func blurMainView(){
        if !UIAccessibilityIsReduceTransparencyEnabled(){
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = self.errorView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.errorView.addSubview(blurEffectView)
            self.view.bringSubview(toFront: errorView)
            self.errorView.sendSubview(toBack: blurEffectView)
            
            errorMsg.isHidden = false
            errorTitle.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if musics.getSongQueryCount() == 0{
            return 0;
        }
        
        errorView.isHidden = true
        
        return musics.getSongQueryCount() + 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! Cell
        let size = CGSize.init(width: 52.0, height: 52.0)
        
        
        if (indexPath.row + 1) > (self.musics.getAlbumQuery().items?.count)!{
            cell.musicsLabel.text = ""
            cell.albumImage.image = nil
            cell.artistsLabel.text = ""
            cell.albumName = ""
        } else {
            cell.musicsLabel.text = self.musics.getSongsQuery().items?[indexPath.row].title
            cell.albumImage.image = self.musics.getSongsQuery().items?[indexPath.row].artwork?.image(at: size)
            cell.artistsLabel.text = self.musics.getSongsQuery().items?[indexPath.row].artist
            cell.albumName = (self.musics.getAlbumQuery().items?[indexPath.row].albumArtist)!
            
           
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! Cell
        
        if (indexPath.row + 1) < (self.musics.getAlbumQuery().items?.count)!{
            controller.playWithQueue(musics: musics.getSongsQuery(), musicsLabel: cell.musicsLabel.text!)
            
            playingMusicName.text = cell.musicsLabel.text
            playingImageView.image = cell.albumImage.image
            
            hideBottomView()
        }
     
    }

    
    @IBAction func playOrPause(_ sender: AnyObject) {
        if(controller.getPlaying()){
            controller.pausePlaying()
            playOrPause.setImage(#imageLiteral(resourceName: "Play"), for: .normal)
        } else {
            controller.play()
            playOrPause.setImage(#imageLiteral(resourceName: "Pause"), for: .normal)

        }
        
    }
    
    @IBAction func nextMusic(_ sender: AnyObject) {
        controller.skipMusic()
        let music = controller.itemNowPlaying()
        let size = CGSize.init(width: 52.0, height: 52.0)
        
        playingMusicName.text = music?.title
        playingImageView.image = music?.artwork?.image(at: size)
        
    }
    
    @IBAction func triggerSegue(_ sender: AnyObject) {
        performSegue(withIdentifier: "PlayingMusic", sender: sender)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let music = controller.itemNowPlaying()
        
        if(segue.identifier == "PlayingMusic"){
            let vc = segue.destination as! PlayingMusicVC
            let size = CGSize.init(width: 240.0, height: 240.0)
            
            vc.passedArtistName = (music?.albumArtist)!
            vc.passedAlbumName = (music?.albumTitle)!
            vc.passedMusicName = (music?.title)!
            vc.passedImage = (music?.artwork?.image(at: size))!
        } else {
            let vc = segue.destination as! LibrariesController
            
            if(segue.identifier == "playlists"){
                vc.passedSegue = "playlists"
            } else if(segue.identifier == "albums"){
                vc.passedSegue = "albums"
            } else if(segue.identifier == "artists"){
                vc.passedSegue = "artists"
            }
        }
        
       
    }
}
