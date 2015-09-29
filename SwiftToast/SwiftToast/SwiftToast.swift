//
//  SwiftToast.swift
//  SwiftToastDemo
//
//  Created by 童进 on 15/8/11.
//  Copyright (c) 2015年 qefee. All rights reserved.
//

import UIKit



/// toast class
public class SwiftToast: UIView {
    
    /// positon to show toast
    enum SwiftToastPosition {
        case top
        case center
        case bottom
    }
    
    static let DEFAULT_DISPLAY_DURATION: NSTimeInterval = 2.0
    static let DEFAULT_OFFSET: CGFloat = 20
    static let DEFAULT_ANIMATION_DURATION: NSTimeInterval = 0.3
    
    /// text to show
    var _text: String = ""
    
    /// label to show
    var _textLabel: UILabel!
    
    /// content view
    var _contentView: UIButton!
    
    /// duration
    var _duration: NSTimeInterval = SwiftToast.DEFAULT_DISPLAY_DURATION
    
    /// toast tap action
    var _tapAction: ((SwiftToast) -> Void)?
    
    /// offset to top or bottom(default is 20)
    var _offset:CGFloat = DEFAULT_OFFSET
    
    /// positon to show toast(default is bottom)
    var _position = SwiftToastPosition.bottom
    
    /// animation duration
    var _animationDuration = DEFAULT_ANIMATION_DURATION
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text:String) {
        
        super.init(frame: CGRectMake(0, 0, 0, 0))
        
        self._text = text
        
        let fontSize:CGFloat = 14.0
        let font = UIFont.boldSystemFontOfSize(fontSize)
        
        let textSize: CGSize = NSString(string: text).boundingRectWithSize(CGSizeMake(CGFloat(UIScreen.mainScreen().applicationFrame.width - 40), CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
        
        let textLabel: UILabel = UILabel(frame: CGRectMake(0, 0, textSize.width+12, textSize.height+12))
        self._textLabel = textLabel
        
        textLabel.backgroundColor = UIColor.clearColor()
        textLabel.textColor = UIColor.whiteColor()
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.font = font
        textLabel.text = text
        textLabel.numberOfLines = 0
        
        self._contentView = UIButton(frame: CGRectMake(0, 0, textLabel.frame.width, textLabel.frame.height))
        self._contentView.layer.cornerRadius = 5.0
        self._contentView.layer.masksToBounds = true
        self._contentView.layer.borderWidth = 1.0
        self._contentView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(CGFloat(0.5)).CGColor
        self._contentView.backgroundColor = UIColor(red: CGFloat(0.2), green: CGFloat(0.2), blue: CGFloat(0.2), alpha: CGFloat(0.75))
        
        self._contentView.addSubview(textLabel)
        self._contentView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        self._contentView.alpha = 0.0
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    class func make(text:String) -> SwiftToast {
        
        let toast = SwiftToast(text: text)
        
        toast._contentView.addTarget(toast, action: "toastTaped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        NSNotificationCenter.defaultCenter().addObserver(toast, selector: "deviceOrientationDidChanged:", name: UIDeviceOrientationDidChangeNotification, object: UIDevice.currentDevice())
        
        return toast
    }
    
    func deviceOrientationDidChanged(notification:NSNotification) {
        hideAnimation()
    }
    
    /// dissmiss toast
    private func dissmiss() {
        _contentView.removeFromSuperview()
    }
    
    /// action on toast taped
    func toastTaped(sender: UIButton) {
        if let action = _tapAction {
            action(self)
        } else {
            dissmiss()
        }
    }
    
    /// show toast with animation
    private func showAnimation() {
        UIView.animateWithDuration(_animationDuration, animations: { () -> Void in
            self._contentView.alpha = 1.0
            }) { (finish: Bool) -> Void in
                // do nothing
        }
    }
    
    /// hide toast with animation
    func hideAnimation() {
        UIView.animateWithDuration(_animationDuration, animations: { () -> Void in
            self._contentView.alpha = 0.0
            }) { (finish: Bool) -> Void in
                self.dissmiss()
        }
    }
    
    /// show toast by instance
    func innerShow() {
        
        let window:UIWindow? = UIApplication.sharedApplication().keyWindow
        
        if let w = window {
            switch _position {
            case SwiftToastPosition.bottom:
                _contentView.center = CGPointMake(w.center.x, w.frame.height - (_contentView.frame.height/2 + _offset))
            case SwiftToastPosition.center:
                _contentView.center = w.center
            default:
                _contentView.center = CGPointMake(w.center.x, _contentView.frame.height/2 + _offset)
            }
            w.addSubview(_contentView)
            showAnimation()
            NSTimer.scheduledTimerWithTimeInterval(_duration, target: self, selector: "hideAnimation", userInfo: nil, repeats: false)
        }
    }
    
    /// show toast
    class func show(message: String, duration: NSTimeInterval, position: SwiftToastPosition, tapAction: ((SwiftToast) -> Void)? = nil) {
        
        let toast = SwiftToast.make(message)
        
        toast._duration = duration
        toast._position = position
        toast._tapAction = tapAction
        
        toast.innerShow()
    }
    
    /// show toast
    class func show(message: String, tapAction: ((SwiftToast) -> Void)? = nil) {
        show(message, duration: SwiftToast.DEFAULT_DISPLAY_DURATION, position: SwiftToastPosition.bottom, tapAction: tapAction)
    }
    
    /// show toast
    class func show(message: String, duration: NSTimeInterval, tapAction: ((SwiftToast) -> Void)? = nil) {
        show(message, duration: duration, position: SwiftToastPosition.bottom, tapAction: tapAction)
    }
}
