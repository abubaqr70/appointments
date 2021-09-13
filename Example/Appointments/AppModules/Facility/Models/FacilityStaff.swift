// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityStaff {
    
    var fkFacilityId : Int!
    var id : Int!
    var roles : [FacilityStaffRole]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fkFacilityId = json["fk_facility_id"].intValue
        id = json["id"].intValue
        roles = [FacilityStaffRole]()
        let rolesArray = json["roles"].arrayValue
        for rolesJson in rolesArray{
            let value = FacilityStaffRole(fromJson: rolesJson)
            roles.append(value)
        }
    }

}
