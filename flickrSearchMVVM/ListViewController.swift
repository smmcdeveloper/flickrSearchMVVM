//
//  ListViewController.swift
//  flickrSearchMVVM
//
//  Created by SMMC on 08/02/2021.
//

import UIKit

final class ListViewController: UIViewController {
    
    // MARK:- Properties
    var viewModel: ListViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    
    private let cellId = "photoCellId"
    weak var collectionView: UICollectionView!

    // MARK: - View Life Cycle
    
    override func loadView() {
           super.loadView()

           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           self.view.addSubview(collectionView)
           NSLayoutConstraint.activate([
               self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
               self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
               self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
               self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
           ])
           self.collectionView = collectionView
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Helper Methods
    
    func setupView() {
    
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
    
    private func setupViewModel(with viewModel: ListViewModel) {
        
       DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(0...0))
            if !viewModel.flickrData.isEmpty {
                let indexPath: IndexPath = IndexPath(item: 0, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
            }
        }
    }
}

extension ListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as! PhotoCell
        
        
        let index = indexPath.item
        let data = viewModel?.flickrData[index].url_m
        cell.imageUrl = data
        
        return cell
    }
}

extension ListViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var collectionViewSize = collectionView.frame.size
        
        collectionViewSize.width = collectionViewSize.width/2.0 //Display Three elements in a row.
        collectionViewSize.height = collectionViewSize.height/3.0
        
        return collectionViewSize
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



