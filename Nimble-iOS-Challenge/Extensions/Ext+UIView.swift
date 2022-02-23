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



public class SkeletonLabel: UILabel{
    var skeletonColor: String = "f6f6f6"
}

public class SkeletonCover: UIView{
    
}
public extension UIView {
    func endSkeleton() {
        for i in self.subviews{
            if let stack = i as? UIStackView{
                for n in stack.subviews{
                    n.removeSkeleton()
                }
            }else{
                i.removeSkeleton()
            }
        }
    }
    
    func removeSkeleton(){
        for n in self.subviews{
            if let shellView = n as? SkeletonCover{
                shellView.removeFromSuperview()
            }
            n.layer.mask = nil
        }
    }
    
    
    func addSkeleton(){
        let n = self
        let cover = SkeletonCover(frame: n.bounds)
        if let nView = n as? SkeletonLabel{
            cover.backgroundColor = nView.skeletonColor.getColor
        }else{
            cover.backgroundColor = UIColor.hexStringToUIColor(hex: "3D3D3F")
        }
        n.addSubview(cover)
        let cover2 = SkeletonCover(frame: n.bounds)
        cover2.backgroundColor = UIColor.gray
        n.addSubview(cover2)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor, UIColor.clear.cgColor,
            UIColor.gray.withAlphaComponent(0.1).cgColor, UIColor.gray.withAlphaComponent(0.1).cgColor,
            UIColor.gray.withAlphaComponent(0.1).cgColor, UIColor.gray.withAlphaComponent(0.1).cgColor,
            UIColor.clear.cgColor, UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0, 0.1, 0.3, 0.4, 0.6,0.7, 0.9, 1]
        
        let angle = 60 * CGFloat.pi / 180
        let rotationTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        gradientLayer.transform = rotationTransform
        cover2.layer.addSublayer(gradientLayer)
        gradientLayer.frame = cover2.frame
        gradientLayer.opacity = 0.8
        cover2.layer.mask = gradientLayer
        gradientLayer.transform = CATransform3DConcat(gradientLayer.transform, CATransform3DMakeScale(3, 3, 0))
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 3
        animation.repeatCount = Float.infinity
        animation.autoreverses = false
        animation.fromValue = -3  * n.bounds.width
        animation.toValue = 3 * n.bounds.width
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        gradientLayer.add(animation, forKey: "shimmerKey")
    }
    func viewSkeleton(){
        for i in self.subviews{
            i.addSkeleton()
        }
    }
    
    
    func removeViewSkeleton(){
        for i in self.subviews{
            i.removeSkeleton()
        }
    }
    func startSkeleton(){
        for i in self.subviews{
            if let stack = i as? UIStackView{
                for n in stack.subviews{
                    n.addSkeleton()
                }
                
            }else{
                i.addSkeleton()
            }
        }
    }
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
