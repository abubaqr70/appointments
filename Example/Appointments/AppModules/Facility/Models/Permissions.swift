// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Permissions : Codable {
    
	let id : Int?
	let fk_permission_group_id : Int?
	let v_permission : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case fk_permission_group_id = "fk_permission_group_id"
		case v_permission = "v_permission"
	}

}

extension Permissions {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fk_permission_group_id = try values.decodeIfPresent(Int.self, forKey: .fk_permission_group_id)
        v_permission = try values.decodeIfPresent(String.self, forKey: .v_permission)
    }

}
