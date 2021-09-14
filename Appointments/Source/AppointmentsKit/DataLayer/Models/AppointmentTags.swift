// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentTags : Codable {
    
	let id : Int?
	let fk_appointment_id : Int?
	let fk_tag_id : Int?
	let v_tag_actual_text : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case fk_appointment_id = "fk_appointment_id"
		case fk_tag_id = "fk_tag_id"
		case v_tag_actual_text = "v_tag_actual_text"
	}

}

extension AppointmentTags {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fk_appointment_id = try values.decodeIfPresent(Int.self, forKey: .fk_appointment_id)
        fk_tag_id = try values.decodeIfPresent(Int.self, forKey: .fk_tag_id)
        v_tag_actual_text = try values.decodeIfPresent(String.self, forKey: .v_tag_actual_text)
    }

}
