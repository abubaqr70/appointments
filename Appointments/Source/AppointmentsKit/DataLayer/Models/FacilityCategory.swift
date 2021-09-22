// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct FacilityCategory : Codable {
    
	let id : Int?
	let v_name : String?
	let fk_facility_id : Int?
	let i_created_at : Int?
	let i_updated_at : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case v_name = "v_name"
		case fk_facility_id = "fk_facility_id"
		case i_created_at = "i_created_at"
		case i_updated_at = "i_updated_at"
	}
    
}

extension FacilityCategory {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
        i_created_at = try values.decodeIfPresent(Int.self, forKey: .i_created_at)
        i_updated_at = try values.decodeIfPresent(Int.self, forKey: .i_updated_at)
    }
}
