//
//  AudioController.swift
//  MMiOS
//
//  Created by Renato Nobre on 05/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import Foundation

class AudioController{
    
    
    private var playing = true

    
    func setPlaying(){
        self.playing = !self.playing
        print(self.playing)
    }
    
    func getPlaying() -> Bool{
        return self.playing
    }
    
    
}
