//
//  Ext+UIView.swift
//  Nimble-iOS-Challenge
//
//  Created by Anthony Odu on 2/21/22.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

public extension UIView {
    typealias Constraints = [NSLayoutConstraint]
    func constrain(_ constraint: Constraints) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraint)
    }
    
    // MARK: Main Methods
    
    @discardableResult
    func constrainVerticalEdges(to view: UIView, topPadding: CGFloat = 0, bottomPadding: CGFloat = 0) -> Constraints {
        let constraints = constraintsForVerticalEdges(to: view, padding: .init(top: topPadding, left: 0, bottom: bottomPadding, right: 0))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainHorizontalEdges(to view: UIView, leftPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> Constraints {
        let constraints = constraintsForHorizontalEdges(to: view, padding: .init(top: 0, left: leftPadding, bottom: 0, right: rightPadding))
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainHeight(_ height: CGFloat) -> Constraints {
        let constraints = constraintsForHeight(height)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainWidth(_ width: CGFloat) -> Constraints {
        let constraints = constraintsForWidth(width)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainSize(_ size: CGSize) -> Constraints {
        let constraints = constraintsForSize(size: size)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func contraintCenterToSuperview() -> Constraints {
        var constraints = centerX(to: superview!)
        constraints.append(contentsOf: centerY(to: superview!))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainCenter(to view: UIView) -> Constraints {
        var constraints = centerX(to: view)
        constraints.append(contentsOf: centerY(to: view))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainCenterX(to view: UIView, offset: Int = 0) -> Constraints {
        let constraints = centerX(to: view)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainCenterY(to view: UIView) -> Constraints {
        let constraints = centerY(to: view)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTopRight(to view: UIView, topPadding: CGFloat = 0, rightPadding: CGFloat = 0) -> Constraints {
        var constraints = top(to: view, constant: topPadding)
        constraints.append(contentsOf: right(to: view, constant: rightPadding))
        
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainLeft(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = left(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainRight(to view: UIView) -> Constraints {
        let constraints = right(to: view)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottom(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = bottom(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func constrainBottomSafeArea(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = bottomSafeArea(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTop(to view: UIView,  constant: CGFloat = 0) -> Constraints {
        let constraints = top(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func constrainTopSafeArea(to view: UIView, constant: CGFloat = 0) -> Constraints {
        let constraints = topSafeArea(to: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainTopToBottom(of view: UIView,  constant: CGFloat = 0) -> Constraints {
        let constraints = topToBottom(of: view, constant: constant)
        constrain(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainBottomToTop(of view: UIView,  constant: CGFloat = 0) -> Constraints {
        let constraints = bottomToTop(of: view, constant: constant)
        constrain(constraints)
        return constraints
    }
}

// MARK: Building Blocks

private extension UIView {

    func constraintsForHeight(_ height: CGFloat) -> Constraints {
        return [
            heightAnchor.constraint(equalToConstant: height),
        ]
    }

    func constraintsForWidth(_ width: CGFloat) -> Constraints {
        return [
            widthAnchor.constraint(equalToConstant: width),
        ]
    }
    
    func constraintsForSize(size: CGSize) -> Constraints {
        return [
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ]
    }
    
    func constraintsForHorizontalEdges(to view: UIView, padding: UIEdgeInsets) -> Constraints {
        return [leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left), trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right)]
    }
    
    func constraintsForVerticalEdges(to view: UIView, padding: UIEdgeInsets) -> Constraints {
        return [topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top), bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom)]
    }
    
    func centerX(to view: UIView) -> Constraints {
        return [centerXAnchor.constraint(equalTo: view.centerXAnchor)]
    }
    
    func centerY(to view: UIView) -> Constraints {
        return [centerYAnchor.constraint(equalTo: view.centerYAnchor)]
    }
    
    func top(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [topAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: constant)]
    }
    
    @available(iOS 11.0, *)
    func topSafeArea(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [topAnchor.constraint(equalTo: anchor ?? view.safeAreaLayoutGuide.topAnchor, constant: constant)]
    }
    
    func bottom(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [bottomAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: constant)]
    }
    
    @available(iOS 11.0, *)
    func bottomSafeArea(to view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [bottomAnchor.constraint(equalTo: anchor ?? view.safeAreaLayoutGuide.bottomAnchor, constant: constant)]
    }
    
    func right(to view: UIView, anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [rightAnchor.constraint(equalTo: anchor ?? view.rightAnchor, constant: constant)]
    }
    
    func left(to view: UIView, anchor: NSLayoutXAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [leftAnchor.constraint(equalTo: anchor ?? view.leftAnchor, constant: constant)]
    }
    
    func topToBottom(of view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [topAnchor.constraint(equalTo: anchor ?? view.bottomAnchor, constant: constant)]
    }
    
    func bottomToTop(of view: UIView, anchor: NSLayoutYAxisAnchor? = nil, constant: CGFloat = 0) -> Constraints {
        return [bottomAnchor.constraint(equalTo: anchor ?? view.topAnchor, constant: constant)]
    }
}
