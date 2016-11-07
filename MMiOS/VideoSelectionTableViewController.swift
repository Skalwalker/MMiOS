//
//  VideoSelectionTableViewController.swift
//  MMiOS
//
//  Created by William on 28/09/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import Photos
import AVKit

class VideoSelectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var videoController = VideoController()
    var videoModel = VideoModel()
    var videos: PHFetchResult<PHAsset>!
    @IBOutlet weak var videosLibrary: UILabel!
    var backgroundColor = ColorWeel()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor.fixedColor()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        videosLibrary.textColor = UIColor.white
        
        self.tableView.reloadData()
        tableView.contentInset.top = 20


        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videoModel.getVideoAssets().count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell

        //Thumbnail image
        let image = videoModel.getThumbnails()[indexPath.row]
        cell.videosThumbnail.image = image
        
        //Title label
        let creationdate = videoModel.getVideoAssets()[indexPath.row].creationDate?.dateValue
        if creationdate == nil{
           print("ayy")
            cell.videoTitle.text = "This is default."
        } else {
            let creationFormater = DateFormatter()
            creationFormater.dateFormat = "dd'/'MM'/'yyyy'-'HH':'mm':'ss"
            let creationString = creationFormater.string(from: creationdate!)
            cell.videoTitle.text = creationString
        }
    
        //Duration label
        let durationInSeconds = ceil(videoModel.getVideoAssets()[indexPath.row].duration.seconds)
        cell.videoDuration.text = stringFromTimeInterval(interval: durationInSeconds)
        
        
        return cell
    }
    
    func stringFromTimeInterval(interval: Double) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let avAsset = videoModel.getVideoAssets()[indexPath.row]
        let myplayerItem = AVPlayerItem.init(asset: avAsset)
        let player = AVPlayer.init(playerItem: myplayerItem)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
}
