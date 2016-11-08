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
        self.albunsQuery.groupingType = MPMediaGrouping.album
        self.artistsQuery = MPMediaQuery.artists()
        self.artistsQuery.groupingType = MPMediaGrouping.artist
        
        self.songsQuery = MPMediaQuery.songs()
        self.playlistsQuery = MPMediaQuery.playlists()
        self.playlistsQuery.groupingType = MPMediaGrouping.playlist
    
    }
    
    func getSongsQuery() -> MPMediaQuery{
        return songsQuery
    }
    
    func getSong() -> MPMediaItem{
        return (songsQuery.items?.first)!
    }
    
    func getSongQueryCount() -> Int{
        return (songsQuery.items?.count)!
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
    
    func getAlbumsCount(section : Int) -> Int{
        return albunsQuery.collectionSections![section].range.length
    }
    
    func getArtistsCount(section : Int) -> Int{
        return artistsQuery.collectionSections![section].range.length
    }
    
    func getPlaylistCount(section : Int) -> Int{
        return playlistsQuery.collectionSections![section].range.length
    }
    
    func getAlbumsSections() -> Int{
        return (albunsQuery.itemSections?.count)!
    }
    
    func getArtistsSections() -> Int{
        return (artistsQuery.itemSections?.count)!
    }

    func getPlaylistsSections() -> Int{
        return (playlistsQuery.itemSections?.count)!
    }

}
