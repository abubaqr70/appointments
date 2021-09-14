// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit

extension UIStoryboard {
    
    class func initial<T: UIViewController>(storyboard: StoryboardEnum) -> T {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateInitialViewController() as! T
    }
    
    func initiate<T: UIViewController>()->T{
        return instantiateViewController(withIdentifier: T.className) as! T
    }
    
    enum StoryboardEnum: String {
        case Main = "Main"
    }
}


enum Storyboard {
    
    static var Main: UIStoryboard{
        return UIStoryboard(name: UIStoryboard.StoryboardEnum.Main.rawValue, bundle: nil)
    }
}

extension NSObject {
    class var className: String {
        return String(describing: self.self)
    }
}
