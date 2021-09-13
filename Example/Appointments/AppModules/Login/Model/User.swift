// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct User : Codable{
    
    let iDisclaimer : Int?
    let iStatus : Bool?
    let id : Int?
    let passwordExpired : Bool?
    let profileImageRoute : String?
    let vApiKey : String?
    let vEmail : String?
    let vFirstName : String?
    let vLastName : String?
    let vPicture : String?
    let vRoleTitle : String?
    let vUsername : String?
    
    enum  CodingKeys : String, CodingKey  {
        
        case iDisclaimer = "i_disclaimer"
        case iStatus = "i_status"
        case id = "id"
        case passwordExpired = "passwordExpired"
        case profileImageRoute = "profileImageRoute"
        case vApiKey = "v_api_key"
        case vEmail = "v_email"
        case vFirstName = "v_first_name"
        case vLastName = "v_last_name"
        case vPicture = "v_picture"
        case vRoleTitle = "v_role_title"
        case vUsername = "v_username"
        
    }
    
}

extension User {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iDisclaimer = try values.decodeIfPresent(Int.self, forKey: .iDisclaimer)
        iStatus = try values.decodeIfPresent(Bool.self, forKey: .iStatus)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        passwordExpired = try values.decodeIfPresent(Bool.self, forKey: .passwordExpired)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        vApiKey = try values.decodeIfPresent(String.self, forKey: .vApiKey)
        vEmail = try values.decodeIfPresent(String.self, forKey: .vEmail)
        vFirstName = try values.decodeIfPresent(String.self, forKey: .vFirstName)
        vLastName = try values.decodeIfPresent(String.self, forKey: .vLastName)
        vPicture = try values.decodeIfPresent(String.self, forKey: .vPicture)
        vRoleTitle = try values.decodeIfPresent(String.self, forKey: .vRoleTitle)
        vUsername = try values.decodeIfPresent(String.self, forKey: .vUsername)
    }
}
