// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityClinicalReferral {
    
    var canManage : Bool!
    var canView : Bool!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        canManage = json["canManage"].boolValue
        canView = json["canView"].boolValue
    }
    
}
