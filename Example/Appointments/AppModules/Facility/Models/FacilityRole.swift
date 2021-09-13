// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityRole {
    
    var fkArchivedBy : String!
    var fkCategoryId : String!
    var fkTenantId : Int!
    var iArchivedDate : String!
    var iIsArchived : Int!
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
        fkArchivedBy = json["fk_archived_by"].stringValue
        fkCategoryId = json["fk_category_id"].stringValue
        fkTenantId = json["fk_tenant_id"].intValue
        iArchivedDate = json["i_archived_date"].stringValue
        iIsArchived = json["i_is_archived"].intValue
        iIsEmployee = json["i_is_employee"].intValue
        iIsPrivate = json["i_is_private"].intValue
        iIsProfile = json["i_is_profile"].intValue
        id = json["id"].intValue
        vName = json["v_name"].stringValue
    }

}
