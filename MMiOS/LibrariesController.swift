//
//  LibrariesController.swift
//  MMiOS
//
//  Created by Renato Nobre on 08/11/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import MediaPlayer

class LibrariesController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var playingImageView: UIImageView!
    @IBOutlet weak var playingMusicName: UILabel!
    @IBOutlet weak var playOrPause: UIButton!
    @IBOutlet weak var buttonToPlaying: UIButton!
    
    var backColor = ColorWeel()
    var controller = AudioController()
    var musics = MusicsModel()
    var passedSegue: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.backgroundColor = backColor.fixedColor()
        self.label.textColor = UIColor.white
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if passedSegue == "playlists"{
            self.label.text = "Playlist Library"
        }
        else if passedSegue == "albums"{
            self.label.text = "Album Library"
        
        }
        else if passedSegue == "artists"{
            self.label.text = "Artist Library"
        }
        let music = controller.itemNowPlaying()
        let size = CGSize.init(width: 52.0, height: 52.0)
        self.playingImageView.image = music?.artwork?.image(at: size)
        self.playingMusicName.text = music?.title
        
        self.tableView.reloadData()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if passedSegue == "playlists"{
            return musics.getPlaylistCount(section: section)
        }
        else if passedSegue == "albums"{
            return musics.getAlbumsCount(section: section)
        }
        else if passedSegue == "artists"{
            return musics.getArtistsCount(section: section)
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if passedSegue == "playlists"{
            return musics.getPlaylistsSections()
        }
        else if passedSegue == "albums"{
            return musics.getAlbumsSections()
        }
        else if passedSegue == "artists"{
            return musics.getArtistsSections()
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let size = CGSize.init(width: 52.0, height: 52.0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenericCell", for: indexPath) as! GenericCell
        
        var query : MPMediaQuery = musics.getSongsQuery()
        
        if passedSegue == "playlists"{
            query = musics.getPlayListQuery()
        }
        else if passedSegue == "albums"{
            query = musics.getAlbumQuery()
        }
        else if passedSegue == "artists"{
            query = musics.getArtistQuery()
        }
        let loc = query.collectionSections![indexPath.section].range.location
        let item = query.collections![indexPath.row + loc]
        
        
        if passedSegue == "playlists"{
            cell.myLabel.text = item.items[0].title
        }
        else if passedSegue == "albums"{
            cell.myLabel.text = item.items[0].albumTitle
        }
        else if passedSegue == "artists"{
            cell.myLabel.text = item.items[0].artist
        }

        cell.myImage.image = item.representativeItem?.artwork?.image(at: size)
        
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var query : MPMediaQuery = musics.getPlayListQuery()
        
        if passedSegue == "playlists"{
            query = musics.getPlayListQuery()
        }
        else if passedSegue == "albums"{
            query = musics.getAlbumQuery()
        }
        else if passedSegue == "artists"{
            query = musics.getArtistQuery()
        }
        
        let loc = query.collectionSections![indexPath.section].range.location
        controller.playWithPlayList(musics: query.collections![indexPath.row + loc])
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
