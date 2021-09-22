// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityCategory : Codable {
    
	let id : Int?
	let name : String?
	let facilityId : Int?
	let createdAt : Int?
	let updatedAt : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "v_name"
		case facilityId = "fk_facility_id"
		case createdAt = "i_created_at"
		case updatedAt = "i_updated_at"
	}
    
}

extension FacilityCategory {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(Int.self, forKey: .updatedAt)
    }
}
