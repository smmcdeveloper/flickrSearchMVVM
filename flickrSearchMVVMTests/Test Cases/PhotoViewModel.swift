//
//  PhotoViewModel.swift
//  flickrSearchMVVMTests
//
//  Created by SMMC on 13/02/2021.
//

import XCTest
@testable import flickrSearchMVVM

class PhotoViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var viewModel: PhotoViewModel!
    
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
        viewModel = PhotoViewModel(flickrData: flickrResponse.photo[0])
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests for Day
    
    func testHeight() {
        XCTAssertEqual(viewModel.height_m, 324)
    }
    
    func testWidth() {
        XCTAssertEqual(viewModel.width_m, 500)
    }
    
    func testImageUrl() {
        XCTAssertEqual(viewModel.url_m, "https://live.staticflickr.com/1490/23644597384_cdb57efb22.jpg")
    }
}
