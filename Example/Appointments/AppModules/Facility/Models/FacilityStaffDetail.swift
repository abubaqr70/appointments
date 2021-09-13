// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct FacilityStaffDetail{
    
    var iIsArchived : Int!
    var id : Int!
    var profileImageRoute : String!
    var vCodeStatus : String!
    var vEmail : String!
    var vFirstName : String!
    var vLastName : String!
    var vMobile : String!
    var vPhone : String!
    var vRoomNo : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        iIsArchived = json["i_is_archived"].intValue
        id = json["id"].intValue
        profileImageRoute = json["profileImageRoute"].stringValue
        vCodeStatus = json["v_code_status"].stringValue
        vEmail = json["v_email"].stringValue
        vFirstName = json["v_first_name"].stringValue
        vLastName = json["v_last_name"].stringValue
        vMobile = json["v_mobile"].stringValue
        vPhone = json["v_phone"].stringValue
        vRoomNo = json["v_room_no"].stringValue
    }

}
