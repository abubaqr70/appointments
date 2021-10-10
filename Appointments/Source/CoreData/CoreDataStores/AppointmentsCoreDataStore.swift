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
    
    public func fetchCDAppointmentForUpdate(with id: Int64, with occurrenceId: Int64) throws -> CDAppointment? {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND occurrenceId == %@", "\(id)", "\(occurrenceId)")
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func fetchCDAppointment(with id: UUID) throws -> CDAppointment? {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func fetchCDAppointments(with startDate: Double ,with endDate: Double) throws -> [CDAppointment] {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "startingDate >= %@ AND endingDate <= %@", argumentArray: [startDate,endDate])
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDAppointmentsSyncedFalse() throws -> [CDAppointment] {
        let fetchRequest: NSFetchRequest<CDAppointment> = CDAppointment.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isSynced == %@", "false")
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func deleteCDAppointment(with id: UUID) throws {
        if let appointment = try fetchCDAppointment(with: id) {
            self.coreDataStack.manageObjectContext.delete(appointment)
            self.coreDataStack.saveContext()
        }
    }
    
    public func checkCDAppointmentsExist(with startOfMonth: Double, with endOfMonth: Double) throws -> Bool {
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
    
    public func deleteCDAppointments(with startOfMonth: Double, with endOfMonth: Double) throws {
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
    
}
