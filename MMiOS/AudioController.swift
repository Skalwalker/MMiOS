//
//  AudioController.swift
//  MMiOS
//
//  Created by Renato Nobre on 05/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import Foundation
import MediaPlayer

class AudioController{
    
    let model = MusicsModel()
    let cell = Cell()
    let MusicPlayer = MPMusicPlayerController()
    
    private var playing: Bool
    
    init(){
        self.playing = MusicPlayer.playbackState == .playing
    }

    func getPlaying() -> Bool{
        return MusicPlayer.playbackState == .playing
    }
    
    func getLocalPlaying() -> Bool{
        return self.playing
    }
    
    private func setPlaying(){
        self.playing = true
    }
    
    func pausePlaying(){
        MusicPlayer.pause()
        playing = false
       
    }
    
    func setQueue(musics: MPMediaQuery){
        return MusicPlayer.setQueue(with: musics)
    }
    
    func playWithQueue(musics :MPMediaQuery, musicsLabel: String){
        MusicPlayer.stop()
        
        if (musics.filterPredicates?.count)! > 0{
            for fpredicate in musics.filterPredicates!{
                musics.removeFilterPredicate(fpredicate)
            }
            
        }
        
        let predicate = MPMediaPropertyPredicate.init(value: musicsLabel, forProperty: "title")
        musics.addFilterPredicate(predicate);
        
        MusicPlayer.setQueue(with: musics);
        
        MusicPlayer.prepareToPlay();
        
        self.play()
    }
    
    
    func playWithPlayList(musics : MPMediaItemCollection) {
        MusicPlayer.setQueue(with: musics)
        self.play()
    }
    
    func play(){
        self.setPlaying()
        MusicPlayer.play()
        
    }
    
    func skipMusic(){
        MusicPlayer.skipToNextItem()
    }
    
    func returnMusic(){
        MusicPlayer.skipToPreviousItem()
    }
    
    func shuffleMode(){
        MusicPlayer.shuffleMode = .songs
    }
    
    func itemNowPlaying() -> MPMediaItem?{
        return MusicPlayer.nowPlayingItem
    }
}
