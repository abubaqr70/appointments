// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Authorized_residents : Codable {
    
	let v_last_name : String?
	let v_mobile : String?
	let v_code_status : String?
	let v_room_no : String?
	let profileImageRoute : String?
	let i_is_archived : Int?
	let v_email : String?
	let v_first_name : String?
	let id : Int?
	let v_phone : String?

	enum CodingKeys: String, CodingKey {

		case v_last_name = "v_last_name"
		case v_mobile = "v_mobile"
		case v_code_status = "v_code_status"
		case v_room_no = "v_room_no"
		case profileImageRoute = "profileImageRoute"
		case i_is_archived = "i_is_archived"
		case v_email = "v_email"
		case v_first_name = "v_first_name"
		case id = "id"
		case v_phone = "v_phone"
	}

}

extension Authorized_residents {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        v_last_name = try values.decodeIfPresent(String.self, forKey: .v_last_name)
        v_mobile = try values.decodeIfPresent(String.self, forKey: .v_mobile)
        v_code_status = try values.decodeIfPresent(String.self, forKey: .v_code_status)
        v_room_no = try values.decodeIfPresent(String.self, forKey: .v_room_no)
        profileImageRoute = try values.decodeIfPresent(String.self, forKey: .profileImageRoute)
        i_is_archived = try values.decodeIfPresent(Int.self, forKey: .i_is_archived)
        v_email = try values.decodeIfPresent(String.self, forKey: .v_email)
        v_first_name = try values.decodeIfPresent(String.self, forKey: .v_first_name)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_phone = try values.decodeIfPresent(String.self, forKey: .v_phone)
    }

}
