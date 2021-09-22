// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityGroupMembers : Codable {
    
	let id : Int?
	let fk_user_id : Int?
	let fk_group_id : Int?
	let v_member_type : String?
	let i_created_at : Int?
	let i_updated_at : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case fk_user_id = "fk_user_id"
		case fk_group_id = "fk_group_id"
		case v_member_type = "v_member_type"
		case i_created_at = "i_created_at"
		case i_updated_at = "i_updated_at"
	}
}

extension FacilityGroupMembers {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fk_user_id = try values.decodeIfPresent(Int.self, forKey: .fk_user_id)
        fk_group_id = try values.decodeIfPresent(Int.self, forKey: .fk_group_id)
        v_member_type = try values.decodeIfPresent(String.self, forKey: .v_member_type)
        i_created_at = try values.decodeIfPresent(Int.self, forKey: .i_created_at)
        i_updated_at = try values.decodeIfPresent(Int.self, forKey: .i_updated_at)
    }
}
