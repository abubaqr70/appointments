// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityShift {
    
    var endTime : Int!
    var fkFacilityId : Int!
    var iCreatedAt : Int!
    var iUpdatedAt : Int!
    var id : Int!
    var startTime : Int!
    var vName : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        endTime = json["end_time"].intValue
        fkFacilityId = json["fk_facility_id"].intValue
        iCreatedAt = json["i_created_at"].intValue
        iUpdatedAt = json["i_updated_at"].intValue
        id = json["id"].intValue
        startTime = json["start_time"].intValue
        vName = json["v_name"].stringValue
    }

}
