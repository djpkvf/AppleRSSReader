//
//  QueryRSS.swift
//  AppleRSSReader
//
//  Created by Dominic Pilla on 10/15/17.
//  Copyright © 2017 Dominic Pilla. All rights reserved.
//

import Foundation
import UIKit

class QueryService {
    typealias QueryResult = (Album, String) -> ()
    
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func getSearchResults(completion: @escaping QueryResult) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json") {
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    print("DataTask error: " + error.localizedDescription + "\n")
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    do {
                        let album = try JSONDecoder().decode(Album.self, from: data)

                        DispatchQueue.main.async {
                            completion(album, self.errorMessage)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            dataTask?.resume()
        }
    }
}
