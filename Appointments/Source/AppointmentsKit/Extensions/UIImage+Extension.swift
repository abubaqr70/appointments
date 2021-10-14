// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

extension UIImage {
    
    static func moduleImage(named: String,
                            bundle: Bundle = Bundle.resource) -> UIImage? {
        
        return UIImage(named: named,
                       in: bundle,
                       compatibleWith: nil)
        
    }
    
}
