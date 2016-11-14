//
//  VideoModel.swift
//  MMiOS
//
//  Created by William on 14/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import UIKit
import Photos


class VideoModel{
    var thumbnails = [UIImage]()
    var videos = [AVAsset]()

    enum ModelError: Error {
        case generateCopy
    }

    
    init() {
        self.phFetch()
    }
    /*
     * Pega asincronamente as thumbnails
     */
    func phFetch() {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let myVideos = PHAsset.fetchAssets(with: .video, options: options) as PHFetchResult<PHAsset>
        
        var count = 0
        while(count < myVideos.count){
            let phAsset = myVideos.object(at: count)
            PHImageManager.default().requestAVAsset(forVideo: phAsset, options: nil, resultHandler: { avAsset, audioMix, info in
                DispatchQueue.main.sync {
                    if((avAsset) != nil) {
                        //adicionando aos array de videos
                        self.videos.append(avAsset!)
                        
                        //adicionando a thumbnail ao array de thumbnail
                        let thumbnail = self.getVideoThumbnail(asset: avAsset!)
                        self.thumbnails.append(thumbnail)
                    }
                }
            })
            count += 1
        }
    }
    
    /*
     * Pega um avasset(video) e rotorna uma UIimage no meio do avasset
     */
    func getVideoThumbnail(asset : AVAsset) -> UIImage {
        var retirnedImage = UIImage()
        
        //Tempo do snapshot
        let duration = asset.duration
        let snapshot = CMTimeMakeWithSeconds(Float64((duration.value)/2), (duration.timescale))
        
        let generator = AVAssetImageGenerator.init(asset: asset)
        do {
            let imageRef = try generator.copyCGImage(at: snapshot, actualTime: nil)
            retirnedImage = UIImage.init(cgImage: imageRef)
        } catch ModelError.generateCopy {
            print("Generator on VideoModel class error")
        } catch {
            print("Unknown error")
        }
        
        
        return retirnedImage
    }
    
    
    func refreshSelfVideos(){
        self.phFetch()
    }
    /*
     * Interface para get dos videos
     */
    func getVideoAssets() -> [AVAsset] {
        return self.videos
    }
    
    func getVideoAssetsCount()->Int {
        return self.videos.count
    }
    /*
     * Interface para get das thumbnails
     */
    func getThumbnails() -> [UIImage] {
        return self.thumbnails
    }
}
