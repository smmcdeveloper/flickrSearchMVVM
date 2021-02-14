//
//  FlickrData.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 11/02/2021.
//

import Foundation

protocol FlickrData {

    var photo: [ListPhotos] { get }
    
}

protocol ListPhotos {
    
    var url_m: String { get }
    var height_m: Int { get }
    var width_m: Int { get }

}
