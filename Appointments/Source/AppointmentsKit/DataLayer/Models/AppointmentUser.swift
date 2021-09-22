// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentUser : Codable {
    
    let imageContent : String?
    let fullName : String?
    let profileImageRoute : String?
    let thumbnail : String?
    let passwordChangedDuration : String?
    let full_Name : String?
    let gender : String?
    let initials : String?
    let formattedAdmissionDate : String?
    let occupation : String?
    let id : Int?
    let firstName : String?
    let lastName : String?
    let roomNo : String?
    let picture : String?

    enum CodingKeys: String, CodingKey {

        case imageContent = "imageContent"
        case fullName = "fullname"
        case profileImageRoute = "profileImageRoute"
        case thumbnail = "thumbnail"
        case passwordChangedDuration = "passwordChangedDuration"
        case full_Name = "full_name"
        case gender = "gender"
        case initials = "initials"
        case formattedAdmissionDate = "formattedAdmissionDate"
        case occupation = "occupation"
        case id = "id"
        case firstName = "v_first_name"
        case lastName = "v_last_name"
        case roomNo = "v_room_no"
        case picture = "v_picture"
    }

}

extension AppointmentUser {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageContent = try values.decodeIfPresent(String.self, forKey: .imageContent)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        passwordChangedDuration = try values.decodeIfPresent(String.self, forKey: .passwordChangedDuration)
        full_Name = try values.decodeIfPresent(String.self, forKey: .full_Name)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        initials = try values.decodeIfPresent(String.self, forKey: .initials)
        formattedAdmissionDate = try values.decodeIfPresent(String.self, forKey: .formattedAdmissionDate)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        roomNo = try values.decodeIfPresent(String.self, forKey: .roomNo)
        picture = try values.decodeIfPresent(String.self, forKey: .picture)
    }

}
