// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityStaffRole {
    
    var iIsEmployee : Int!
    var iIsPrivate : Int!
    var iIsProfile : Int!
    var id : Int!
    var vName : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        iIsEmployee = json["i_is_employee"].intValue
        iIsPrivate = json["i_is_private"].intValue
        iIsProfile = json["i_is_profile"].intValue
        id = json["id"].intValue
        vName = json["v_name"].stringValue
    }
    
}
