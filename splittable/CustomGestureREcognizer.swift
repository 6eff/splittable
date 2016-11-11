import UIKit
import UIKit.UIGestureRecognizerSubclass

class CustomGestureRecognizer : UITapGestureRecognizer {
    
    var url : String?
    // any more custom variables here
    
    init(target: AnyObject?, action: Selector, url : String) {
        super.init(target: target, action: action)
        
        self.url = url
    }
    
}
