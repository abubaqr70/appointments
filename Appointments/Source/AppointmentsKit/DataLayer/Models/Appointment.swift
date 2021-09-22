// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Appointment: Codable {
    
    let id : Int?
    let title : String?
    let location : String?
    let description : String?
    let occurrenceId : Int?
    let startedDate : Int?
    let endedDate : Int?
    let isReminder : Bool?
    let isClinical : Int?
    let created : Int?
    let lastUpdated : Int?
    let isCritical : Bool?
    let isTherapy : Bool?
    let therapyId : Int?
    let therapistId : Int?
    let groupId : Int?
    let patientId : Int?
    let wingId : Int?
    let noteToStaff : String?
    let eventLength : Int?
    let recType : String?
    let recPattern : String?
    let isRec : Bool?
    let parentEventId : Int?
    let facilityId : Int?
    let createdById : Int?
    let updatedById : Int?
    let residentId : Int?
    let videoLink : String?
    let eventPid : Int?
    let seriesStartDate : Int?
    let seriesEndDate : Int?
    let startDate : StartDate?
    let endDate : EndDate?
    let appointmentTags : [AppointmentTag]?
    let appointmentAttendance : [AppointmentAttendance]?
    let user : AppointmentUser?
    let userGroup : UserGroup?
    let isAppointment : Bool?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "v_title"
        case location = "v_location"
        case description = "t_description"
        case occurrenceId = "i_occurrence_id"
        case startedDate = "i_started_date"
        case endedDate = "i_ended_date"
        case isReminder = "i_is_reminder"
        case isClinical = "i_is_clinical"
        case created = "i_created"
        case lastUpdated = "i_last_updated"
        case isCritical = "i_is_critical"
        case isTherapy = "i_is_therapy"
        case therapyId = "fk_therapy_id"
        case therapistId = "fk_therapist_id"
        case groupId = "fk_group_id"
        case patientId = "fk_patient_id"
        case wingId = "fk_wing_id"
        case noteToStaff = "v_note_to_staff"
        case eventLength = "event_length"
        case recType = "rec_type"
        case recPattern = "rec_pattern"
        case isRec = "is_rec"
        case parentEventId = "fk_parent_event_id"
        case facilityId = "fk_facility_id"
        case createdById = "fk_created_by_id"
        case updatedById = "fk_updated_by_id"
        case residentId = "fk_resident_id"
        case videoLink = "v_video_link"
        case eventPid = "event_pid"
        case seriesStartDate = "seriesStartDate"
        case seriesEndDate = "seriesEndDate"
        case startDate = "start_date"
        case endDate = "end_date"
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
        title = try values.decodeIfPresent(String.self, forKey: .title)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        occurrenceId = try values.decodeIfPresent(Int.self, forKey: .occurrenceId)
        startedDate = try values.decodeIfPresent(Int.self, forKey: .startedDate)
        endedDate = try values.decodeIfPresent(Int.self, forKey: .endedDate)
        isReminder = try values.decodeIfPresent(Bool.self, forKey: .isReminder)
        isClinical = try values.decodeIfPresent(Int.self, forKey: .isClinical)
        created = try values.decodeIfPresent(Int.self, forKey: .created)
        lastUpdated = try values.decodeIfPresent(Int.self, forKey: .lastUpdated)
        isCritical = try values.decodeIfPresent(Bool.self, forKey: .isCritical)
        isTherapy = try values.decodeIfPresent(Bool.self, forKey: .isTherapy)
        therapyId = try values.decodeIfPresent(Int.self, forKey: .therapyId)
        therapistId = try values.decodeIfPresent(Int.self, forKey: .therapistId)
        groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
        patientId = try values.decodeIfPresent(Int.self, forKey: .patientId)
        wingId = try values.decodeIfPresent(Int.self, forKey: .wingId)
        noteToStaff = try values.decodeIfPresent(String.self, forKey: .noteToStaff)
        eventLength = try values.decodeIfPresent(Int.self, forKey: .eventLength)
        recType = try values.decodeIfPresent(String.self, forKey: .recType)
        recPattern = try values.decodeIfPresent(String.self, forKey: .recPattern)
        isRec = try values.decodeIfPresent(Bool.self, forKey: .isRec)
        parentEventId = try values.decodeIfPresent(Int.self, forKey: .parentEventId)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        createdById = try values.decodeIfPresent(Int.self, forKey: .createdById)
        updatedById = try values.decodeIfPresent(Int.self, forKey: .updatedById)
        residentId = try values.decodeIfPresent(Int.self, forKey: .residentId)
        videoLink = try values.decodeIfPresent(String.self, forKey: .videoLink)
        eventPid = try values.decodeIfPresent(Int.self, forKey: .eventPid)
        seriesStartDate = try values.decodeIfPresent(Int.self, forKey: .seriesStartDate)
        seriesEndDate = try values.decodeIfPresent(Int.self, forKey: .seriesEndDate)
        startDate = try values.decodeIfPresent(StartDate.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(EndDate.self, forKey: .endDate)
        appointmentTags = try values.decodeIfPresent([AppointmentTag].self, forKey: .appointmentTags)
        appointmentAttendance = try values.decodeIfPresent([AppointmentAttendance].self, forKey: .appointmentAttendance)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
        userGroup = try values.decodeIfPresent(UserGroup.self, forKey: .userGroup)
        isAppointment = try values.decodeIfPresent(Bool.self, forKey: .isAppointment)
    }
    
}
