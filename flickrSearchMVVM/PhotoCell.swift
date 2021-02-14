//
//  PhotoCell.swift
//  FlickrSearch
//
//  Created by SMMC on 17/12/2020.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    // MARK:- Properties
    
    static var identifier: String = "Cell"
    
    // MARK:- Screen properties
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "image_placeholder")
        return iv
    }()
    
    
    var imageUrl: String? {
          didSet {
              guard let imageUrl = imageUrl else { return }
              photoImageView.loadImageUsingCache(with: imageUrl)
          }
      }

    // MARK:- Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.reset()
        addSubview(photoImageView)
        photoImageView.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
        
    }

    func reset() {
      photoImageView.image = nil
    }
}
