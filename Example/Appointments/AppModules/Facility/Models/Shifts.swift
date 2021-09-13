// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Shifts : Codable {
    
	let end_time : Int?
	let start_time : Int?
	let i_created_at : Int?
	let fk_facility_id : Int?
	let i_updated_at : Int?
	let id : Int?
	let v_name : String?

	enum CodingKeys: String, CodingKey {

		case end_time = "end_time"
		case start_time = "start_time"
		case i_created_at = "i_created_at"
		case fk_facility_id = "fk_facility_id"
		case i_updated_at = "i_updated_at"
		case id = "id"
		case v_name = "v_name"
	}

}

extension Shifts {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        end_time = try values.decodeIfPresent(Int.self, forKey: .end_time)
        start_time = try values.decodeIfPresent(Int.self, forKey: .start_time)
        i_created_at = try values.decodeIfPresent(Int.self, forKey: .i_created_at)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
        i_updated_at = try values.decodeIfPresent(Int.self, forKey: .i_updated_at)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
    }

}
