// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import UIKit

struct APPURL{
        
    static var Domain: String {
        return "https://api.caremerge.com/"
    }
    
    static var Login: String{
        return Domain + "login"
    }
    
    static var Facility: String{
        return Domain + "user-context/details"
    }
}



