//
//  PhotoViewModelTests.swift
//  flickrSearchMVVMTests
//
//  Created by SMMC on 13/02/2021.
//

import XCTest
@testable import flickrSearchMVVM

class ListViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: ListViewModel!
    
    // MARK: - Set Up & Tear Down
    
    override func setUp() {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "data", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()
        
        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970
        
        // Initialize Flickr Response
        let flickrResponse = try! decoder.decode(FlickrResponse.self, from: data)
        
        // Initialize View Model
        viewModel = ListViewModel(flickrData: flickrResponse.photo)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests for Number of Items
    
    func testNumberOfItems() {
        XCTAssertEqual(viewModel.numberOfItems, 20)
    }
    
    // MARK: - Tests for View Model for Index
    
    func testViewModelForIndex() {
        let photoViewModel = viewModel.viewModel(for: 0)
        
        XCTAssertEqual(photoViewModel.height_m, 324)
        
        XCTAssertEqual(photoViewModel.width_m, 500)
        
        XCTAssertEqual(photoViewModel.url_m, "https://live.staticflickr.com/1490/23644597384_cdb57efb22.jpg")
    }
}
