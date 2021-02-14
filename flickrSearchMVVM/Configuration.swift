//
//  Configuration.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 10/02/2021.
//

import Foundation

enum Defaults {
    
    static let method: String = "flickr.photos.search"
    static let searchTag = "Cordoba"
    static let APIScheme = "https"
    static let APIHost = "api.flickr.com"
    static let APIPath = "/services/rest"
    static let APIparameters = [
        "method" : "flickr.photos.search",
        "api_key" : "ee8d8fb07fd6a82f353150be4a2a7b74",
        "sort" : "relevance",
        "per_page" : "200",
        "format" : "json",
        "nojsoncallback" : "1",
        "extras" : "url_m"
    ]
}

enum FlickrService {
  
    private static let baseUrl = URL(string: "https://api.flickr.com/services/rest?extras=url_m&api_key=ee8d8fb07fd6a82f353150be4a2a7b74&method=flickr.photos.search&sort=relevance&format=json&per_page=20&nojsoncallback=1&page=1&text=Cordoba&tags=")!
    static var authenticatedBaseUrl: URL {
        return baseUrl
    }
}
 
