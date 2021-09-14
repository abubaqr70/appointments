// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct SubWebapps : Codable {
    
	let id : Int?
	let v_name : String?
	let fk_facility_id : Int?
	let fk_webapp_id : Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case v_name = "v_name"
		case fk_facility_id = "fk_facility_id"
		case fk_webapp_id = "fk_webapp_id"
	}

}

extension SubWebapps {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_name = try values.decodeIfPresent(String.self, forKey: .v_name)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
        fk_webapp_id = try values.decodeIfPresent(Int.self, forKey: .fk_webapp_id)
    }
    
}
