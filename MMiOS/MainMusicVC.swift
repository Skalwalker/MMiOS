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
    
    var backColor = ColorWeel()
    var controller = AudioController()
    var musics = MusicsModel()
    

//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
//        return UIInterfaceOrientationMask.portrait
//    }
//    
//    override var shouldAutorotate: Bool{
//        return false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        setColors()
        
        //This should not be here
        UITabBar.appearance().tintColor = UIColor.black
        
        //This is a default prop.
        playingMusicName.text = "Ain't No Rest For The Wicked"
        
        playingImageView.layer.cornerRadius = 10.0
        playingImageView.clipsToBounds = true
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
        hideBottomView()
        self.tableView.reloadData()
    }

    func hideBottomView(){
        print(controller.getPlaying())
        if(controller.getPlaying() == false){
            self.bottomView.isHidden = true
            self.buttonToPlaying.isEnabled = false
        } else {
            self.bottomView.isHidden = false
            self.buttonToPlaying.isEnabled = true
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
        cell.albumName = (self.musics.getAlbumQuery().items?[indexPath.row].albumArtist)!
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! Cell
        
        
        controller.playWithQueue(musics: musics.getSongsQuery(), musicsLabel: cell.musicsLabel.text!)
        
        playingMusicName.text = cell.musicsLabel.text
        playingImageView.image = cell.albumImage.image
        
        hideBottomView()
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
        }
    }
}
