// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityEmarConfig {
    
    var fkFacilityId : Int!
    var iPastDueWindow : Int!
    var id : Int!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fkFacilityId = json["fk_facility_id"].intValue
        iPastDueWindow = json["i_past_due_window"].intValue
        id = json["id"].intValue
    }
}
