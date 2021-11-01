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
    let startingDate : Double?
    let endingDate : Double?
    let eventLength : Int?
    let lastUpdatedTime : Date?
    let month : Int?
    let year : Int?
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
        case startingDate = "i_started_date"
        case endingDate = "i_ended_date"
        case parentEventId = "fk_parent_event_id"
        case facilityId = "fk_facility_id"
        case residentId = "fk_resident_id"
        case eventLength = "event_length"
        case startDate = "start_date"
        case endDate = "end_date"
        case appointmentTags = "appointmentTags"
        case appointmentAttendance = "appointmentAttendance"
        case user = "user"
        case userGroup = "userGroup"
        case lastUpdatedTime = "lastUpdatedTime"
        case month = "monthmonth"
        case year = "yearyear"
        
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
        startingDate = try values.decodeIfPresent(Double.self, forKey: .startingDate)
        endingDate = try values.decodeIfPresent(Double.self, forKey: .endingDate)
        therapyId = try values.decodeIfPresent(Int.self, forKey: .therapyId)
        therapistId = try values.decodeIfPresent(Int.self, forKey: .therapistId)
        groupId = try values.decodeIfPresent(Int.self, forKey: .groupId)
        parentEventId = try values.decodeIfPresent(Int.self, forKey: .parentEventId)
        facilityId = try values.decodeIfPresent(Int.self, forKey: .facilityId)
        residentId = try values.decodeIfPresent(Int.self, forKey: .residentId)
        eventLength = try values.decodeIfPresent(Int.self, forKey: .eventLength)
        startDate = try values.decodeIfPresent(StartDate.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(EndDate.self, forKey: .endDate)
        lastUpdatedTime = try values.decodeIfPresent(Date.self, forKey: .lastUpdatedTime)
        appointmentTags = try values.decodeIfPresent([AppointmentTag].self, forKey: .appointmentTags)
        appointmentAttendance = try values.decodeIfPresent([AppointmentAttendance].self, forKey: .appointmentAttendance)
        user = try values.decodeIfPresent(AppointmentUser.self, forKey: .user)
        userGroup = try values.decodeIfPresent(UserGroup.self, forKey: .userGroup)
        month = try values.decodeIfPresent(Int.self, forKey: .month)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        
    }
    
}

extension Appointment {
    
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
        self.startingDate = managedObject.startingDate
        self.endingDate = managedObject.endingDate
        self.eventLength = Int(managedObject.eventLength)
        self.lastUpdatedTime = managedObject.lastUpdatedTime
        self.month = Int(managedObject.month)
        self.year = Int(managedObject.year)
        self.startDate = managedObject.startDate != nil ? StartDate(managedObject: managedObject.startDate!) : nil
        self.endDate = managedObject.endDate != nil ? EndDate(managedObject: managedObject.endDate!) : nil
        self.user = managedObject.user != nil ? AppointmentUser(managedObject: managedObject.user!) : nil
        self.userGroup = managedObject.userGroup != nil ? UserGroup(managedObject: managedObject.userGroup!) : nil
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

extension Appointment {
    
    init(appointment: Appointment, appointmentAttendance: AppointmentAttendance) {
        self.id = appointment.id
        self.title = appointment.title
        self.location = appointment.location
        self.description = appointment.description
        self.occurrenceId = appointment.occurrenceId
        self.isTherapy = appointment.isTherapy
        self.therapistId = appointment.therapistId
        self.facilityId = appointment.facilityId
        self.residentId = appointment.residentId
        self.therapyId = appointment.therapyId
        self.groupId = appointment.groupId
        self.parentEventId = appointment.parentEventId
        self.startingDate = appointment.startingDate
        self.endingDate = appointment.endingDate
        self.eventLength = appointment.eventLength
        self.lastUpdatedTime = appointment.lastUpdatedTime
        self.month = appointment.month
        self.year = appointment.year
        self.startDate = appointment.startDate != nil ? StartDate(startDate:appointment.startDate!) : nil
        self.endDate = appointment.endDate != nil ? EndDate(endDate: appointment.endDate!) : nil
        self.user = appointment.user != nil ? AppointmentUser(appointmentUser: appointment.user!) : nil
        self.userGroup = appointment.userGroup != nil ? UserGroup(userGroup: appointment.userGroup!) : nil
        self.appointmentTags = []
        for appointmentTag in appointment.appointmentTags ?? []{
            self.appointmentTags?.append(AppointmentTag(appointmentTag: appointmentTag))
        }
        self.appointmentAttendance = []
        self.appointmentAttendance?.append(AppointmentAttendance(appointmentAttendance: appointmentAttendance))
    }
    
}
