//
//  Test.swift
//  Calculator_App
//
//  Created by Dmitriy Mkrtumyan on 10.08.23.
//

import UIKit

extension UIView {
    func addCustomConstraints(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat, paddingLeft: CGFloat? = nil, paddingBottom: CGFloat? = nil, paddingRight: CGFloat? = nil, width: CGFloat, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left, let paddingLeft {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom, let paddingBottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right, let paddingRight {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            if let height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
}
