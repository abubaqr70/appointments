// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import SwiftyJSON

struct User{
    var iDisclaimer : Int!
    var iStatus : Bool!
    var id : Int!
    var passwordExpired : Bool!
    var profileImageRoute : String!
    var vApiKey : String!
    var vEmail : String!
    var vFirstName : String!
    var vLastName : String!
    var vPicture : String!
    var vRoleTitle : String!
    var vUsername : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        iDisclaimer = json["i_disclaimer"].intValue
        iStatus = json["i_status"].boolValue
        id = json["id"].intValue
        passwordExpired = json["passwordExpired"].boolValue
        profileImageRoute = json["profileImageRoute"].stringValue
        vApiKey = json["v_api_key"].stringValue
        vEmail = json["v_email"].stringValue
        vFirstName = json["v_first_name"].stringValue
        vLastName = json["v_last_name"].stringValue
        vPicture = json["v_picture"].stringValue
        vRoleTitle = json["v_role_title"].stringValue
        vUsername = json["v_username"].stringValue
    }
    
}
