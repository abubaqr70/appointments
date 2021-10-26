// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

protocol AppointmentsDataStore {
    
    func fetchAppointments(startDate: Date) -> [Appointment]
    func fetchLastUpdated() -> Date?
    func fetchAppointmentsForResident(residentID: Int, startDate: Date) -> [Appointment]
    func fetchAppointmentsSyncedFalse() -> [Appointment]
    func fetchAppointmentsType() -> [AppointmentsType]
    func fetchAppointmentsTypeSelected() -> [AppointmentsType]
    func fetchFacilityStaff() -> [FacilityStaff]
    func fetchFacilityStaffSelected() -> [FacilityStaff]
    func markAppointmentsSyncedTrue(_ appointment: Appointment)
    func markAllFacilityStaff(status: Bool)
    func markAllAppointmentsType(status: Bool)
    func saveAppointment(_ appointment: Appointment,_ lastUpdatedTime: Date)
    func saveLastUpdated(_ date: Date)
    func saveAppointmentsType(_ appointmentsType: AppointmentsType)
    func saveFacilityStaff(_ facilityStaff: FacilityStaff)
    func updateAppointment(_ appointment: Appointment)
    func updateAppointmentType (_ appointmentType : AppointmentsType )
    func updateFacilityStaff (_ facilityStaff : FacilityStaff )
    func checkAppointmentsExist(startDate: Double ,endDate: Double) -> Bool
    func checkAppointmentsTypeExist(appointmentsType: AppointmentsType) -> Bool
    func checkFacilityStaffExist(facilityStaff: FacilityStaff) -> Bool
    func deleteAppointments(startDate: Double ,endDate: Double) throws
    func deleteAllAppointment() throws
    func deleteLastUpdated() throws
    func deleteFacilityStaff() throws
    func deleteAppointmentsType() throws
    
}

extension AppointmentsCoreDataStore: AppointmentsDataStore {
    
    func fetchAppointments(startDate: Date) -> [Appointment] {
        do {
            let appointments = try self.fetchCDAppointments(startDate: startDate)
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsForResident(residentID: Int, startDate: Date) -> [Appointment] {
        do {
            let residentID = Int64(residentID)
            let appointments = try self.fetchCDAppointmentsForResident(residentID: residentID, startDate: startDate)
            return appointments.map{
                appointmentCoreData -> Appointment in
                return Appointment(managedObject: appointmentCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsType() -> [AppointmentsType] {
        do {
            let appointmentsType = try self.fetchCDAppointmentsType()
            return appointmentsType.map{
                appointmentsTypeCoreData -> AppointmentsType in
                return AppointmentsType(managedObject: appointmentsTypeCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsTypeSelected() -> [AppointmentsType] {
        do {
            let appointmentsType = try self.fetchCDAppointmentsTypeSelected()
            return appointmentsType.map{
                appointmentsTypeCoreData -> AppointmentsType in
                return AppointmentsType(managedObject: appointmentsTypeCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchFacilityStaff() -> [FacilityStaff] {
        do {
            let facilityStaff = try self.fetchCDFacilityStaff()
            return facilityStaff.map{
                facilityStaffCoreData -> FacilityStaff in
                return FacilityStaff(managedObject: facilityStaffCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchFacilityStaffSelected() -> [FacilityStaff] {
        do {
            let facilityStaff = try self.fetchCDFacilityStaffSelected()
            return facilityStaff.map{
                facilityStaffCoreData -> FacilityStaff in
                return FacilityStaff(managedObject: facilityStaffCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchLastUpdated() -> Date? {
        try? self.fetchCDLastUpdated()?.date
    }
    
    func checkAppointmentsExist(startDate: Double , endDate: Double) -> Bool {
        do {
            let isExist = try self.checkCDAppointmentsExist(startOfMonth: startDate, endOfMonth: endDate)
            return isExist
        } catch { }
        return false
    }
    
    func checkAppointmentsTypeExist(appointmentsType: AppointmentsType) -> Bool {
        do {
            let isExist = try self.checkCDAppointmentsTypeExist(id: Int64(appointmentsType.id ?? 0))
            return isExist
        } catch { }
        return false
    }
    
    func checkFacilityStaffExist(facilityStaff: FacilityStaff) -> Bool {
        do {
            let isExist = try self.checkCDFacilityStaffExist(id: Int64(facilityStaff.staffId ?? 0))
            return isExist
        } catch { }
        return false
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
    
    func saveLastUpdated(_ date: Date) {
        let entity = self.createCDLastUpdated()
        entity.date = date
        self.saveCDLastUpdated(entity)
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
    
    
    func saveAppointmentsType(_ appointmentsType: AppointmentsType) {
        let entity = self.createCDAppointmentsType()
        entity.id = Int64(appointmentsType.id ?? 0)
        entity.name = appointmentsType.name
        entity.active = appointmentsType.active ?? false
        entity.created = Int64(appointmentsType.created ?? 0)
        entity.modified = Int64(appointmentsType.modified ?? 0)
        entity.createdById = Int64(appointmentsType.createdById ?? 0)
        entity.facilityId = Int64(appointmentsType.facilityId ?? 0)
        entity.isSelected = appointmentsType.isSelected ?? false
        entity.rank = Int64(appointmentsType.rank ?? 0)
        self.saveCDAppointmentsType(entity)
    }
    
    func saveFacilityStaff(_ facilityStaff: FacilityStaff) {
        let entity = self.createCDFacilityStaff()
        entity.codeStatus = facilityStaff.codeStatus
        entity.email = facilityStaff.email
        entity.facilities = facilityStaff.facilities
        entity.facilityId = Int64(facilityStaff.facilityId ?? 0)
        entity.firstName = facilityStaff.firstName
        entity.lastName = facilityStaff.lastName
        entity.isSelected = facilityStaff.isSelected ?? false
        entity.profileImageRoute = facilityStaff.profileImageRoute
        entity.roomNo = facilityStaff.roomNo
        entity.staffId = Int64(facilityStaff.staffId ?? 0)
        for staffRole in facilityStaff.roles ?? []{
            entity.addToStaff(saveStaffRole(staffRole))
        }
        self.saveCDFacilityStaff(entity)
    }
    
    func updateAppointment (_ appointment : Appointment ) {
        guard let objectUpdate = try? self.fetchCDAppointmentForUpdate(id: Int64(appointment.id ?? 0), occurrenceId: Int64(appointment.occurrenceId ?? 0)) else { return }
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
    
    func markAllAppointmentsType(status: Bool) {
        do {
            try self.markAllCDAppointmentsType(status: status)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func markAllFacilityStaff(status: Bool) {
        do {
            try self.markAllCDFacilityStaff(status: status)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func markAppointmentsSyncedTrue (_ appointment : Appointment ) {
        guard let objectUpdate = try? self.fetchCDAppointmentForUpdate(id: Int64(appointment.id ?? 0), occurrenceId: Int64(appointment.occurrenceId ?? 0)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(true, forKey: "isSynced")
        self.coreDataStack.saveContext()
    }
    
    func updateAppointmentType (_ appointmentType : AppointmentsType ) {
        guard let objectUpdate = try? self.fetchCDAppointmentsTypeForUpdate(id: Int64(appointmentType.id ?? 0)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(!(appointmentType.isSelected ?? true), forKey: "isSelected")
        self.coreDataStack.saveContext()
    }
    
    func updateFacilityStaff (_ facilityStaff : FacilityStaff ) {
        guard let objectUpdate = try? self.fetchCDFacilityStaffForUpdate(id: Int64(facilityStaff.staffId ?? 0)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(!(facilityStaff.isSelected ?? true), forKey: "isSelected")
        self.coreDataStack.saveContext()
    }
    
    func deleteAllAppointment() throws {
        do {
            try self.deleteAllData()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteFacilityStaff() throws {
        do {
            try self.deleteAllCDFacilityStaff()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAppointmentsType() throws {
        do {
            try self.deleteAllCDAppointmentsType()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteLastUpdated() throws {
        do {
            try self.deleteAllLastUpdated()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAppointments(startDate: Double , endDate: Double) throws {
        do {
            try self.deleteCDAppointments(startOfMonth: startDate, endOfMonth: endDate)
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
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
    
    func saveStaffRole(_ staffRole: StaffRole) -> CDStaffRole{
        let entity = self.createCDStaffRole()
        entity.isEmployee = Int64(staffRole.isEmployee ?? 0)
        entity.isProfile = Int64(staffRole.isProfile ?? 0)
        entity.roleId = Int64(staffRole.roleId ?? 0)
        entity.roleName = staffRole.roleName
        entity.staffId = Int64(staffRole.staffId ?? 0)
        return entity
    }
    
}
