// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct AppointmentAttendance : Codable {
    
    let id : Int?
    let appointmentId : Int?
    let residentId : Int?
    let present : String?
    let reminderSent : String?
    let cancelReminder : String?
    let reminderSentTime : Int?
    let user : AppointmentUser?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case appointmentId = "fk_appointment_id"
        case residentId = "fk_resident_id"
        case present = "i_present"
        case reminderSent = "i_reminder_sent"
        case cancelReminder = "i_cancel_reminder"
        case reminderSentTime = "i_reminder_sent_time"
        case user = "user"
    }

}

extension AppointmentAttendance {
    
    init(){
        self.id = nil
        self.appointmentId = nil
        self.residentId = nil
        self.reminderSent = nil
        self.cancelReminder = nil
        self.reminderSentTime = nil
        self.user = nil
        self.present = nil
    }
    
    init(managedObject: CDAppointmentAttendance) {
        
        self.id = Int(managedObject.id)
        self.appointmentId = Int(managedObject.appointmentId)
        self.residentId = Int(managedObject.residentId)
        self.reminderSent = managedObject.reminderSent
        self.cancelReminder = managedObject.cancelReminder
        self.present = managedObject.present
        self.reminderSentTime = Int(managedObject.reminderSentTime)
        self.user = AppointmentUser(managedObject: managedObject.users ?? CDAppointmentUser())
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        appointmentId = try values.decodeIfPresent(Int.self, forKey: .appointmentId)
        residentId = try values.decodeIfPresent(Int.self, forKey: .residentId)
        present = try values.decodeIfPresent(String.self, forKey: .present)
        reminderSent = try values.decodeIfPresent(String.self, forKey: .reminderSent)
        cancelReminder = try values.decodeIfPresent(String.self, forKey: .cancelReminder)
        reminderSentTime = try values.decodeIfPresent(Int.self, forKey: .reminderSentTime)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
    }

}
