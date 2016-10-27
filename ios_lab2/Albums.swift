//
//  AlbumSingleton.swift
//  ios_lab2
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import Foundation

class AlbumSingleton{
    static let sharedInstance = AlbumSingleton()
        private init(){}
        
        var Albums = [Album]()
}

class Album{
    var title: String = ""
}
