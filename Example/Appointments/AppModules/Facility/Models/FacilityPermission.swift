// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityPermission {
    
    var fkPermissionGroupId : Int!
    var id : Int!
    var vPermission : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fkPermissionGroupId = json["fk_permission_group_id"].intValue
        id = json["id"].intValue
        vPermission = json["v_permission"].stringValue
    }
    
}
