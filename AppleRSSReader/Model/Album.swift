//
//  Album.swift
//  AppleRSSReader
//
//  Created by Dominic Pilla on 10/17/17.
//  Copyright © 2017 Dominic Pilla. All rights reserved.
//

import Foundation

struct Album {
    let title: String
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case feed
    }
    
    enum FeedKeys: String, CodingKey {
        case title, results
    }
    
    enum TrackKeys: String, CodingKey {
        case artistName, artworkUrl100, genres, name, releaseDate
    }
    
    enum GenreKeys: String, CodingKey {
        case name
    }
}

extension Album: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let feed = try values.nestedContainer(keyedBy: FeedKeys.self, forKey: .feed)
        self.title = try feed.decode(String.self, forKey: .title)
        self.tracks = try feed.decode([Track].self, forKey: .results)
    }
}
