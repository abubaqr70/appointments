// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Appointment: Codable {
    
    let id : Int?
    let v_title : String?
    let v_location : String?
    let t_description : String?
    let i_occurrence_id : Int?
    let i_started_date : Int?
    let i_ended_date : Int?
    let i_is_reminder : Bool?
    let i_is_clinical : Int?
    let i_created : Int?
    let i_last_updated : Int?
    let i_is_critical : Bool?
    let i_is_therapy : Bool?
    let fk_therapy_id : Int?
    let fk_therapist_id : Int?
    let fk_group_id : Int?
    let fk_patient_id : Int?
    let fk_wing_id : Int?
    let v_note_to_staff : String?
    let event_length : Int?
    let rec_type : String?
    let rec_pattern : String?
    let is_rec : Bool?
    let fk_parent_event_id : Int?
    let fk_facility_id : Int?
    let fk_created_by_id : Int?
    let fk_updated_by_id : Int?
    let fk_resident_id : Int?
    let v_video_link : String?
    let event_pid : Int?
    let seriesStartDate : Int?
    let seriesEndDate : Int?
    let start_date : Start_date?
    let end_date : End_date?
    let appointmentTags : [AppointmentTags]?
    let appointmentAttendance : [AppointmentAttendance]?
    let user : AppointmentUser?
    let userGroup : UserGroup?
    let isAppointment : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case v_title = "v_title"
        case v_location = "v_location"
        case t_description = "t_description"
        case i_occurrence_id = "i_occurrence_id"
        case i_started_date = "i_started_date"
        case i_ended_date = "i_ended_date"
        case i_is_reminder = "i_is_reminder"
        case i_is_clinical = "i_is_clinical"
        case i_created = "i_created"
        case i_last_updated = "i_last_updated"
        case i_is_critical = "i_is_critical"
        case i_is_therapy = "i_is_therapy"
        case fk_therapy_id = "fk_therapy_id"
        case fk_therapist_id = "fk_therapist_id"
        case fk_group_id = "fk_group_id"
        case fk_patient_id = "fk_patient_id"
        case fk_wing_id = "fk_wing_id"
        case v_note_to_staff = "v_note_to_staff"
        case event_length = "event_length"
        case rec_type = "rec_type"
        case rec_pattern = "rec_pattern"
        case is_rec = "is_rec"
        case fk_parent_event_id = "fk_parent_event_id"
        case fk_facility_id = "fk_facility_id"
        case fk_created_by_id = "fk_created_by_id"
        case fk_updated_by_id = "fk_updated_by_id"
        case fk_resident_id = "fk_resident_id"
        case v_video_link = "v_video_link"
        case event_pid = "event_pid"
        case seriesStartDate = "seriesStartDate"
        case seriesEndDate = "seriesEndDate"
        case start_date = "start_date"
        case end_date = "end_date"
        case appointmentTags = "appointmentTags"
        case appointmentAttendance = "appointmentAttendance"
        case user = "user"
        case userGroup = "userGroup"
        case isAppointment = "isAppointment"
    }

}

extension Appointment {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        v_title = try values.decodeIfPresent(String.self, forKey: .v_title)
        v_location = try values.decodeIfPresent(String.self, forKey: .v_location)
        t_description = try values.decodeIfPresent(String.self, forKey: .t_description)
        i_occurrence_id = try values.decodeIfPresent(Int.self, forKey: .i_occurrence_id)
        i_started_date = try values.decodeIfPresent(Int.self, forKey: .i_started_date)
        i_ended_date = try values.decodeIfPresent(Int.self, forKey: .i_ended_date)
        i_is_reminder = try values.decodeIfPresent(Bool.self, forKey: .i_is_reminder)
        i_is_clinical = try values.decodeIfPresent(Int.self, forKey: .i_is_clinical)
        i_created = try values.decodeIfPresent(Int.self, forKey: .i_created)
        i_last_updated = try values.decodeIfPresent(Int.self, forKey: .i_last_updated)
        i_is_critical = try values.decodeIfPresent(Bool.self, forKey: .i_is_critical)
        i_is_therapy = try values.decodeIfPresent(Bool.self, forKey: .i_is_therapy)
        fk_therapy_id = try values.decodeIfPresent(Int.self, forKey: .fk_therapy_id)
        fk_therapist_id = try values.decodeIfPresent(Int.self, forKey: .fk_therapist_id)
        fk_group_id = try values.decodeIfPresent(Int.self, forKey: .fk_group_id)
        fk_patient_id = try values.decodeIfPresent(Int.self, forKey: .fk_patient_id)
        fk_wing_id = try values.decodeIfPresent(Int.self, forKey: .fk_wing_id)
        v_note_to_staff = try values.decodeIfPresent(String.self, forKey: .v_note_to_staff)
        event_length = try values.decodeIfPresent(Int.self, forKey: .event_length)
        rec_type = try values.decodeIfPresent(String.self, forKey: .rec_type)
        rec_pattern = try values.decodeIfPresent(String.self, forKey: .rec_pattern)
        is_rec = try values.decodeIfPresent(Bool.self, forKey: .is_rec)
        fk_parent_event_id = try values.decodeIfPresent(Int.self, forKey: .fk_parent_event_id)
        fk_facility_id = try values.decodeIfPresent(Int.self, forKey: .fk_facility_id)
        fk_created_by_id = try values.decodeIfPresent(Int.self, forKey: .fk_created_by_id)
        fk_updated_by_id = try values.decodeIfPresent(Int.self, forKey: .fk_updated_by_id)
        fk_resident_id = try values.decodeIfPresent(Int.self, forKey: .fk_resident_id)
        v_video_link = try values.decodeIfPresent(String.self, forKey: .v_video_link)
        event_pid = try values.decodeIfPresent(Int.self, forKey: .event_pid)
        seriesStartDate = try values.decodeIfPresent(Int.self, forKey: .seriesStartDate)
        seriesEndDate = try values.decodeIfPresent(Int.self, forKey: .seriesEndDate)
        start_date = try values.decodeIfPresent(Start_date.self, forKey: .start_date)
        end_date = try values.decodeIfPresent(End_date.self, forKey: .end_date)
        appointmentTags = try values.decodeIfPresent([AppointmentTags].self, forKey: .appointmentTags)
        appointmentAttendance = try values.decodeIfPresent([AppointmentAttendance].self, forKey: .appointmentAttendance)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
        userGroup = try values.decodeIfPresent(UserGroup.self, forKey: .userGroup)
        isAppointment = try values.decodeIfPresent(Bool.self, forKey: .isAppointment)
    }
    
}
