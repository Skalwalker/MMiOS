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
    private var lastMusic : [String]
    private var returns : Int
    
    init(){
        self.playing = MusicPlayer.playbackState == .playing
        self.lastMusic = [String]()
        returns = 0
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
    
    func checkForPlaying(){
        if getPlaying() == true{
            self.setPlaying()
        }
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
    
        model.setMusicQuery(music: musicsLabel)
        
        MusicPlayer.setQueue(with: model.getMusicQuery())
        
        MusicPlayer.prepareToPlay()
        
        self.play()
    }
    
    
    func playWithPlayList(musics : MPMediaItemCollection) {
        MusicPlayer.setQueue(with: musics)
        self.setPlaying()
        self.play()
    }
    
    func play(){
        self.setPlaying()
        MusicPlayer.play()
        
    }
    
    func skipMusic(){
        returns = 0
        lastMusic.append( (MusicPlayer.nowPlayingItem?.title)!)
        MusicPlayer.setQueue(with: model.getSongsQuery())
        MusicPlayer.skipToNextItem()
    }
    
    func returnMusic(){
        //MusicPlayer.skipToPreviousItem()
        self.playWithQueue(musics: model.getSongsQuery(), musicsLabel: lastMusic[lastMusic.count - returns - 1])
        returns = returns+1
    }
    
    func shuffleMode(){
        MusicPlayer.shuffleMode = .songs
    }
    
    func itemNowPlaying() -> MPMediaItem?{
        return MusicPlayer.nowPlayingItem
    }
}
