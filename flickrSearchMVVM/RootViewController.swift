//
//  RootViewController.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 08/02/2021.
//

import UIKit

class RootViewController: UIViewController{
    
    private enum alertType {
        case noFlickrDataAvailable
    }
    
    // MARK: - Properties
     
    @IBOutlet weak var navigationBar: UINavigationBar! {
        didSet {
            self.navigationBar.topItem?.title = Defaults.searchTag
        }
    }
    
    @IBOutlet weak var photoSearchBar: UISearchBar! {
        didSet {
            self.photoSearchBar.delegate = self
            self.photoSearchBar.placeholder = "Search photos"
        }
    }
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            setupViewModel(with: viewModel)
        }
    }
    
    private let listViewController: ListViewController = {
        guard let listViewController = UIStoryboard.main.instantiateViewController(withIdentifier: ListViewController.storyboardIdentifier) as? ListViewController else {
            fatalError("Unable to Instantiate List View Controller")
        }
    
        // Configure List View Controller
        listViewController.view.translatesAutoresizingMaskIntoConstraints = false
    
         return listViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()
    }
    
    // MARK: - Helper Methods
    
    private func setupChildViewControllers() {
     
        addChild(listViewController)
        
        view.addSubview(listViewController.view)
        
        listViewController.view.topAnchor.constraint(equalTo: photoSearchBar.bottomAnchor).isActive = true
        listViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        listViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        listViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        listViewController.didMove(toParent: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        viewModel.didFetchFlickrData = { [weak self] (flickrData, error) in
            if let _ = error  {
               
                self?.presentAlert(of: .noFlickrDataAvailable)
            } else if let flickrData = flickrData {
                let listViewModel = ListViewModel(flickrData: flickrData.photo)
                
                self?.listViewController.viewModel = listViewModel
            } else {
               self?.presentAlert(of: .noFlickrDataAvailable)
            }
        }
    }
    
    private func presentAlert(of alertType: alertType) {
        let title: String
        let message: String
        
        switch alertType {
            case .noFlickrDataAvailable:
              title = "Unable to Fetch Flickr Data"
              message = "The application is unable to fetch flickr data. Please make sure your devide is connected over Wi-Fi or cellular."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK:- UISearchBarDelegate methods

extension RootViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        
        
        let whitespace = NSCharacterSet.whitespaces

        let phrase = query
        //rangeOfCharacterFromSet(whitespace)
        let range = phrase.rangeOfCharacter(from: whitespace)
        
        // range will be nil if no whitespace is found
        if range == nil {
            self.navigationBar.topItem?.title = query
            searchBar.text = ""
            viewModel?.fetchFlickrData(for: query)
            //viewModel.clearPhotos()
            //flickrAPI.resetValues()
            //searchFlickr(with: query)
        }
    }
}
