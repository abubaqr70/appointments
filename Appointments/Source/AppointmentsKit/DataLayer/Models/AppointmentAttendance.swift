// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentAttendance : Codable {
    
    let id : Int?
    let fk_appointment_id : Int?
    let fk_resident_id : Int?
    let i_registered : Int?
    let i_present : String?
    let i_reminder_sent : String?
    let i_cancel_reminder : String?
    let i_reminder_sent_time : Int?
    let i_created : Int?
    let i_updated : Int?
    let fk_created_by_id : Int?
    let fk_updated_by_id : Int?
    let user : AppointmentUser?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case fk_appointment_id = "fk_appointment_id"
        case fk_resident_id = "fk_resident_id"
        case i_registered = "i_registered"
        case i_present = "i_present"
        case i_reminder_sent = "i_reminder_sent"
        case i_cancel_reminder = "i_cancel_reminder"
        case i_reminder_sent_time = "i_reminder_sent_time"
        case i_created = "i_created"
        case i_updated = "i_updated"
        case fk_created_by_id = "fk_created_by_id"
        case fk_updated_by_id = "fk_updated_by_id"
        case user = "user"
    }

}

extension AppointmentAttendance {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        fk_appointment_id = try values.decodeIfPresent(Int.self, forKey: .fk_appointment_id)
        fk_resident_id = try values.decodeIfPresent(Int.self, forKey: .fk_resident_id)
        i_registered = try values.decodeIfPresent(Int.self, forKey: .i_registered)
        i_present = try values.decodeIfPresent(String.self, forKey: .i_present)
        i_reminder_sent = try values.decodeIfPresent(String.self, forKey: .i_reminder_sent)
        i_cancel_reminder = try values.decodeIfPresent(String.self, forKey: .i_cancel_reminder)
        i_reminder_sent_time = try values.decodeIfPresent(Int.self, forKey: .i_reminder_sent_time)
        i_created = try values.decodeIfPresent(Int.self, forKey: .i_created)
        i_updated = try values.decodeIfPresent(Int.self, forKey: .i_updated)
        fk_created_by_id = try values.decodeIfPresent(Int.self, forKey: .fk_created_by_id)
        fk_updated_by_id = try values.decodeIfPresent(Int.self, forKey: .fk_updated_by_id)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
    }

}
