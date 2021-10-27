//
//  AppointmentsTypeCoreDataStore.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//

import Foundation
import CoreData

public class AppointmentsTypeCoreDataStore {
    
    let coreDataStack: AnyCoreDataStack
    
    public init(coreDataStack: AnyCoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    //Mark:- CDAppointmentsType Fetching + Syncing + Deleting
    public func fetchCDAppointmentsType(facilityId: Int64) throws -> [CDAppointmentsType] {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "facilityId == %@", "\(facilityId)")
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDAppointmentsTypeSelected(facilityId: Int64) throws -> [CDAppointmentsType] {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isSelected == %@ AND facilityId == %@", NSNumber(booleanLiteral: true), "\(facilityId)")
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDAppointmentsTypeForUpdate(id: Int64,facilityId: Int64) throws -> CDAppointmentsType? {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND facilityId == %@", "\(id)", "\(facilityId)")
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func checkCDAppointmentsTypeExist(id: Int64,facilityID: Int64) throws -> Bool {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND facilityId == %@", "\(id)", "\(facilityID)")
        let appointmentsType = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        if appointmentsType.count > 0 {
            return true
        }else {
            return false
        }
    }
    
    public func markAllCDAppointmentsType(status: Bool, facilityID: Int64) throws {
        let entityDescription: NSEntityDescription = CDAppointmentsType.entity()
        let predicate = NSPredicate(format: "facilityId == %@", "\(facilityID)")
        let batchUpdateRequest = NSBatchUpdateRequest(entity: entityDescription)
        batchUpdateRequest.resultType = .updatedObjectIDsResultType
        batchUpdateRequest.predicate = predicate
        batchUpdateRequest.propertiesToUpdate = ["isSelected": NSNumber(booleanLiteral: status)]
        do {
            // Execute Batch Update
            let batchUpdateResult = try self.coreDataStack.manageObjectContext.execute(batchUpdateRequest) as! NSBatchUpdateResult
            print("The batch update request has updated \(batchUpdateResult.result ?? "") in Appointments Type records.")
            
            let objects = batchUpdateResult.result as! [NSManagedObjectID]
            objects.forEach({ objID in
                let managedObject = self.coreDataStack.manageObjectContext.object(with: objID)
                self.coreDataStack.manageObjectContext.refresh(managedObject, mergeChanges: false)
            })
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
    
    public func deleteCDAppointmentTypes(id: Int64,facilityID: Int64) throws {
        let fetchRequest: NSFetchRequest<CDAppointmentsType> = CDAppointmentsType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND facilityId == %@", "\(id)","\(facilityID)")
        do {
            // Execute Batch Request
            let appointmentTypes = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
            for object in appointmentTypes {
                self.coreDataStack.manageObjectContext.delete(object)
            }
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
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<CDAppointmentsType>,
           !insertedObjects.isEmpty {
            didChange = true
        }
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<CDAppointmentsType>,
           !updatedObjects.isEmpty {
            didChange = true
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] as? Set<CDAppointmentsType>,
           !deletedObjects.isEmpty {
            didChange = true
        }
        if didChange {
            print("CDAppointmentsType Changed")
        }
    }
    
}

extension AppointmentsTypeCoreDataStore {
    
    public func createCDAppointmentsType() -> CDAppointmentsType{
        return CDAppointmentsType(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDAppointmentsType(_ appointmentsType: CDAppointmentsType) {
        self.coreDataStack.saveContext()
    }
    
}
