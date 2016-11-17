//
//  CustomPlayerVC.swift
//  MMiOS
//
//  Created by William on 11/11/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import AVKit
import Photos

class CustomPlayerVC: AVPlayerViewController {
    

    init(mUrl : URL) {
        super.init(nibName: nil, bundle: nil)
        let player = AVPlayer.init(url: mUrl)
        self.player = player
    }
    
    init(indexPath : IndexPath) {
        super.init(nibName: nil, bundle: nil)
        let avAsset = VideoModel.sharedInstance.getVideoAssets()[indexPath.row]
        let myplayerItem = AVPlayerItem.init(asset: avAsset)
        let player = AVPlayer.init(playerItem: myplayerItem)
        self.player = player
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.player?.play()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
