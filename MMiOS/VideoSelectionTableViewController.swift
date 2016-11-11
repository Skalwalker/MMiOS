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

class VideoSelectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentMenuDelegate {

//    var videoController = VideoController()
    var videoModel = VideoModel()
    var videos: PHFetchResult<PHAsset>!
    @IBOutlet weak var videosLibrary: UILabel!
    var backgroundColor = ColorWeel()
    @IBOutlet weak var tableView: UITableView!
    @IBAction func streamAction(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Informe a URL da streaming", message: "", preferredStyle: .alert)
        //cancel action
        let cancelAction = UIAlertAction.init(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        //Playaction
        let streamURLaction = UIAlertAction(title:"Play", style: .default) { (_) in
            let urlTextField = alertController.textFields![0] as UITextField
            let player = AVPlayer.init(url: URL.init(string: urlTextField.text!)!)
            let playerViewController = CustomPlayerVC()
            
            playerViewController.player = player
            self.present(playerViewController, animated: true, completion: {
                playerViewController.player?.play()
            })
        }
        streamURLaction.isEnabled = false

        //adding textfield
        alertController.addTextField { (textfield : UITextField) in
            textfield.placeholder = "http//...."
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: textfield, queue: OperationQueue.main) { (notification) in
                //habilitando o streaming action
                streamURLaction.isEnabled = textfield.text != ""
            }
        }
        
        alertController.addAction(streamURLaction)
        self.present(alertController, animated: true, completion: nil)

        
        
        
        
    }
    @IBAction func Import(_ sender: AnyObject) {
//        NSArray *types = [(NSString*)kUTTypeImage,(NSString*)kUTTypeSpreadsheet,(NSString*)kUTTypePresentation,(NSString*)kUTTypeDatabase,(NSString*)kUTTypeFolder,(NSString*)kUTTypeZipArchive,(NSString*)kUTTypeVideo];

        let documentVC = UIDocumentMenuViewController.init(documentTypes: ["com.apple.quicktime-movie"], in: .import)
        documentVC.delegate = self
        self.present(documentVC, animated: true, completion: nil)
    }

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
        //deselect
        tableView.deselectRow(at: indexPath, animated: true)

        
        let avAsset = videoModel.getVideoAssets()[indexPath.row]
        let myplayerItem = AVPlayerItem.init(asset: avAsset)
        let player = AVPlayer.init(playerItem: myplayerItem)
        let playerViewController = AVPlayerViewController()
        
        playerViewController.player = player
        self.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
    
    //document menu protocol
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
    }
    
    func documentMenuWasCancelled(_ documentMenu: UIDocumentMenuViewController) {
    
    }
}
