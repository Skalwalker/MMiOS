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
    
    private var playing = false

    func getPlaying() -> Bool{
        return MusicPlayer.playbackState == .playing
    }
    
    private func setPlaying(){
        playing = true
        print(self.playing)
    }
    
    func pausePlaying(){
        playing = false
        MusicPlayer.pause()
    }
    
    func setQueue(musics: MPMediaQuery){
        return MusicPlayer.setQueue(with: musics)
    }
    
    func playWithQueue(musics :MPMediaQuery, musicsLabel: String){
        self.setPlaying()
        MusicPlayer.stop()
        for item in model.getSongsQuery().items!{
            if item.title == musicsLabel{
                MusicPlayer.nowPlayingItem = item
                break
            }
        }
        
        MusicPlayer.prepareToPlay()
        MusicPlayer.play()
    }
    
    
    func playWithPlayList(musics : MPMediaItemCollection) {
        self.setPlaying()
        MusicPlayer.setQueue(with: musics)
        MusicPlayer.play()
    }
    
    func play(){
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
