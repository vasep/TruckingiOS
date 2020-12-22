//
//  DesignableView.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 22.12.20.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear{
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0{
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.1{
        didSet {
            layer.shadowOpacity = 0.1
        }
    }
    
    @IBInspectable var shadowOffsetY: CGFloat = 0{
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}

