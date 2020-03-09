//
//  UIView+.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(xValue: 0, yValue: 0, width: frame.width, height: size, color: color)
    }
    
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(xValue: 0, yValue: frame.height - size, width: frame.width, height: size, color: color)
    }
   
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(xValue: 0, yValue: 0, width: size, height: frame.height, color: color)
    }
  
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(xValue: frame.width - size, yValue: 0, width: size, height: frame.height, color: color)
    }
    //add border to custom edge
    fileprivate func addBorderUtility(xValue: CGFloat, yValue: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: xValue, y: yValue, width: width, height: height)
        layer.addSublayer(border)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
