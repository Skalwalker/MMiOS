//
//  MainMusicVC.swift
//  MMiOS
//
//  Created by Renato Nobre on 29/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit

class MainMusicVC: UIViewController{

    @IBOutlet weak var playingMusicName: UILabel!
    @IBOutlet weak var libraryLabel: UILabel!
    @IBOutlet weak var albunsButton: UIButton!
   
    @IBOutlet weak var artistsButton: UIButton!
    @IBOutlet weak var playlistsButton: UIButton!
    @IBOutlet weak var buttonToPlaying: UIButton!
    
    @IBOutlet weak var musicTV: UITableView!
    
    var backColor = ColorWeel()
    var controller = AudioController()
    var musics = MusicsModel()
    var music = [Music]()
    
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColors()
        
        //This should not be here
        UITabBar.appearance().tintColor = UIColor.black
        
        //This is a default prop.
        playingMusicName.text = "Ain't No Rest For The Wicked"
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = backColor.randomColor()
        musics.printQuerry()
        hideBottomView()
        loadMusics()
      
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
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            blurEffectView.frame = self.bottomView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return musics.getSongQueryCount()
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
//        let musicCell = self.music[indexPath.row]
//   
//        // Configure the cell...
//        cell.musicsLabel.text = musicCell.getTitulo()
//        cell.albumImage.image = musicCell.getAlbum()
//        cell.artistsLabel.text = musicCell.getArtist()
//        
//        return cell
//    }
//    
//    func loadMusics(){
//        
//        let size = CGSize.init(width: 52.0, height: 52.0)
//
//        
//        for item in musics.getSongsQuery().items!{
//            let music = Music.init(titulo: item.title!, album: (item.artwork?.image(at: size))!, artista: item.artist!)
//            self.music += [music]
//        }
//    }
}
