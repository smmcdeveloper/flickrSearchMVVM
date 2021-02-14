//
//  ListViewModel.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 12/02/2021.
//

import Foundation

struct ListViewModel {
    
    // MARK: - Properties
    
    let flickrData: [ListPhotos]
        
    var numberOfItems: Int {
        return flickrData.count
    }
    
    // MARK:- Methods
    
    func viewModel(for index: Int) -> PhotoViewModel {
        
        return PhotoViewModel(flickrData: flickrData[index])
    }

}
