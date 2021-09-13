// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityLevel {
    
    var id : Int!
    var vName : String!
    var vNumber : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        vName = json["v_name"].stringValue
        vNumber = json["v_number"].stringValue
    }

}
