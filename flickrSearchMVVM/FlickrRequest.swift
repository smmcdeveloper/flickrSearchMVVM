//
//  FlickrRequest.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 10/02/2021.
//

import Foundation

struct FlickrRequest {
    
    let baseUrl: URL
    let searchTag: String
    
    var searchTab: String {
        return searchTag
    }
    
    var url: URL {
        
        var urlString = "https://api.flickr.com/services/rest?extras=url_m&api_key=ee8d8fb07fd6a82f353150be4a2a7b74&method=flickr.photos.search&sort=relevance&format=json&per_page=200&nojsoncallback=1&page=1&tags="
        urlString.append(searchTag)
       
        return URL(string:urlString)!
    }
}
