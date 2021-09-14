// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentUser : Codable {
    
	let imageContent : String?
	let fullname : String?
	let profileImageRoute : String?
	let thumbnail : String?
	let passwordChangedDuration : String?
	let full_name : String?
	let gender : String?
	let initials : String?
	let formattedAdmissionDate : String?
	let occupation : String?
	let id : Int?
	let v_first_name : String?
	let v_last_name : String?
	let v_room_no : String?
	let v_picture : String?

	enum CodingKeys: String, CodingKey {

		case imageContent = "imageContent"
		case fullname = "fullname"
		case profileImageRoute = "profileImageRoute"
		case thumbnail = "thumbnail"
		case passwordChangedDuration = "passwordChangedDuration"
		case full_name = "full_name"
		case gender = "gender"
		case initials = "initials"
		case formattedAdmissionDate = "formattedAdmissionDate"
		case occupation = "occupation"
		case id = "id"
		case v_first_name = "v_first_name"
		case v_last_name = "v_last_name"
		case v_room_no = "v_room_no"
		case v_picture = "v_picture"
	}

}

extension AppointmentUser {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageContent = try values.decodeIfPresent(String.self, forKey: .imageContent)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        passwordChangedDuration = try values.decodeIfPresent(String.self, forKey: .passwordChangedDuration)
        full_name = try values.decodeIfPresent(String.self, forKey: .full_name)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        initials = try values.decodeIfPresent(String.self, forKey: .initials)
        formattedAdmissionDate = try values.decodeIfPresent(String.self, forKey: .formattedAdmissionDate)
        occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_first_name = try values.decodeIfPresent(String.self, forKey: .v_first_name)
        v_last_name = try values.decodeIfPresent(String.self, forKey: .v_last_name)
        v_room_no = try values.decodeIfPresent(String.self, forKey: .v_room_no)
        v_picture = try values.decodeIfPresent(String.self, forKey: .v_picture)
    }

}
