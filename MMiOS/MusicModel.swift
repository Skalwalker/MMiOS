//
//  MusicModel.swift
//  MMiOS
//
//  Created by Renato Nobre on 18/10/16.
//  Copyright © 2016 Roadway to SS. All rights reserved.
//

import Foundation
import UIKit

class Music{
    
    private let titulo: String
    private let album: UIImage
    private let artista: String
    
    
    init(titulo: String, album: UIImage, artista: String){
        self.titulo = titulo
        self.album = album
        self.artista = artista
    }
    
    func getTitulo() -> String{
        return self.titulo
    }
    
    func getAlbum() -> UIImage{
        return self.album
    }
    
    func getArtist() -> String{
        return self.artista
    }
}
