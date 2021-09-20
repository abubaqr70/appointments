// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

extension Bundle {
    static var module: Bundle {
        return Bundle(for: AppDependencyContainer.self)
    }
    
    static var resource: Bundle {
        
        let bundle = Bundle.module
        guard let url = bundle.url(forResource: "Appointments", withExtension: "bundle") else  {
            return bundle
        }
        
        guard let resourceBundle = Bundle(url: url) else {
            return bundle
        }
        
        return resourceBundle
    }
}
