//
//  FlickrReponse.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 11/02/2021.
//

import Foundation

struct FlickrResponse: Codable {
    
    struct Photo: Codable {
        let photo: [Properties]
        
        struct Properties: Codable {
            let url_m: String
            let height_m: Int
            let width_m: Int
        }
        
    }
    
    let photos: Photo
}

extension FlickrResponse: FlickrData {
    var photo: [ListPhotos] {
        return photos.photo
    }
    
}

extension FlickrResponse.Photo.Properties: ListPhotos {
    
}
