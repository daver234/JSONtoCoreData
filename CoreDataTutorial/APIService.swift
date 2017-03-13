//
//  APIService.swift
//  CoreDataTutorial
//
//  Created by David Rothschild on 3/12/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import UIKit

// Enum with associated values and constrained to a generic type
enum Result <T>{
    case Success(T)
    case Error(String)
}

class APIService: NSObject {
    
    let query = "dogs"
    
    // end point from Flicker API
    lazy var endPoint: String = {
        return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(self.query)&nojsoncallback=1#"
    }()
    
    // Note the enum is being passed as the argument
    func getDataWith(completion: @escaping (Result<[[String: AnyObject]]>) -> Void) {
        guard let url = URL(string:endPoint ) else {
            return completion(.Error("Invalid URL, we can't update your feed"))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else { return completion(.Error(error!.localizedDescription)) }
            guard let data = data else { return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    guard let itemsJsonArray = json["items"] as? [[String: AnyObject]] else {
                        return completion(.Error(error?.localizedDescription ?? "There are no new Items to show"))
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemsJsonArray))
                    }
                }
            } catch let error {
                return completion(.Error(error.localizedDescription))
            }
            }.resume()
    }
}
