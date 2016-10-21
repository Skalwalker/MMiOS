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
    
    
    let MusicPlayer = MPMusicPlayerController()
    
    private var playing = false

    
    func setPlaying(){
        playing = true
        print(self.playing)
    }
    
    func pausePlaying(){
        playing = false
        MusicPlayer.pause()
    }
    
    func playWithQueue(musics :MPMediaQuery){
        self.setPlaying()
        MusicPlayer.setQueue(with: musics)
        MusicPlayer.play()
    }
    
    func playWithPlayList(musics : MPMediaItemCollection) {
        self.setPlaying()
        MusicPlayer.setQueue(with: musics)
        MusicPlayer.play()
    }
    
    func skipMusic(){
        MusicPlayer.skipToNextItem()
    }
    
    func returnMusic(){
        MusicPlayer.skipToPreviousItem()
    }
    
    func getPlaying() -> Bool{
        return MusicPlayer.playbackState == .playing
    }
    
    func shuffleMode(){
        MusicPlayer.shuffleMode = .songs
    }
    
    func itemNowPlaying() -> MPMediaItem?{
        return MusicPlayer.nowPlayingItem
    }
    
    
    
}
