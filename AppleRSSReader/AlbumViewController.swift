//
//  AlbumViewController.swift
//  AppleRSSReader
//
//  Created by Dominic Pilla on 10/19/17.
//  Copyright © 2017 Dominic Pilla. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var albumTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var tracks: [Track] = []
    let queryService = QueryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
        queryService.getSearchResults { album, errorMessage in
            self.tracks = album.tracks
            self.title = album.title
            self.albumTableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicator.stopAnimating()
            if !errorMessage.isEmpty {
                let alert = UIAlertController(title: "Alert", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Clear tableview selection when going back
        if let selectionIndexPath = albumTableView.indexPathForSelectedRow {
            albumTableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumTableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumTableViewCell
        
        if let albumArtwork = tracks[indexPath.row].albumArtwork {
            cell.albumImage.image = albumArtwork
            cell.albumName.text = tracks[indexPath.row].name
            cell.artistName.text = tracks[indexPath.row].artistName
        }
        
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TrackViewController,
            let row = albumTableView.indexPathForSelectedRow?.row {
            
            destination.track = tracks[row]
        }
    }
    

}
