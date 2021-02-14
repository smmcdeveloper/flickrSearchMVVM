//
//  PhotoViewModel.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 13/02/2021.
//

import Foundation

struct PhotoViewModel {
    
    // MARK: - Properties
    let flickrData: ListPhotos
    
    var height_m: Int {
        return flickrData.height_m
    }
    
    var width_m: Int {
        return flickrData.width_m
    }
    
    var url_m: String {
        return flickrData.url_m
    }
    
}

extension PhotoViewModel: PhotoRepresentable {
    
}
