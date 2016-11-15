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
    private let musicQuery: MPMediaQuery
    
    init(){
        self.albunsQuery = MPMediaQuery.albums()
        self.albunsQuery.groupingType = MPMediaGrouping.album
        self.artistsQuery = MPMediaQuery.artists()
        self.artistsQuery.groupingType = MPMediaGrouping.artist
        self.songsQuery = MPMediaQuery.songs()
        self.playlistsQuery = MPMediaQuery.playlists()
        self.musicQuery = MPMediaQuery.songs()
    }
    
    func getSongsQuery() -> MPMediaQuery{
        return songsQuery
    }
    
    func getMusicQuery() -> MPMediaQuery{
        return musicQuery
    }

    func setMusicQuery(music : String){
        
        if (musicQuery.filterPredicates?.count)! > 0{
            for fpredicate in musicQuery.filterPredicates!{
                musicQuery.removeFilterPredicate(fpredicate)
            }
            
        }
        
        let predicate = MPMediaPropertyPredicate.init(value: music, forProperty: "title")
        musicQuery.addFilterPredicate(predicate);
        
    }

    
    func getSong() -> MPMediaItem{
        return (songsQuery.items?.first)!
    }
    
    func getSongQueryCount() -> Int{
        if songsQuery.items == nil{
            return 0
        }
        
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
    
    func getAlbumsCount() -> Int{
        return (albunsQuery.collections?.count)!
    }
    
    func getArtistsCount() -> Int{
        return (artistsQuery.collections?.count)!
    }
    
    func getPlaylistCount() -> Int{
        return (playlistsQuery.collections?.count)!
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
