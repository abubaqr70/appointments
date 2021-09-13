// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityModel {
    
    var details : FacilityDetail!
    var facilities : [Facility]!
    var isTenant : Bool!
    var tenant : FacilityTenant!
    var user : FacilityUser!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let detailsJson = json["details"]
        if !detailsJson.isEmpty{
            details = FacilityDetail(fromJson: detailsJson)
        }
        facilities = [Facility]()
        let facilitiesArray = json["facilities"].arrayValue
        for facilitiesJson in facilitiesArray{
            let value = Facility(fromJson: facilitiesJson)
            facilities.append(value)
        }
        isTenant = json["isTenant"].boolValue
        let tenantJson = json["tenant"]
        if !tenantJson.isEmpty{
            tenant = FacilityTenant(fromJson: tenantJson)
        }
        let userJson = json["user"]
        if !userJson.isEmpty{
            user = FacilityUser(fromJson: userJson)
        }
    }
}

