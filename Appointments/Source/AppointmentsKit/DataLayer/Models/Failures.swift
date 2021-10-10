// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Failures : Codable {
    
    let id : Int?
    let occurrenceId : Int?
    let parentEventId : Int?
    let appointmentAttendance : [AttendanceResponse]?
    let error : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case occurrenceId = "i_occurrence_id"
        case parentEventId = "fk_parent_event_id"
        case appointmentAttendance = "appointmentAttendance"
        case error = "error"
    }

}

extension Failures {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        occurrenceId = try values.decodeIfPresent(Int.self, forKey: .occurrenceId)
        parentEventId = try values.decodeIfPresent(Int.self, forKey: .parentEventId)
        appointmentAttendance = try values.decodeIfPresent([AttendanceResponse].self, forKey: .appointmentAttendance)
        error = try values.decodeIfPresent(String.self, forKey: .error)
    }
    
}
