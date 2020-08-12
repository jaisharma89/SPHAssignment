//
//  UIView+Extension.swift
//  CAssignment
//
//  Copyright © 2020 Jai. All rights reserved.
//

import UIKit

extension UIView {

    /// Round UIView selected corners
    ///
    /// - Parameters:
    ///   - corners: selected corners to round
    ///   - radius: round amount
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
    }
    func dropShadow() {

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
        layer.masksToBounds = false

        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
        //layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
