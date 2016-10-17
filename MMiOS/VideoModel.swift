//
//  VideoModel.swift
//  MMiOS
//
//  Created by William on 14/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import Photos

private var someInts = [AVAsset]()

class VideoModel {
    
    init() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
//        var videos = PHAsset.fetchAssets(with: .video, options: options) as PHFetchResult
//        let count  = videos.count
//        let manager = PHImageManager.defaultManager()
//        MAP_MEM_IO
    }
}
