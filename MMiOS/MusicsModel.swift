//
//  MusicsModel.swift
//  MMiOS
//
//  Created by Renato Nobre on 12/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import Foundation
import MediaPlayer

class MusicsModel{
    
    private let albunsQuery: MPMediaQuery
    private let artistsQuery: MPMediaQuery
    private let songsQuery: MPMediaQuery
    private let playlistsQuery: MPMediaQuery
    
    init(){
        self.albunsQuery = MPMediaQuery.albums()
        self.artistsQuery = MPMediaQuery.artists()
        self.songsQuery = MPMediaQuery.songs()
        self.playlistsQuery = MPMediaQuery.playlists()
    }
    
    func getSongsQuery() -> MPMediaQuery{
        return songsQuery
    }
    
    func getArtistQuery() -> MPMediaQuery{
        return artistsQuery
    }
    
    func getAlbumQuery() -> MPMediaQuery{
        return albunsQuery
    }
    
    func getPlayListQuery() -> MPMediaQuery{
        return playlistsQuery
    }
    
    func printQuerry(){
        for item in songsQuery.items!{
            print(item.title)
        }
    }
}
