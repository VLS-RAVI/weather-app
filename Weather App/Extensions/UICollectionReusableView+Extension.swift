//
//  UICollectionReusableView+Extension.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import UIKit

extension UICollectionReusableView {
    
    class var id: String {
        return String(describing: self.classForCoder())
    }
}
