//
//  UIKit+UIColor.swift
//  FlickrSearch
//
//  Created by SMMC on 17/12/2020.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
