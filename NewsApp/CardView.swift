//
//  CardView.swift
//  NewsApp
//
//  Created by Phyo Thinzar Aung on 11/12/18.
//  Copyright © 2018 padc. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 2
    @IBInspectable var shadowOffsetWidth : Int = 0
    @IBInspectable var shadowOffsetHeight : Int = 2
    @IBInspectable var shadowColor : UIColor? = UIColor.blue
    @IBInspectable var shadowOpacity : Float = 0.5
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}
