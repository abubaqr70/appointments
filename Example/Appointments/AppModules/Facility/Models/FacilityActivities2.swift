// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON
struct FacilityActivities2{
    
    var canEditActivities : Bool!
    var canViewActivities : Bool!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        canEditActivities = json["canEditActivities"].boolValue
        canViewActivities = json["canViewActivities"].boolValue
    }

}
