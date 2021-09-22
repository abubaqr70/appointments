// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentAttendance : Codable {
    
    let id : Int?
    let appointmentId : Int?
    let residentId : Int?
    let registered : Int?
    let present : String?
    let reminderSent : String?
    let cancelReminder : String?
    let reminderSentTime : Int?
    let created : Int?
    let updated : Int?
    let createdById : Int?
    let updatedById : Int?
    let user : AppointmentUser?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case appointmentId = "fk_appointment_id"
        case residentId = "fk_resident_id"
        case registered = "i_registered"
        case present = "i_present"
        case reminderSent = "i_reminder_sent"
        case cancelReminder = "i_cancel_reminder"
        case reminderSentTime = "i_reminder_sent_time"
        case created = "i_created"
        case updated = "i_updated"
        case createdById = "fk_created_by_id"
        case updatedById = "fk_updated_by_id"
        case user = "user"
    }

}

extension AppointmentAttendance {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        residentId = try values.decodeIfPresent(Int.self, forKey: .residentId)
        registered = try values.decodeIfPresent(Int.self, forKey: .registered)
        present = try values.decodeIfPresent(String.self, forKey: .present)
        reminderSent = try values.decodeIfPresent(String.self, forKey: .reminderSent)
        cancelReminder = try values.decodeIfPresent(String.self, forKey: .cancelReminder)
        reminderSentTime = try values.decodeIfPresent(Int.self, forKey: .reminderSentTime)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        updated = try values.decodeIfPresent(Int.self, forKey: .updated)
        createdById = try values.decodeIfPresent(Int.self, forKey: .createdById)
        updatedById = try values.decodeIfPresent(Int.self, forKey: .updatedById)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
    }

}
