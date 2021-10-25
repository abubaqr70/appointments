// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData

public enum AppointmentCoreDataStoreError: Error {
    case noAppointmentFound
}

public class AppointmentsCoreDataStore {
    
    let coreDataStack: AnyCoreDataStack
    
    public init(coreDataStack: AnyCoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    public func fetchCDAppointmentForUpdate(id: Int64,occurrenceId: Int64) throws -> CDAppointment? {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND occurrenceId == %@", "\(id)", "\(occurrenceId)")
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func fetchCDAppointment(id: UUID) throws -> CDAppointment? {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func fetchCDLastUpdated() throws -> CDLastUpdated? {
        let fetchRequest: NSFetchRequest<CDLastUpdated> = CDLastUpdated.fetchRequest()
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func fetchCDAppointments(startDate: Date) throws -> [CDAppointment] {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "startedDate == %@", argumentArray: [startDate])
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDAppointmentsForResident(residentID:Int64, startDate: Date) throws -> [CDAppointment] {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "startedDate == %@ && ANY appointmentAttendance.residentId == %@", argumentArray: [startDate, residentID])
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDAppointmentsSyncedFalse() throws -> [CDAppointment] {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isSynced == %@", "false")
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDAppointmentsType() throws -> [CDAppointmentsType] {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDFacilityStaff() throws -> [CDFacilityStaff] {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func deleteCDAppointment(id: UUID) throws {
        if let appointment = try fetchCDAppointment(id: id) {
            self.coreDataStack.manageObjectContext.delete(appointment)
            self.coreDataStack.saveContext()
        }
    }
    
    public func checkCDAppointmentsExist(startOfMonth: Double,endOfMonth: Double) throws -> Bool {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "startingDate >= %@ AND endingDate <= %@", argumentArray: [startOfMonth,endOfMonth])
        let appointments = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        if appointments.count > 0 {
            return true
        }else {
            return false
        }
    }
    
    public func deleteAllData() throws {
        try? self.deleteAllAppointment()
        try? self.deleteAllLastUpdated()
        try? self.deleteAllCDFacilityStaff()
        try? self.deleteAllCDAppointmentsType()
        return
    }
    
    public func deleteAllAppointments() throws {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            // Execute Batch Request
            let batchDeleteResult = try self.coreDataStack.manageObjectContext.execute(batchDeleteRequest) as! NSBatchDeleteResult
            print("The batch delete request has deleted \(batchDeleteResult.result!) records.")
            self.coreDataStack.saveContext()
        } catch {
            let updateError = error as NSError
            print("\(updateError), \(updateError.userInfo)")
        }
        return
    }
    
    public func deleteAllLastUpdated() throws {
        let fetchRequest: NSFetchRequest<CDLastUpdated> = CDLastUpdated.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            // Execute Batch Request
            let batchDeleteResult = try self.coreDataStack.manageObjectContext.execute(batchDeleteRequest) as! NSBatchDeleteResult
            print("The batch delete request has deleted \(batchDeleteResult.result!) records.")
            self.coreDataStack.saveContext()
        } catch {
            let updateError = error as NSError
            print("\(updateError), \(updateError.userInfo)")
        }
        return
    }
    
    public func deleteAllCDAppointmentsType() throws {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            // Execute Batch Request
            let batchDeleteResult = try self.coreDataStack.manageObjectContext.execute(batchDeleteRequest) as! NSBatchDeleteResult
            print("The batch delete request has deleted \(batchDeleteResult.result!) records.")
            self.coreDataStack.saveContext()
        } catch {
            let updateError = error as NSError
            print("\(updateError), \(updateError.userInfo)")
        }
        return
    }
    
    public func deleteAllCDFacilityStaff() throws {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            // Execute Batch Request
            let batchDeleteResult = try self.coreDataStack.manageObjectContext.execute(batchDeleteRequest) as! NSBatchDeleteResult
            print("The batch delete request has deleted \(batchDeleteResult.result!) records.")
            self.coreDataStack.saveContext()
        } catch {
            let updateError = error as NSError
            print("\(updateError), \(updateError.userInfo)")
        }
        return
    }
    
    public func deleteCDAppointments(startOfMonth: Double,endOfMonth: Double) throws {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "startingDate >= %@ AND endingDate <= %@", argumentArray: [startOfMonth,endOfMonth])
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        batchDeleteRequest.resultType = .resultTypeCount
        do {
            // Execute Batch Request
            let batchDeleteResult = try self.coreDataStack.manageObjectContext.execute(batchDeleteRequest) as! NSBatchDeleteResult
            print("The batch delete request has deleted \(batchDeleteResult.result!) records.")
            self.coreDataStack.saveContext()
        } catch {
            let updateError = error as NSError
            print("\(updateError), \(updateError.userInfo)")
        }
        return
    }
    
    public func observeChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    @objc
    func contextDidSave(_ notification: Notification) {
        guard let context = notification.object as? NSManagedObjectContext else { return }
        guard context === self.coreDataStack.manageObjectContext else { return }
        
        var didChange = false
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<CDAppointment>,
           !insertedObjects.isEmpty {
            didChange = true
        }
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<CDAppointment>,
           !updatedObjects.isEmpty {
            didChange = true
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] as? Set<CDAppointment>,
           !deletedObjects.isEmpty {
            didChange = true
        }
        if didChange {
            print("CDAppointment Changed")
        }
    }
}

extension AppointmentsCoreDataStore {
    
    public func createCDAppointment() -> CDAppointment{
        return CDAppointment(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDAppointmentAttendance() -> CDAppointmentAttendance{
        return CDAppointmentAttendance(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDAppointmentTags() -> CDAppointmentTags{
        return CDAppointmentTags(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDFacilityGroupMember() -> CDFacilityGroupMembers{
        return CDFacilityGroupMembers(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDAppointmentUser() -> CDAppointmentUser{
        return CDAppointmentUser(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDAppointmentUserGroup() -> CDUserGroup{
        return CDUserGroup(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDStartDate() -> CDStartDate{
        return CDStartDate(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDEndDate() -> CDEndDate{
        return CDEndDate(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDFacilityCategory() -> CDFacilityCategory{
        return CDFacilityCategory(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDAppointment(_ appointment: CDAppointment) {
        self.coreDataStack.saveContext()
    }
    
    public func saveCDAppointmentAttendance(_ appointmentAttendance: CDAppointmentAttendance) {
        self.coreDataStack.saveContext()
    }
    
    public func createCDLastUpdated() -> CDLastUpdated{
        return CDLastUpdated(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDLastUpdated(_ date: CDLastUpdated) {
        self.coreDataStack.saveContext()
    }
    
    public func createCDAppointmentsType() -> CDAppointmentsType{
        return CDAppointmentsType(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDFacilityStaff() -> CDFacilityStaff{
        return CDFacilityStaff(context: self.coreDataStack.manageObjectContext)
    }
    
    public func createCDStaffRole() -> CDStaffRole{
        return CDStaffRole(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDAppointmentsType(_ appointmentsType: CDAppointmentsType) {
        self.coreDataStack.saveContext()
    }
    
    public func saveCDFacilityStaff(_ facilityStaff: CDFacilityStaff) {
        self.coreDataStack.saveContext()
    }
    
    public func saveCDStaffRole() {
        self.coreDataStack.saveContext()
    }
    
}
