// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Staff : Codable {
    
	let id : Int?
	let roles : [Roles]?
	let fk_facility_id : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case roles = "roles"
		case fk_facility_id = "fk_facility_id"
	}

}

extension Staff{
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        roles = try values.decodeIfPresent([Roles].self, forKey: .roles)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
    }

}
