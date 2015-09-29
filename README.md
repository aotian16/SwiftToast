# SwiftToast
An android like toast lib write in swift

<img src="https://github.com/aotian16/SwiftToast/blob/master/image/screen_shot.png" width="188px" height="334px" />

# install
just copy SwiftToast.swift to your project

# use

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
    
# license
MIT
