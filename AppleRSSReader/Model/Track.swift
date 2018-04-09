//
//  Track.swift
//  AppleRSSReader
//
//  Created by Dominic Pilla on 10/17/17.
//  Copyright © 2017 Dominic Pilla. All rights reserved.
//

import Foundation
import UIKit

struct Track {
    let artistName: String
    var albumArtwork: UIImage? = nil
    let artworkUrl100: URL
    let genres: [Genre]
    let name: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case artistName, artworkUrl100, genres, name, releaseDate
    }
}

extension Track: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.artistName = try values.decode(String.self, forKey: .artistName)
        self.artworkUrl100 = try values.decode(URL.self, forKey: .artworkUrl100)
        self.genres = try values.decode([Genre].self, forKey: .genres)
        self.name = try values.decode(String.self, forKey: .name)
        self.releaseDate = try values.decode(String.self, forKey: .releaseDate)
        do {
            let albumArtwork: Data = try Data(contentsOf: self.artworkUrl100)
            self.albumArtwork = UIImage(data: albumArtwork)!
        } catch {
            print(error)
        }
    }
}
