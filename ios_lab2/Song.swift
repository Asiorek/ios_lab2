//
//  Song.swift
//  ios_lab2
//
//  Created by macdt on 08/11/2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class Song {
    // MARK: Properities
    
    var title: String
    var artist: String
    var genre: String
    var year: Int
    var rating: Int
    
    
    init?(title: String, artist: String, genre: String, year: Int, rating: Int) {
        self.title = title
        self.artist = artist
        self.genre = genre
        self.year = year
        self.rating = rating
        
        if(self.rating > 5 || self.rating < 0) {
            return nil
        }
    }
    
    
    //class func convertToNSMutableArray(songs:[Song]) -> NSMutableArray {
     //   let albums:NSMutableArray = []
    //    for song in songs {
    //        let newSong = NSDictionary(dictionary: [
    //            "artist" : song.artist,
    //            "title" : song.title,
    //            "date" : song.year,
    //            "genre" : song.genre,
    //            "rating" : song.rating
    //            ])
   //         albums.addObject(newSong)
   //     }
   //     return albums
  //  }
}

