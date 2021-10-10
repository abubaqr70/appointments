// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AttendanceResponse : Codable {
    
    let appointmentId : Int?
    let residentId : Int?
    let registered : Int?
    let present : String?

    enum CodingKeys: String, CodingKey {

        case appointmentId = "fk_appointment_id"
        case residentId = "fk_resident_id"
        case registered = "i_registered"
        case present = "i_present"
    }

}

extension AttendanceResponse {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        residentId = try values.decodeIfPresent(Int.self, forKey: .residentId)
        registered = try values.decodeIfPresent(Int.self, forKey: .registered)
        present = try values.decodeIfPresent(String.self, forKey: .present)
    }
    
}
