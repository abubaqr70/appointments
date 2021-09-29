// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

protocol AppointmentsDataStore {
    
    func fetchAppointments() -> [Appointment]
    func saveAppointment(_ appointment: Appointment)
}


extension Appointment {
    
//    init(with cdAppointment: CDAppointment) {
//        self.title = cdAppointment.title ?? ""
//    }
}

extension AppointmentsCoreDataStore: AppointmentsDataStore {
    
    func fetchAppointments() -> [Appointment] {
        
        do {
            let appointments = try self.fetchCDAppointments()
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func saveAppointment(_ appointment: Appointment) {
        let entity = self.createCDAppointment()
        entity.id = Int64(appointment.id ?? 0)
        entity.title = appointment.title
        entity.location = appointment.location
        entity.descriptions = appointment.description
        entity.occurrenceId = Int64(appointment.occurrenceId ?? 0)
        entity.isTherapy = appointment.isTherapy ?? false
        entity.therapyId = Int64(appointment.therapyId ?? 0)
        entity.therapistId = Int64(appointment.therapistId ?? 0)
        entity.groupId = Int64(appointment.groupId ?? 0)
        entity.parentEventId = Int64(appointment.parentEventId ?? 0)
        entity.facilityId = Int64(appointment.facilityId ?? 0)
        entity.residentId = Int64(appointment.residentId ?? 0)
        entity.startDate = saveStartDate(appointment.startDate ?? StartDate())
        entity.endDate = saveEndDate(appointment.endDate ?? EndDate())
        entity.user = saveAppointmentUser(appointment.user ?? AppointmentUser())
        entity.userGroup = saveUserGroup(appointment.userGroup ?? UserGroup())
        for appointmentAttandance in appointment.appointmentAttendance ?? []{
            entity.addToAppointmentAttendance(saveAppointmentAttendance(appointmentAttandance)) 
        }
        for appointmentTag in appointment.appointmentTags ?? []{
            entity.addToAppointmentTag(saveAppointmentTags(appointmentTag))
        }
        
        self.saveCDAppointment(entity)
    }
    
    func saveStartDate(_ startDate: StartDate) -> CDStartDate{
        let entity = self.createCDStartDate()
        entity.date = startDate.date
        entity.timeString = startDate.timeString
        return entity
    }
    
    func saveEndDate(_ endDate: EndDate) -> CDEndDate{
        let entity = self.createCDEndDate()
        entity.date = endDate.date
        entity.timeString = endDate.timeString
        return entity
    }

    func saveAppointmentAttendance(_ appointmentAttendance: AppointmentAttendance) -> CDAppointmentAttendance{
        let entity = self.createCDAppointmentAttendance()
        entity.appointmentId = Int64(appointmentAttendance.appointmentId ?? 0)
        entity.id =  Int64(appointmentAttendance.id ?? 0)
        entity.residentId =  Int64(appointmentAttendance.residentId ?? 0)
        entity.present = appointmentAttendance.present
        entity.reminderSent = appointmentAttendance.reminderSent
        entity.cancelReminder = appointmentAttendance.cancelReminder
        entity.reminderSentTime = Int64(appointmentAttendance.reminderSentTime ?? 0)
        entity.users?.fullName = appointmentAttendance.user?.fullName
        entity.users?.profileImageRoute = appointmentAttendance.user?.profileImageRoute
        entity.users?.gender = appointmentAttendance.user?.gender
        entity.users?.id = Int64(appointmentAttendance.user?.id ?? 0)
        entity.users?.firstName = appointmentAttendance.user?.firstName
        entity.users?.lastName = appointmentAttendance.user?.lastName
        entity.users?.roomNo = appointmentAttendance.user?.roomNo
        return entity
    }
    
    func saveAppointmentUser(_ appointmentUser: AppointmentUser) -> CDAppointmentUser{
        let entity = self.createCDAppointmentUser()
        entity.fullName = appointmentUser.fullName
        entity.profileImageRoute = appointmentUser.profileImageRoute
        entity.gender = appointmentUser.gender
        entity.id = Int64(appointmentUser.id ?? 0)
        entity.firstName = appointmentUser.firstName
        entity.lastName = appointmentUser.lastName
        entity.roomNo = appointmentUser.roomNo
        return entity
    }
    
    func saveAppointmentTags(_ appointmentTags: AppointmentTag) -> CDAppointmentTags{
        let entity = self.createCDAppointmentTags()
        entity.appointmentId = Int64(appointmentTags.appointmentId ?? 0)
        entity.id =  Int64(appointmentTags.id ?? 0)
        entity.tagId =  Int64(appointmentTags.tagId ?? 0)
        entity.tagActualText = appointmentTags.tagActualText
        return entity
    }
    
    func saveFacilityGroupMember(_ facilityGroupMember: FacilityGroupMembers) -> CDFacilityGroupMembers{
        let entity = self.createCDFacilityGroupMember()
        entity.id = Int64(facilityGroupMember.id ?? 0)
        entity.userId =  Int64(facilityGroupMember.userId ?? 0)
        entity.groupId =  Int64(facilityGroupMember.groupId ?? 0)
        entity.memberType = facilityGroupMember.memberType
        return entity
    }
    
    func saveFacilityCategory(_ facilityCategory: FacilityCategory) -> CDFacilityCategory{
        let entity = self.createCDFacilityCategory()
        entity.id = Int64(facilityCategory.id ?? 0)
        entity.facilityId = Int64(facilityCategory.facilityId ?? 0)
        entity.name = facilityCategory.name
        return entity
    }
    
    func saveUserGroup(_ userGroup: UserGroup) -> CDUserGroup{
        let entity = self.createCDAppointmentUserGroup()
        entity.categoryId = Int64(userGroup.categoryId ?? 0)
        entity.id = Int64(userGroup.id ?? 0)
        entity.facilityId = Int64(userGroup.facilityId ?? 0)
        entity.name = userGroup.name
        entity.facilityCategory = saveFacilityCategory(userGroup.facilityCategory ?? FacilityCategory())
        for facilityGroupMemeber in userGroup.facilityGroupMembers ?? [] {
            entity.addToFacilityGroupMembers(saveFacilityGroupMember(facilityGroupMemeber))
        }
        return entity
    }
    
}
