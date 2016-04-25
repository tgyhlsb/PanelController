//
//  PanelController.swift
//  PanelControllerDemo
//
//  Created by Tanguy Helesbeux on 09/02/2016.
//  Copyright © 2016 HEVA. All rights reserved.
//

import UIKit

public protocol PanelControllerDelegate {
    
    func panelController(panelController: PanelController, willChangePanel side: PanelController.PanelSide, toState state: PanelController.PanelState)
    func panelController(panelController: PanelController, didChangePanel side: PanelController.PanelSide, toState state: PanelController.PanelState)
    
    func panelController(panelController: PanelController, willChangeSizeOfPanel side: PanelController.PanelSide)
    func panelController(panelController: PanelController, didChangeSizeOfPanel side: PanelController.PanelSide)
}

public class PanelController: UIViewController {

    // MARK: - INITIALIZERS -
    
    public init(centerController: UIViewController, leftController: UIViewController? = nil, rightController: UIViewController? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.setCenterPanelWithController(centerController)
        self.setLeftPanelWithController(leftController)
        self.setRightPanelWithController(rightController)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC -
    
    public enum PanelStyle: Int {
        case Above
        case SideBySide
    }
    
    public enum PanelState: Int {
        case Opened
        case Closed
    }
    
    public enum PanelSide: Int {
        case Left
        case Right
    }
    
    // MARK: Properties
    
    public private(set) var centerController: UIViewController?
    public private(set) var leftController: UIViewController?
    public private(set) var rightController: UIViewController?
    
    public private(set) var leftPanelState: PanelState = .Closed
    public private(set) var rightPanelState: PanelState = .Closed
    
    public var leftPanelStyle: PanelStyle = .SideBySide     { didSet { self.updateLayout(animated: false) } }
    public var rightPanelStyle: PanelStyle = .SideBySide    { didSet { self.updateLayout(animated: false) } }
    
    public var delegate: PanelControllerDelegate?
    
    public var layoutAnimationsDuration: NSTimeInterval = 0.5
    
    // MARK: API
    
    /**
    
    Applies the given `state` to the panel at the given `side`.
    Animation will start immediately. Any other call to this function will create new animations.
    If you want to change multiple panels at the same time consider using `setPanel(sides:state:)` or `setPanels(changes:)`.

    - parameter side: The side of the panel you want to change.
    - parameter state: The state you want to apply to the panel.
    - parameter animated: `Optional`. If `true` will animate with the duration set in `PanelController.layoutAnimationsDuration`.
    
    */
    public func setPanel(side: PanelSide, _ state: PanelState, animated: Bool = false) {
        self.delegate?.panelController(self, willChangePanel: side, toState: state)
        switch side {
        case .Left:
            self.leftPanelState  = state
            self.leftController?.beginAppearanceTransition(state == .Opened, animated: animated)
        case .Right:
            self.rightPanelState = state
            self.rightController?.beginAppearanceTransition(state == .Opened, animated: animated)
        }
        
        self.updateLayout(animated: animated) { finished in
            self.delegate?.panelController(self, didChangePanel: side, toState: state)
            switch side {
            case .Left: self.leftController?.endAppearanceTransition()
            case .Right: self.rightController?.endAppearanceTransition()
            }
        }
        
    }
    
    /**
     
     Applies the given `state` to the panels in `sides`.
     All changes will be grouped and executed in a single animation.
     
     - parameter sides: Array of `PanelSide`, the panels you want to change.
     - parameter state: The state you want to apply to the panels.
     - parameter animated: `Optional`. If `true` will animate with the duration set in `PanelController.layoutAnimationsDuration`.
     
     */
    
    public func setPanels(sides: [PanelSide], _ state: PanelState, animated: Bool = false) {
        for side in sides {
            self.delegate?.panelController(self, willChangePanel: side, toState: state)
            switch side {
            case .Left:
                self.leftPanelState  = state
                self.leftController?.beginAppearanceTransition(state == .Opened, animated: animated)
            case .Right:
                self.rightPanelState = state
                self.rightController?.beginAppearanceTransition(state == .Opened, animated: animated)
            }
        }
        self.updateLayout(animated: animated) { finished in
            for side in sides {
                self.delegate?.panelController(self, didChangePanel: side, toState: state)
                switch side {
                case .Left: self.leftController?.endAppearanceTransition()
                case .Right: self.rightController?.endAppearanceTransition()
                }
            }
        }
    }
    
    /**
     
     Applies a given `change.state` to its `change.side`.
     All changes will be grouped and executed in a single animation.
     
     - parameter changes: Array of `(PanelSide, PanelState)`, list of changed you want to apply.
     - parameter animated: `Optional`. If `true` will animate with the duration set in `PanelController.layoutAnimationsDuration`.
     
     */
    
    public func setPanels(changes: [(side: PanelSide, state: PanelState)], animated: Bool = false) {
        for change in changes {
            self.delegate?.panelController(self, willChangePanel: change.side, toState: change.state)
            switch change.side {
            case .Left:
                self.leftPanelState  = change.state
                self.leftController?.beginAppearanceTransition(change.state == .Opened, animated: animated)
            case .Right:
                self.rightPanelState = change.state
                self.rightController?.beginAppearanceTransition(change.state == .Opened, animated: animated)
            }
        }
        self.updateLayout(animated: animated) { finished in
            for change in changes {
                self.delegate?.panelController(self, didChangePanel: change.side, toState: change.state)
                switch change.side {
                case .Left: self.leftController?.endAppearanceTransition()
                case .Right: self.rightController?.endAppearanceTransition()
                }
            }
        }
    }
    
    // Mark: Panel Setters
    
    public func setCenterPanelWithController(controller: UIViewController?)   { self._setCenterPanelWithController(controller) }
    public func setLeftPanelWithController(controller: UIViewController?)     { self._setLeftPanelWithController(controller)   }
    public func setRightPanelWithController(controller: UIViewController?)    { self._setRightPanelWithController(controller)  }
    
    // MARK: - PRIVATE -
    
    @IBOutlet var centerPanelConstraints: [NSLayoutConstraint]?
    @IBOutlet var leftPanelConstraints: [NSLayoutConstraint]?
    @IBOutlet var rightPanelConstraints: [NSLayoutConstraint]?
    
    @IBOutlet weak var centerPanelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerPanelTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftPanelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftPanelWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightPanelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelWidthConstraint: NSLayoutConstraint!
    
    typealias completionBlock = () -> Void
    
    // MARK: Panel setters
    
    private func _setCenterPanelWithController(controller: UIViewController?) {
        guard let centerController = controller else { return self.removeController(self.centerController) }
        guard !centerController.isEqual(self.centerController) else { return }
        
        self.removeController(self.centerController)
        self.addChildViewController(centerController)
        centerController.willMoveToParentViewController(self)
        centerController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(centerController.view)
        
        let topConstraint =         NSLayoutConstraint(item: self.view, attribute: .Top,         relatedBy: .Equal, toItem: centerController.view, attribute: .Top,         multiplier: 1.0, constant: 0.0)
        let bottomConstraint =      NSLayoutConstraint(item: self.view, attribute: .Bottom,      relatedBy: .Equal, toItem: centerController.view, attribute: .Bottom,      multiplier: 1.0, constant: 0.0)
        let leadingConstraint =     NSLayoutConstraint(item: self.view, attribute: .Leading,     relatedBy: .Equal, toItem: centerController.view, attribute: .Leading,     multiplier: 1.0, constant: 0.0)
        let trailingConstraint =    NSLayoutConstraint(item: self.view, attribute: .Trailing,    relatedBy: .Equal, toItem: centerController.view, attribute: .Trailing,    multiplier: 1.0, constant: 0.0)
        
        self.centerPanelConstraints = [leadingConstraint, trailingConstraint, topConstraint, bottomConstraint]
        self.centerPanelLeadingConstraint = leadingConstraint
        self.centerPanelTrailingConstraint = trailingConstraint
        
        self.view.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        
        centerController.didMoveToParentViewController(self)
        self.view.layoutSubviews()
        self.centerController = centerController
    }
    
    private func _setLeftPanelWithController(controller: UIViewController?) {
        guard let leftController = controller else { return self.removeController(self.leftController) }
        guard !leftController.isEqual(self.leftController) else { return }
        
        self.removeController(self.leftController)
        self.addChildViewController(leftController)
        leftController.willMoveToParentViewController(self)
        leftController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(leftController.view)
        
        
        let topConstraint =         NSLayoutConstraint(item: self.view,             attribute: .Top,         relatedBy: .Equal, toItem: leftController.view, attribute: .Top,            multiplier: 1.0, constant: 0.0)
        let bottomConstraint =      NSLayoutConstraint(item: self.view,             attribute: .Bottom,      relatedBy: .Equal, toItem: leftController.view, attribute: .Bottom,         multiplier: 1.0, constant: 0.0)
        let leadingConstraint =     NSLayoutConstraint(item: self.view,             attribute: .Leading,     relatedBy: .Equal, toItem: leftController.view, attribute: .Leading,        multiplier: 1.0, constant: 0.0)
        let widthConstraint =       NSLayoutConstraint(item: leftController.view,   attribute: .Width,       relatedBy: .Equal, toItem: nil,                 attribute: .NotAnAttribute, multiplier: 1.0, constant: leftController.preferredContentSize.width)
        
        self.leftPanelConstraints = [leadingConstraint, topConstraint, bottomConstraint, widthConstraint]
        self.leftPanelLeadingConstraint = leadingConstraint
        self.leftPanelWidthConstraint = widthConstraint
        
        self.view.addConstraints([topConstraint, bottomConstraint, leadingConstraint])
        leftController.view.addConstraint(widthConstraint)
        
        leftController.didMoveToParentViewController(self)
        self.updateViewConstraints()
        self.view.layoutSubviews()
        self.leftController = leftController
    }
    
    private func _setRightPanelWithController(controller: UIViewController?) {
        guard let rightController = controller else { return self.removeController(self.rightController) }
        guard !rightController.isEqual(self.rightController) else { return }
        
        self.removeController(self.rightController)
        self.addChildViewController(rightController)
        rightController.willMoveToParentViewController(self)
        rightController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(rightController.view)
        
        
        let topConstraint =         NSLayoutConstraint(item: self.view,             attribute: .Top,        relatedBy: .Equal, toItem: rightController.view, attribute: .Top,               multiplier: 1.0, constant: 0.0)
        let bottomConstraint =      NSLayoutConstraint(item: self.view,             attribute: .Bottom,     relatedBy: .Equal, toItem: rightController.view, attribute: .Bottom,            multiplier: 1.0, constant: 0.0)
        let trailingConstraint =    NSLayoutConstraint(item: self.view,             attribute: .Trailing,   relatedBy: .Equal, toItem: rightController.view, attribute: .Trailing,          multiplier: 1.0, constant: 0.0)
        let widthConstraint =       NSLayoutConstraint(item: rightController.view,  attribute: .Width,      relatedBy: .Equal, toItem: nil,                  attribute: .NotAnAttribute,    multiplier: 1.0, constant: rightController.preferredContentSize.width)
        
        self.rightPanelConstraints = [trailingConstraint, topConstraint, bottomConstraint, widthConstraint]
        self.rightPanelTrailingConstraint = trailingConstraint
        self.rightPanelWidthConstraint = widthConstraint
        
        self.view.addConstraints([topConstraint, bottomConstraint, trailingConstraint])
        rightController.view.addConstraint(widthConstraint)
        
        rightController.didMoveToParentViewController(self)
        self.updateViewConstraints()
        self.view.layoutSubviews()
        self.rightController = rightController
    }
    
    // MARK: Child controllers
    
    private func removeController(controller: UIViewController!) {
        guard controller != nil else { return }
        controller.willMoveToParentViewController(nil)
        controller.view.removeFromSuperview()
        controller.didMoveToParentViewController(nil)
    }
    
    override public func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer) {
        guard let controller = container as? UIViewController else { return }
        guard let side = self.sideForController(controller) else { return }
        
        self.delegate?.panelController(self, willChangeSizeOfPanel: side)
        self.updateLayout(animated: true) { finished in
            self.delegate?.panelController(self, didChangeSizeOfPanel: side)
        }
    }
    private func sideForController(controller: UIViewController) -> PanelSide? {
        if controller.isEqual(self.leftController) {
            return .Left
        } else if controller.isEqual(self.rightController) {
            return .Right
        } else {
            return nil
        }
    }
    
    // MARK: Layout
    
    private func updateLayout(animated animated: Bool, duration: NSTimeInterval? = nil, completion: completionBlock? = nil) {
        let finalDuration = duration ?? self.layoutAnimationsDuration
        self.updateViewConstraints()
        guard animated else {
            self.view.layoutIfNeeded()
            completion?()
            return
        }
        
        UIView.animateWithDuration(finalDuration, animations: { () -> Void in
            self.view.layoutIfNeeded()
            }, completion: { finished in
                if finished { completion?() }
            })
    }
    
    override public func updateViewConstraints() {
        
        // Panel left
        let leftWidth = self.widthForController(self.leftController)
        let leftOffset = self.leftPanelState == .Opened ? 0.0 : leftWidth
        if self.leftPanelLeadingConstraint != nil {
            self.leftPanelLeadingConstraint.constant = leftOffset
            self.leftPanelWidthConstraint.constant = leftWidth
        }

        // Panel right
        let rightWidth = self.widthForController(self.rightController)
        let rightOffset = self.rightPanelState == .Opened ? 0.0 : -rightWidth
        if self.rightPanelTrailingConstraint != nil {
            self.rightPanelTrailingConstraint.constant = rightOffset
            self.rightPanelWidthConstraint.constant = rightWidth
        }
        
        // Center
        if self.centerPanelLeadingConstraint != nil {
            self.centerPanelLeadingConstraint.constant = self.leftPanelStyle == .SideBySide && self.leftPanelState == .Opened ? -leftWidth : 0.0
            self.centerPanelTrailingConstraint.constant = self.rightPanelStyle == .SideBySide && self.rightPanelState == .Opened  ? rightWidth : 0.0
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: Content sizes
    
    static let defaultPanelWidth = CGFloat(300)
    
    private func widthForController(controller: UIViewController?) -> CGFloat {
        if let width = controller?.preferredContentSize.width where width > 0 {
            return width
        }
        return PanelController.defaultPanelWidth
    }

}
