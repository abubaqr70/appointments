// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityGroupMembers : Codable {
    
	let id : Int?
	let userId : Int?
	let groupId : Int?
	let memberType : String?
	let createdAt : Int?
	let updatedAt : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case userId = "userId"
		case groupId = "fk_group_id"
		case memberType = "v_member_type"
		case createdAt = "i_created_at"
		case updatedAt = "i_updated_at"
	}
}

extension FacilityGroupMembers {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
        memberType = try values.decodeIfPresent(String.self, forKey: .memberType)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }
}
