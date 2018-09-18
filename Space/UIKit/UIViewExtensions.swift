//
//  UIViewExtensions.swift
//  EZSwiftExtensions
//
//  Created by Goktug Yilmaz on 15/07/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit

// MARK: Custom UIView Initilizers
extension UIView {
    /// EZSE: convenience contructor to define a view based on width, height and base coordinates.
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }

    /// EZSE: puts padding around the view
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.x + padding, y: superView.y + padding, width: superView.w - padding*2, height: superView.h - padding*2))
    }

    /// EZSwiftExtensions - Copies size of superview
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

// MARK: Frame Extensions
extension UIView {

//    /// EZSE: add multiple subviews
//    public func addSubviews(_ views: [UIView]) {
//        views.forEach { [weak self] eachView in
//            self?.addSubview(eachView)
//        }
//    }

    //TODO: Add pics to readme
    /// EZSE: resizes this view so it fits the largest subview
    public func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.w
            let newHeight = aView.y + aView.h
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    /// EZSE: resizes this view so it fits the largest subview
    public func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.w
                let newHeight = aView.y + aView.h
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }

    /// EZSE: resizes this view so as to fit its width.
    public func resizeToFitWidth() {
        let currentHeight = self.h
        self.sizeToFit()
        self.h = currentHeight
    }

    /// EZSE: resizes this view so as to fit its height.
    public func resizeToFitHeight() {
        let currentWidth = self.w
        self.sizeToFit()
        self.w = currentWidth
    }

//    /// EZSE: getter and setter for the x coordinate of the frame's origin for the view.
//    public var x: CGFloat {
//        get {
//            return self.frame.origin.x
//        } set(value) {
//            self.frame = CGRect(x: value, y: self.y, width: self.w, height: self.h)
//        }
//    }

//    /// EZSE: getter and setter for the y coordinate of the frame's origin for the view.
//    public var y: CGFloat {
//        get {
//            return self.frame.origin.y
//        } set(value) {
//            self.frame = CGRect(x: self.x, y: value, width: self.w, height: self.h)
//        }
//    }

    /// EZSE: variable to get the width of the view.
    public var w: CGFloat {
        get {
            return self.frame.size.width
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: value, height: self.h)
        }
    }

    /// EZSE: variable to get the height of the view.
    public var h: CGFloat {
        get {
            return self.frame.size.height
        } set(value) {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: value)
        }
    }

    /// EZSE: getter and setter for the x coordinate of leftmost edge of the view.
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }

    /// EZSE: getter and setter for the x coordinate of the rightmost edge of the view.
    public var right: CGFloat {
        get {
            return self.x + self.w
        } set(value) {
            self.x = value - self.w
        }
    }

    /// EZSE: getter and setter for the y coordinate for the topmost edge of the view.
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }

    /// EZSE: getter and setter for the y coordinate of the bottom most edge of the view.
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        } set(value) {
            self.y = value - self.h
        }
    }

    /// EZSE: getter and setter the frame's origin point of the view.
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame = CGRect(origin: value, size: self.frame.size)
        }
    }

    /// EZSE: getter and setter for the X coordinate of the center of a view.
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }

    /// EZSE: getter and setter for the Y coordinate for the center of a view.
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }

//    /// EZSE: getter and setter for frame size for the view.
//    public var size: CGSize {
//        get {
//            return self.frame.size
//        } set(value) {
//            self.frame = CGRect(origin: self.frame.origin, size: value)
//        }
//    }

    /// EZSE: getter for an leftwards offset position from the leftmost edge.
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }

    /// EZSE: getter for an rightwards offset position from the rightmost edge.
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }

    /// EZSE: aligns the view to the top by a given offset.
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }

    /// EZSE: align the view to the bottom by a given offset.
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }

    //TODO: Add to readme
    /// EZSE: align the view widthwise to the right by a given offset.
    public func alignRight(_ offset: CGFloat) -> CGFloat {
        return self.w - offset
    }

    /// EZSwiftExtensions
    public func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }

//    public func removeSubviews() {
//        for subview in subviews {
//            subview.removeFromSuperview()
//        }
//    }

    /// EZSE: Centers view in superview horizontally
    public func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }

        self.x = parentView.w/2 - self.w/2
    }

    /// EZSE: Centers view in superview vertically
    public func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("EZSwiftExtensions Error: The view \(self) doesn't have a superview")
            return
        }

        self.y = parentView.h/2 - self.h/2
    }

    /// EZSE: Centers view in superview horizontally & vertically
    public func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}

// MARK: Transform Extensions
extension UIView {
    /// EZSwiftExtensions
    public func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }

    /// EZSwiftExtensions
    public func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

// MARK: Layer Extensions
extension UIView {
    /// EZSwiftExtensions
    public func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }

    /// EZSwiftExtensions
    public func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }

    /// EZSwiftExtensions
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }

    //TODO: add to readme
    /// EZSwiftExtensions
    public func addBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        addBorderUtility(x: padding, y: 0, width: frame.width - padding*2, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }

    /// EZSwiftExtensions
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }

    /// EZSwiftExtensions
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }

    /// EZSwiftExtensions
    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    //TODO: add this to readme
    /// EZSwiftExtensions
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

//TODO: add this to readme
// MARK: Animation Extensions
extension UIView {
    /// EZSwiftExtensions
    public func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }

    /// EZSwiftExtensions
    public func animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }

    /// EZSwiftExtensions
    public func pop() {
        setScale(x: 1.1, y: 1.1)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }

    /// EZSwiftExtensions
    public func popBig() {
        setScale(x: 1.25, y: 1.25)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }

    //EZSE: Reverse pop, good for button animations
    public func reversePop() {
        setScale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: .allowUserInteraction, animations: {
            self.setScale(x: 1, y: 1)
        }, completion: { (isCompleted) in
            
        })
    }
}

//TODO: add this to readme
// MARK: Render Extensions
extension UIView {
    /// EZSwiftExtensions
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

// MARK: Gesture Extensions
extension UIView {
    /// http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32182866#32182866
    /// EZSwiftExtensions
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    /*
    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }*/

    /// EZSwiftExtensions
    public func addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, target: AnyObject, action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction

        #if os(iOS)

        swipe.numberOfTouchesRequired = numberOfTouches

        #endif

        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    /*
    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func addSwipeGesture(direction: UISwipeGestureRecognizerDirection, numberOfTouches: Int = 1, action: ((UISwipeGestureRecognizer) -> Void)?) {
        let swipe = BlockSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }*/

    /// EZSwiftExtensions
    public func addPanGesture(target: AnyObject, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }

    /*
    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func addPanGesture(action: ((UIPanGestureRecognizer) -> Void)?) {
        let pan = BlockPan(action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }*/

    #if os(iOS)

    /// EZSwiftExtensions
    public func addPinchGesture(target: AnyObject, action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }

    #endif
    /*
    #if os(iOS)

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func addPinchGesture(action: ((UIPinchGestureRecognizer) -> Void)?) {
        let pinch = BlockPinch(action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }

    #endif
    */
    /*
    /// EZSwiftExtensions
    public func addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }*/

    /*
    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func addLongPressGesture(action: ((UILongPressGestureRecognizer) -> Void)?) {
        let longPress = BlockLongPress(action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }*/
}

//TODO: add to readme
extension UIView {
//    /// EZSwiftExtensions [UIRectCorner.TopLeft, UIRectCorner.TopRight]
//    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
    
    /// EZSwiftExtensions - Mask square/rectangle UIView with a circular/capsule cover, with a border of desired color and width around it
    public func roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        self.setCornerRadius(radius: min(self.frame.size.height, self.frame.size.width) / 2)
        self.layer.borderWidth = width ?? 0
        self.layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }
    
    /// EZSwiftExtensions - Remove all masking around UIView
    public func nakedView() {
        self.layer.mask = nil
        self.layer.borderWidth = 0
    }
}

extension UIView {
    ///EZSE: Shakes the view for as many number of times as given in the argument.
    public func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100

        self.layer.add(anim, forKey: nil)
    }
}

extension UIView {
    ///EZSE: Loops until it finds the top root view. //TODO: Add to readme
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
}

// MARK: Fade Extensions

public let UIViewDefaultFadeDuration: TimeInterval = 0.4

extension UIView {
    ///EZSE: Fade in with duration, delay and completion block.
    public func fadeIn(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        fadeTo(1.0, duration: duration, delay: delay, completion: completion)
    }

    /// EZSwiftExtensions
    public func fadeOut(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        fadeTo(0.0, duration: duration, delay: delay, completion: completion)
    }

    /// Fade to specific value	 with duration, delay and completion block.
    public func fadeTo(_ value: CGFloat, duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: delay ?? UIViewDefaultFadeDuration, options: .curveEaseInOut, animations: {
            self.alpha = value
        }, completion: completion)
    }
}

#endif


#if os(iOS) || os(tvOS)
    
    // MARK: - enums
    
    /// SwifterSwift: Shake directions of a view.
    ///
    /// - horizontal: Shake left and right.
    /// - vertical: Shake up and down.
    public enum ShakeDirection {
        case horizontal
        case vertical
    }
    
    /// SwifterSwift: Angle units.
    ///
    /// - degrees: degrees.
    /// - radians: radians.
    public enum AngleUnit {
        case degrees
        case radians
    }
    
    /// SwifterSwift: Shake animations types.
    ///
    /// - linear: linear animation.
    /// - easeIn: easeIn animation
    /// - easeOut: easeOut animation.
    /// - easeInOut: easeInOut animation.
    public enum ShakeAnimationType {
        case linear
        case easeIn
        case easeOut
        case easeInOut
    }
    
    // MARK: - Properties
    public extension UIView {
        
        /// SwifterSwift: Border color of view; also inspectable from Storyboard.
        @IBInspectable public var borderColor: UIColor? {
            get {
                guard let color = layer.borderColor else { return nil }
                return UIColor(cgColor: color)
            }
            set {
                guard let color = newValue else {
                    layer.borderColor = nil
                    return
                }
                // Fix React-Native conflict issue
                guard String(describing: type(of: color)) != "__NSCFType" else { return }
                layer.borderColor = color.cgColor
            }
        }
        
        /// SwifterSwift: Border width of view; also inspectable from Storyboard.
        @IBInspectable public var borderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }
        
        /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
        @IBInspectable public var cornerRadius: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
//                layer.masksToBounds = true
                layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
            }
        }
        
        /// SwifterSwift: First responder.
        public var firstResponder: UIView? {
            guard !isFirstResponder else { return self }
            for subView in subviews where subView.isFirstResponder {
                return subView
            }
            return nil
        }
        
        // SwifterSwift: Height of view.
        public var height: CGFloat {
            get {
                return frame.size.height
            }
            set {
                frame.size.height = newValue
            }
        }
        
        /// SwifterSwift: Check if view is in RTL format.
        public var isRightToLeft: Bool {
            if #available(iOS 10.0, *, tvOS 10.0, *) {
                return effectiveUserInterfaceLayoutDirection == .rightToLeft
            } else {
                return false
            }
        }
        
        /// SwifterSwift: Take screenshot of view (if applicable).
        public var screenshot: UIImage? {
            UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
            defer {
                UIGraphicsEndImageContext()
            }
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        
        /// SwifterSwift: Shadow color of view; also inspectable from Storyboard.
        @IBInspectable public var shadowColor: UIColor? {
            get {
                guard let color = layer.shadowColor else { return nil }
                return UIColor(cgColor: color)
            }
            set {
                layer.shadowColor = newValue?.cgColor
            }
        }
        
        /// SwifterSwift: Shadow offset of view; also inspectable from Storyboard.
        @IBInspectable public var shadowOffset: CGSize {
            get {
                return layer.shadowOffset
            }
            set {
                layer.shadowOffset = newValue
            }
        }
        
        /// SwifterSwift: Shadow opacity of view; also inspectable from Storyboard.
        @IBInspectable public var shadowOpacity: Float {
            get {
                return layer.shadowOpacity
            }
            set {
                layer.shadowOpacity = newValue
            }
        }
        
        /// SwifterSwift: Shadow radius of view; also inspectable from Storyboard.
        @IBInspectable public var shadowRadius: CGFloat {
            get {
                return layer.shadowRadius
            }
            set {
                layer.shadowRadius = newValue
            }
        }
        
        /// SwifterSwift: Size of view.
        public var size: CGSize {
            get {
                return frame.size
            }
            set {
                width = newValue.width
                height = newValue.height
            }
        }
        
        /// SwifterSwift: Get view's parent view controller
        public var parentViewController: UIViewController? {
            weak var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder!.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
        
        /// SwifterSwift: Width of view.
        public var width: CGFloat {
            get {
                return frame.size.width
            }
            set {
                frame.size.width = newValue
            }
        }
        
        /// SwifterSwift: x origin of view.
        public var x: CGFloat {
            get {
                return frame.origin.x
            }
            set {
                frame.origin.x = newValue
            }
        }
        
        /// SwifterSwift: y origin of view.
        public var y: CGFloat {
            get {
                return frame.origin.y
            }
            set {
                frame.origin.y = newValue
            }
        }
        
    }
    
    // MARK: - Methods
    public extension UIView {
        
        /// SwifterSwift: Set some or all corners radiuses of view.
        ///
        /// - Parameters:
        ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
        ///   - radius: radius for selected corners.
        public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            let maskPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            layer.mask = shape
        }
        
        /// SwifterSwift: Add shadow to view.
        ///
        /// - Parameters:
        ///   - color: shadow color (default is #137992).
        ///   - radius: shadow radius (default is 3).
        ///   - offset: shadow offset (default is .zero).
        ///   - opacity: shadow opacity (default is 0.5).
        public func addShadow(ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0), radius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
            layer.shadowColor = color.cgColor
            layer.shadowOffset = offset
            layer.shadowRadius = radius
            layer.shadowOpacity = opacity
            layer.masksToBounds = true
        }
        
        /// SwifterSwift: Add array of subviews to view.
        ///
        /// - Parameter subviews: array of subviews to add to self.
        public func addSubviews(_ subviews: [UIView]) {
            subviews.forEach({self.addSubview($0)})
        }
        
        /// SwifterSwift: Fade in view.
        ///
        /// - Parameters:
        ///   - duration: animation duration in seconds (default is 1 second).
        ///   - completion: optional completion handler to run with animation finishes (default is nil)
        public func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
            if isHidden {
                isHidden = false
            }
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
            }, completion: completion)
        }
        
        /// SwifterSwift: Fade out view.
        ///
        /// - Parameters:
        ///   - duration: animation duration in seconds (default is 1 second).
        ///   - completion: optional completion handler to run with animation finishes (default is nil)
        public func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
            if isHidden {
                isHidden = false
            }
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }, completion: completion)
        }
        
        /// SwifterSwift: Load view from nib.
        ///
        /// - Parameters:
        ///   - name: nib name.
        ///   - bundle: bundle of nib (default is nil).
        /// - Returns: optional UIView (if applicable).
        public class func loadFromNib(named name: String, bundle: Bundle? = nil) -> UIView? {
            return UINib(nibName: name, bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as? UIView
        }
        
        /// SwifterSwift: Remove all subviews in view.
        public func removeSubviews() {
            subviews.forEach({$0.removeFromSuperview()})
        }
        
        /// SwifterSwift: Remove all gesture recognizers from view.
        public func removeGestureRecognizers() {
            gestureRecognizers?.forEach(removeGestureRecognizer)
        }
        
        /// SwifterSwift: Rotate view by angle on relative axis.
        ///
        /// - Parameters:
        ///   - angle: angle to rotate view by.
        ///   - type: type of the rotation angle.
        ///   - animated: set true to animate rotation (default is true).
        ///   - duration: animation duration in seconds (default is 1 second).
        ///   - completion: optional completion handler to run with animation finishes (default is nil).
        public func rotate(byAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
            let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
            let aDuration = animated ? duration : 0
            UIView.animate(withDuration: aDuration, delay: 0, options: .curveLinear, animations: { () -> Void in
                self.transform = self.transform.rotated(by: angleWithType)
            }, completion: completion)
        }
        
        /// SwifterSwift: Rotate view to angle on fixed axis.
        ///
        /// - Parameters:
        ///   - angle: angle to rotate view to.
        ///   - type: type of the rotation angle.
        ///   - animated: set true to animate rotation (default is false).
        ///   - duration: animation duration in seconds (default is 1 second).
        ///   - completion: optional completion handler to run with animation finishes (default is nil).
        public func rotate(toAngle angle: CGFloat, ofType type: AngleUnit, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
            let angleWithType = (type == .degrees) ? CGFloat.pi * angle / 180.0 : angle
            let aDuration = animated ? duration : 0
            UIView.animate(withDuration: aDuration, animations: {
                self.transform = self.transform.concatenating(CGAffineTransform(rotationAngle: angleWithType))
            }, completion: completion)
        }
        
        /// SwifterSwift: Scale view by offset.
        ///
        /// - Parameters:
        ///   - offset: scale offset
        ///   - animated: set true to animate scaling (default is false).
        ///   - duration: animation duration in seconds (default is 1 second).
        ///   - completion: optional completion handler to run with animation finishes (default is nil).
        public func scale(by offset: CGPoint, animated: Bool = false, duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
            if animated {
                UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
                    self.transform = self.transform.scaledBy(x: offset.x, y: offset.y)
                }, completion: completion)
            } else {
                transform = transform.scaledBy(x: offset.x, y: offset.y)
                completion?(true)
            }
        }
        
        /// SwifterSwift: Shake view.
        ///
        /// - Parameters:
        ///   - direction: shake direction (horizontal or vertical), (default is .horizontal)
        ///   - duration: animation duration in seconds (default is 1 second).
        ///   - animationType: shake animation type (default is .easeOut).
        ///   - completion: optional completion handler to run with animation finishes (default is nil).
        public func shake(direction: ShakeDirection = .horizontal, duration: TimeInterval = 1, animationType: ShakeAnimationType = .easeOut, completion:(() -> Void)? = nil) {
            
            CATransaction.begin()
            let animation: CAKeyframeAnimation
            switch direction {
            case .horizontal:
                animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            case .vertical:
                animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
            }
            switch animationType {
            case .linear:
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            case .easeIn:
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            case .easeOut:
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            case .easeInOut:
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            }
            CATransaction.setCompletionBlock(completion)
            animation.duration = duration
            animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
            layer.add(animation, forKey: "shake")
            CATransaction.commit()
        }
        
        /// SwifterSwift: Add Visual Format constraints.
        ///
        /// - Parameters:
        ///   - withFormat: visual Format language
        ///   - views: array of views which will be accessed starting with index 0 (example: [v0], [v1], [v2]..)
        @available(iOS 9, *) public func addConstraints(withFormat: String, views: UIView...) {
            // https://videos.letsbuildthatapp.com/
            var viewsDictionary: [String: UIView] = [:]
            for (index, view) in views.enumerated() {
                let key = "v\(index)"
                view.translatesAutoresizingMaskIntoConstraints = false
                viewsDictionary[key] = view
            }
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withFormat, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        }
        
        /// SwifterSwift: Anchor all sides of the view into it's superview.
        @available(iOS 9, *) public func fillToSuperview() {
            // https://videos.letsbuildthatapp.com/
            translatesAutoresizingMaskIntoConstraints = false
            if let superview = superview {
                leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
            }
        }
        
        /// SwifterSwift: Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
        ///
        /// - Parameters:
        ///   - top: current view's top anchor will be anchored into the specified anchor
        ///   - left: current view's left anchor will be anchored into the specified anchor
        ///   - bottom: current view's bottom anchor will be anchored into the specified anchor
        ///   - right: current view's right anchor will be anchored into the specified anchor
        ///   - topConstant: current view's top anchor margin
        ///   - leftConstant: current view's left anchor margin
        ///   - bottomConstant: current view's bottom anchor margin
        ///   - rightConstant: current view's right anchor margin
        ///   - widthConstant: current view's width
        ///   - heightConstant: current view's height
        /// - Returns: array of newly added constraints (if applicable).
        @available(iOS 9, *) @discardableResult public func anchor(
            top: NSLayoutYAxisAnchor? = nil,
            left: NSLayoutXAxisAnchor? = nil,
            bottom: NSLayoutYAxisAnchor? = nil,
            right: NSLayoutXAxisAnchor? = nil,
            topConstant: CGFloat = 0,
            leftConstant: CGFloat = 0,
            bottomConstant: CGFloat = 0,
            rightConstant: CGFloat = 0,
            widthConstant: CGFloat = 0,
            heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
            // https://videos.letsbuildthatapp.com/
            translatesAutoresizingMaskIntoConstraints = false
            
            var anchors = [NSLayoutConstraint]()
            
            if let top = top {
                anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
            }
            
            if let left = left {
                anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
            }
            
            if let bottom = bottom {
                anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
            }
            
            if let right = right {
                anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
            }
            
            if widthConstant > 0 {
                anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
            }
            
            if heightConstant > 0 {
                anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
            }
            
            anchors.forEach({$0.isActive = true})
            
            return anchors
        }
        
        /// SwifterSwift: Anchor center X into current view's superview with a constant margin value.
        ///
        /// - Parameter constant: constant of the anchor constraint (default is 0).
        @available(iOS 9, *) public func anchorCenterXToSuperview(constant: CGFloat = 0) {
            // https://videos.letsbuildthatapp.com/
            translatesAutoresizingMaskIntoConstraints = false
            if let anchor = superview?.centerXAnchor {
                centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            }
        }
        
        /// SwifterSwift: Anchor center Y into current view's superview with a constant margin value.
        ///
        /// - Parameter withConstant: constant of the anchor constraint (default is 0).
        @available(iOS 9, *) public func anchorCenterYToSuperview(constant: CGFloat = 0) {
            // https://videos.letsbuildthatapp.com/
            translatesAutoresizingMaskIntoConstraints = false
            if let anchor = superview?.centerYAnchor {
                centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            }
        }
        
        /// SwifterSwift: Anchor center X and Y into current view's superview
        @available(iOS 9, *) public func anchorCenterSuperview() {
            // https://videos.letsbuildthatapp.com/
            anchorCenterXToSuperview()
            anchorCenterYToSuperview()
        }
        
    }
#endif
