// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentTag : Codable {
    
	let id : Int?
	let appointmentId : Int?
	let tagId : Int?
	let tagActualText : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case appointmentId = "fk_appointment_id"
		case tagId = "fk_tag_id"
		case tagActualText = "v_tag_actual_text"
	}

}

extension AppointmentTag {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        tagId = try values.decodeIfPresent(Int.self, forKey: .tagId)
        tagActualText = try values.decodeIfPresent(String.self, forKey: .tagActualText)
    }

}
