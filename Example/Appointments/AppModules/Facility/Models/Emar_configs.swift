// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Emar_configs : Codable {
    
	let id : Int?
	let i_past_due_window : Int?
	let fk_facility_id : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case i_past_due_window = "i_past_due_window"
		case fk_facility_id = "fk_facility_id"
	}

}

extension Emar_configs {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        i_past_due_window = try values.decodeIfPresent(Int.self, forKey: .i_past_due_window)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
    }

}
