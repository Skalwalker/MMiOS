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
        
        if passedSegue == "playlists"{
            self.label.text = "Playlist Library"
        }
        else if passedSegue == "albums"{
            self.label.text = "Album Library"
        
        }
        else if passedSegue == "artists"{
            self.label.text = "Artist Library"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections    o bonde chegou eh os predador de perereca
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! Cell
        
        let query : MPMediaQuery
        
        if passedSegue == "playlists"{
            query = musics.getPlayListQuery()
            query.groupingType = MPMediaGrouping.playlist
        }
        else if passedSegue == "albums"{
            query = musics.getAlbumQuery()
            query.groupingType = MPMediaGrouping.album
        }
        else if passedSegue == "artists"{
            query = musics.getArtistQuery()
            query.groupingType = MPMediaGrouping.artist
        }
        
        
        return cell
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
