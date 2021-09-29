// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

struct Appointment: Codable {
    
    let id : Int?
    let title : String?
    let location : String?
    let description : String?
    let occurrenceId : Int?
    let isTherapy : Bool?
    let therapyId : Int?
    let therapistId : Int?
    let groupId : Int?
    let parentEventId : Int?
    let facilityId : Int?
    let residentId : Int?
    let startDate : StartDate?
    let endDate : EndDate?
    var appointmentTags : [AppointmentTag]?
    var appointmentAttendance : [AppointmentAttendance]?
    let user : AppointmentUser?
    let userGroup : UserGroup?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "v_title"
        case location = "v_location"
        case description = "t_description"
        case occurrenceId = "i_occurrence_id"
        case isTherapy = "i_is_therapy"
        case therapyId = "fk_therapy_id"
        case therapistId = "fk_therapist_id"
        case groupId = "fk_group_id"
        case parentEventId = "fk_parent_event_id"
        case facilityId = "fk_facility_id"
        case residentId = "fk_resident_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case appointmentTags = "appointmentTags"
        case appointmentAttendance = "appointmentAttendance"
        case user = "user"
        case userGroup = "userGroup"
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
        isTherapy = try values.decodeIfPresent(Bool.self, forKey: .isTherapy)
        therapyId = try values.decodeIfPresent(Int.self, forKey: .therapyId)
        therapistId = try values.decodeIfPresent(Int.self, forKey: .therapistId)
        groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
        parentEventId = try values.decodeIfPresent(Int.self, forKey: .parentEventId)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        residentId = try values.decodeIfPresent(Int.self, forKey: .residentId)
        startDate = try values.decodeIfPresent(StartDate.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(EndDate.self, forKey: .endDate)
        appointmentTags = try values.decodeIfPresent([AppointmentTag].self, forKey: .appointmentTags)
        appointmentAttendance = try values.decodeIfPresent([AppointmentAttendance].self, forKey: .appointmentAttendance)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
        userGroup = try values.decodeIfPresent(UserGroup.self, forKey: .userGroup)
    }
    
    init(managedObject: CDAppointment) {
        
        self.id = Int(managedObject.id)
        self.title = managedObject.title
        self.location = managedObject.location
        self.description = managedObject.descriptions
        self.occurrenceId = Int(managedObject.occurrenceId)
        self.isTherapy = managedObject.isTherapy
        self.therapistId = Int(managedObject.therapistId)
        self.facilityId = Int(managedObject.facilityId)
        self.residentId = Int(managedObject.residentId)
        self.therapyId = Int(managedObject.therapyId)
        self.groupId = Int(managedObject.groupId)
        self.parentEventId = Int(managedObject.parentEventId)
        self.startDate = StartDate(managedObject: managedObject.startDate ?? CDStartDate())
        self.endDate = EndDate(managedObject: managedObject.endDate ?? CDEndDate())
        self.user = AppointmentUser(managedObject: managedObject.user ?? CDAppointmentUser())
        self.userGroup = UserGroup(managedObject: managedObject.userGroup ?? CDUserGroup())
        self.appointmentTags = []
        for appointmentTag in managedObject.appointmentTag?.allObjects as? [CDAppointmentTags] ?? []{
            self.appointmentTags?.append(AppointmentTag(managedObject: appointmentTag))
        }
        self.appointmentAttendance = []
        for appointmentAttendance in managedObject.appointmentAttendance?.allObjects as? [CDAppointmentAttendance] ?? []{
            self.appointmentAttendance?.append(AppointmentAttendance(managedObject: appointmentAttendance))
        }
    }
}
