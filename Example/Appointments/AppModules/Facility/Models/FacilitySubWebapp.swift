// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilitySubWebapp {
    
    var fkFacilityId : Int!
    var fkWebappId : Int!
    var id : Int!
    var vName : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        fkFacilityId = json["fk_facility_id"].intValue
        fkWebappId = json["fk_webapp_id"].intValue
        id = json["id"].intValue
        vName = json["v_name"].stringValue
    }
}
