// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

protocol AppointmentsDataStore {
    
    func fetchAppointments(facilityId: Int, startDate: Date) -> [Appointment]
    func fetchAppointmentsForResident(facilityId: Int, residentID: Int, startDate: Date) -> [Appointment]
    func fetchAppointmentsSyncedFalseWithFacilityId(facilityId: Int) -> [Appointment]
    func fetchAppointmentsSyncedFalse() -> [Appointment]
    func markAppointmentsSyncedTrue(facilityId: Int, appointment: Appointment)
    func saveAppointment(_ appointment: Appointment,_ lastUpdatedTime: Date)
    func updateAppointment(facilityId: Int, appointment: Appointment)
    func checkAppointmentsExist(facilityId : Int, month: Int , year: Int) -> Bool
    func deleteAppointments(facilityId : Int, month: Int , year: Int) throws
    func deleteAllAppointment() throws
    
}

extension AppointmentsCoreDataStore: AppointmentsDataStore {
    
    func fetchAppointments(facilityId: Int, startDate: Date) -> [Appointment] {
        do {
            let appointments = try self.fetchCDAppointments(facilityId: Int64(facilityId), startDate: startDate)
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsForResident(facilityId: Int, residentID: Int, startDate: Date) -> [Appointment] {
        do {
            let residentID = Int64(residentID)
            let appointments = try self.fetchCDAppointmentsForResident(facilityId: Int64(facilityId), residentID: residentID, startDate: startDate)
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsSyncedFalseWithFacilityId(facilityId: Int) -> [Appointment] {
        do {
            let appointments = try self.fetchCDAppointmentsSyncedFalseWithFacilityID(facilityId: Int64(facilityId))
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsSyncedFalse() -> [Appointment] {
        do {
            let appointments = try self.fetchCDAppointmentsSyncedFalse()
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func markAppointmentsSyncedTrue(facilityId: Int, appointment: Appointment) {
        guard let objectUpdate = try? self.fetchCDAppointmentForUpdate(facilityId: Int64(facilityId), id: Int64(appointment.id ?? 0), occurrenceId: Int64(appointment.occurrenceId ?? 0)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(NSNumber(booleanLiteral: true), forKey: "isSynced")
        self.coreDataStack.saveContext()
    }
    
    func updateAppointment(facilityId: Int, appointment: Appointment) {
        guard let objectUpdate = try? self.fetchCDAppointmentForUpdate(facilityId: Int64(facilityId), id: Int64(appointment.id ?? 0), occurrenceId: Int64(appointment.occurrenceId ?? 0)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(false, forKey: "isSynced")
        for appointmentAttendance in objectUpdate.appointmentAttendance?.allObjects as? [CDAppointmentAttendance] ?? [] {
            if appointmentAttendance.ofAppointments?.occurrenceId ?? 0 == appointment.occurrenceId ?? 0 && appointmentAttendance.id == appointment.appointmentAttendance?.first?.id ?? 0 && appointmentAttendance.residentId == appointment.appointmentAttendance?.first?.residentId ?? 0 && appointmentAttendance.users?.id ?? 0 == appointment.appointmentAttendance?.first?.user?.id ?? 0 {
                if appointment.appointmentAttendance?.first?.present == "present" {
                    appointmentAttendance.present = ""
                } else {
                    appointmentAttendance.present = "present"
                }
                let attendance = appointmentAttendance
                objectUpdate.removeFromAppointmentAttendance(appointmentAttendance)
                objectUpdate.addToAppointmentAttendance(attendance)
            }
        }
        self.coreDataStack.saveContext()
    }
    
    func deleteAppointments(facilityId : Int, month: Int , year: Int) throws {
        do {
            try self.deleteCDAppointments(facilityID: Int64(facilityId), month: Int64(month), year: Int64(year))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllAppointment() throws {
        do {
            try self.deleteAllAppointments()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func checkAppointmentsExist(facilityId : Int, month: Int , year: Int) -> Bool {
        do {
            let isExist = try self.checkCDAppointmentsExist(facilityID: Int64(facilityId), month: Int64(month), year: Int64(year))
            return isExist
        } catch { }
        return false
    }
    
    
    func saveAppointment(_ appointment: Appointment,_ lastUpdatedTime: Date) {
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
        entity.startingDate = appointment.startingDate ?? 0.0
        entity.endingDate = appointment.endingDate ?? 0.0
        entity.eventLength = Int64(appointment.eventLength ?? 0)
        entity.isSynced = true
        let dateFormatterFromString = DateFormatter()
        dateFormatterFromString.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        let date = Date.init(timeIntervalSince1970: TimeInterval(Float(appointment.startingDate ?? 0.0)))
        entity.month = Int64(Date.getMonth(date: date))
        entity.year = Int64(Date.getYear(date: date))
        entity.startedDate = Date.startOfDay(date: date)
        entity.lastUpdatedTime = lastUpdatedTime
        entity.startDate = appointment.startDate != nil ? saveStartDate(appointment.startDate!) : nil
        entity.endDate = appointment.endDate != nil ? saveEndDate(appointment.endDate!) : nil
        entity.user = appointment.user != nil ? saveAppointmentUser(appointment.user!) : nil
        entity.userGroup = appointment.userGroup != nil ? saveUserGroup(appointment.userGroup!) : nil
        for appointmentAttendance in appointment.appointmentAttendance ?? []{
            entity.addToAppointmentAttendance(saveAppointmentAttendance(appointmentAttendance))
        }
        for appointmentTag in appointment.appointmentTags ?? []{
            entity.addToAppointmentTag(saveAppointmentTags(appointmentTag))
        }
        
        self.saveCDAppointment(entity)
    }
    
}

extension AppointmentsCoreDataStore {
    
    func saveStartDate(_ startDate: StartDate) -> CDStartDate{
        let entity = self.createCDStartDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        entity.date = dateFormatter.date(from: startDate.date ?? "")
        entity.timeString = startDate.timeString
        return entity
    }
    
    func saveEndDate(_ endDate: EndDate) -> CDEndDate{
        let entity = self.createCDEndDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
        entity.date = dateFormatter.date(from: endDate.date ?? "")
        entity.timeString = endDate.timeString
        return entity
    }
    
    func saveAppointmentAttendance(_ appointmentAttendance: AppointmentAttendance) -> CDAppointmentAttendance{
        let entity = self.createCDAppointmentAttendance()
        entity.appointmentId = Int64(appointmentAttendance.appointmentId ?? 0)
        entity.id =  Int64(appointmentAttendance.id ?? 0)
        entity.residentId =  Int64(appointmentAttendance.residentId ?? 0)
        entity.present = appointmentAttendance.present
        entity.registered = Int64(appointmentAttendance.registered ?? 0)
        entity.reminderSent = appointmentAttendance.reminderSent
        entity.cancelReminder = appointmentAttendance.cancelReminder
        entity.reminderSentTime = Int64(appointmentAttendance.reminderSentTime ?? 0)
        entity.users = appointmentAttendance.user != nil ? saveAppointmentUser(appointmentAttendance.user!) : nil
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
        entity.facilityCategory = userGroup.facilityCategory != nil ? saveFacilityCategory(userGroup.facilityCategory!) : nil
        for facilityGroupMember in userGroup.facilityGroupMembers ?? [] {
            entity.addToFacilityGroupMembers(saveFacilityGroupMember(facilityGroupMember))
        }
        return entity
    }
    
}
