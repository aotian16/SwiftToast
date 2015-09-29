//
//  ViewController.swift
//  SwiftToastDemo
//
//  Created by 童进 on 15/9/29.
//  Copyright © 2015年 qefee. All rights reserved.
//

import UIKit
import SwiftToast

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTopButtonClick(sender: UIButton) {
        SwiftToast.show("top", duration: SwiftToast.DEFAULT_DISPLAY_DURATION, position: .top)
    }
    
    @IBAction func onCenterButtonClick(sender: UIButton) {
        SwiftToast.show("center", duration: SwiftToast.DEFAULT_DISPLAY_DURATION, position: .center)
    }
    
    @IBAction func onBottomButtonClick(sender: UIButton) {
        SwiftToast.show("bottom")
    }
    
    @IBAction func onActionButtonClick(sender: UIButton) {
        SwiftToast.show("click to fire action", tapAction: { (toast) -> Void in
            SwiftToast.show("toast taped", duration: SwiftToast.DEFAULT_DISPLAY_DURATION, position: .center)
        })
    }
    
    @IBAction func onCustomButtonClick(sender: UIButton) {
        let toast = SwiftToast.make("click to fire custom action")
        
        toast._offset = 30
        toast._duration = 3
        toast._position = .bottom
        toast._tapAction = {(toast) -> Void in
            SwiftToast.show("custom toast taped", duration: SwiftToast.DEFAULT_DISPLAY_DURATION, position: .center)}
        toast._animationDuration = 1
        toast._textLabel.textColor = UIColor.redColor()
        toast._contentView.backgroundColor = UIColor.yellowColor()
        
        toast.innerShow()
    }

}

