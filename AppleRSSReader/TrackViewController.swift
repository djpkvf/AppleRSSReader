//
//  TrackViewController.swift
//  AppleRSSReader
//
//  Created by Dominic Pilla on 10/23/17.
//  Copyright © 2017 Dominic Pilla. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genreList: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var track: Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let track = track {
            self.title = track.name
            albumImage.image = track.albumArtwork
            albumName.text = track.name
            artistName.text = "by \(track.artistName)"
            
            let date: String = dateConverter(track.releaseDate, "MMMM dd, yyyy")
            
            releaseDate.text = "Release date: \(date)"
            
            for genre in track.genres {
                genreList.text = genreList.text! + " " + genre.name
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dateConverter(_ dateString: String, _ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        if let date = date {
            dateFormatter.dateFormat = dateFormat
            return dateFormatter.string(from: date)
        }
        return ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
