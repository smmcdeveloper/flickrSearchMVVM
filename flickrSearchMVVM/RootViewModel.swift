//
//  RootViewModel.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 10/02/2021.
//

import Foundation

class RootViewModel {
    
    enum FlickrDataError: Error {
        case noFlickrDataAvailable
    }
    
    // MARK: - Type Aliases
    
    typealias DidFetchFlickrDataCompletion = (FlickrData?, FlickrDataError?) -> Void
    
    // MARK: - Properties
    
    var didFetchFlickrData: DidFetchFlickrDataCompletion?
    
    init() {
        
        fetchFlickrData(for: Defaults.searchTag)
    }
    
    // MARK: -
    
    func fetchFlickrData(for Text: String) {
        // Initialize Flickr Request
        let flickrRequest = FlickrRequest(baseUrl: FlickrService.authenticatedBaseUrl, searchTag: Text)

        // Create Data Task
        URLSession.shared.dataTask(with: flickrRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            DispatchQueue.main.async {
                
              if let error = error {
                print("Unable to Fetch Flickr Data \(error)")
                
                self?.didFetchFlickrData?(nil, .noFlickrDataAvailable)
              } else if let data = data {
                  //  Initialize JSON Decoder
                  let decoder = JSONDecoder()
                
                  do {
                    // Decode JSON Response
                    let flickrResponse = try decoder.decode(FlickrResponse.self, from: data)
                  
                    // Invoke Completion Handler
                    self?.didFetchFlickrData?(flickrResponse, nil)
                   } catch {
                    print("Unable to Decode JSON Response \(error)")
                    
                    self?.didFetchFlickrData?(nil, .noFlickrDataAvailable)
                   }

            } else {
                   self?.didFetchFlickrData?(nil, .noFlickrDataAvailable)
              }
            }
        }.resume()
    }
}
