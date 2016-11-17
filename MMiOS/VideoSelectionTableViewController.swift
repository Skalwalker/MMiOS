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

class VideoSelectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIDocumentMenuDelegate, UIDocumentPickerDelegate {

    //var videoController = VideoController()
    var backgroundColor = ColorWeel()
    var videos: PHFetchResult<PHAsset>!
    var videoModel = VideoModel.sharedInstance

    
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var videosLibrary: UILabel!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorText: UILabel!
    @IBOutlet weak var errorTitlee: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func streamAction(_ sender: AnyObject) {
        StreamingFeature.init(viewController: self).importFunc()

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
        refreshButton.isHidden = true
        tableView.contentInset.top = 20
        
        if(tableView.numberOfRows(inSection: 0) == 0){
            blurMainView()
        } else {
            errorView.isHidden = false
        }


        tableView.reloadData()
    }
    
    @IBAction func refresh(_ sender: AnyObject) {
        
        VideoModel.sharedInstance.refreshSelfVideos()
        
        
        self.tableView.reloadData()
        
        
        print(VideoModel.sharedInstance.getVideoAssetsCount())
        
        if(tableView.numberOfRows(inSection: 0) != 0){
            errorView.isHidden = true
        }
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
        // #warning Incomplete implementation, return the number of row
        
        return VideoModel.sharedInstance.getVideoAssetsCount()
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
            
            errorText.isHidden = false
            errorTitlee.isHidden = false
            refreshButton.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: VideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell
        //Thumbnail image
        let image = VideoModel.sharedInstance.getThumbnails()[indexPath.row]
        cell.videosThumbnail.image = image
        
        //Title label
        let creationdate = VideoModel.sharedInstance.getVideoAssets()[indexPath.row].creationDate?.dateValue
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
        let durationInSeconds = ceil(VideoModel.sharedInstance.getVideoAssets()[indexPath.row].duration.seconds)
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
        let playerViewController = CustomPlayerVC.init(indexPath: indexPath)
        self.present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
    
    //document menu protocol
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    //document picker protocol
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        let playerViewController = CustomPlayerVC.init(mUrl: url)
        self.present(playerViewController, animated: true, completion: nil)
    }
}
