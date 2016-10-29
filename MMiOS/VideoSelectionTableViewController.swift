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

class VideoSelectionTableViewController: UITableViewController {

//    var videoController = VideoController()
    var videoModel = VideoModel()
    var videos: PHFetchResult<PHAsset>!
    @IBOutlet weak var videosLibrary: UILabel!
    var backgroundColor = ColorWeel()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 20


        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = backgroundColor.randomColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videoModel.getVideoAssets().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell
        
        //Thumbnail image
        let image = videoModel.getThumbnails()[indexPath.row]
        cell.videosThumbnail.image = image
        
        //Title label
        let creationdate = videoModel.getVideoAssets()[indexPath.row].creationDate?.dateValue
        let creationFormater = DateFormatter()
        creationFormater.dateFormat = "dd'/'MM'/'yyyy'-'HH':'mm':'ss"
        let creationString = creationFormater.string(from: creationdate!)
        cell.videoTitle.text = creationString
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let avAsset = videoModel.getVideoAssets()[indexPath.row]
        let myplayerItem = AVPlayerItem.init(asset: avAsset)
        let player = AVPlayer.init(playerItem: myplayerItem)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
