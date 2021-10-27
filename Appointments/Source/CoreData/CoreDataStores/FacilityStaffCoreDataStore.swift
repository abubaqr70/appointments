//
//  FacilityStaffCoreDataStack.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//

import Foundation
import CoreData

public class FacilityStaffCoreDataStore {
    
    let coreDataStack: AnyCoreDataStack
    
    public init(coreDataStack: AnyCoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    //Mark:- CDFacilityStaff Fetching + Syncing + Deleting
    public func fetchCDFacilityStaff(facilityId: Int64) throws -> [CDFacilityStaff] {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "facilityId == %@", "\(facilityId)")
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func fetchCDFacilityStaffForUpdate(id: Int64, facilityId: Int64) throws -> CDFacilityStaff? {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "staffId == %@ AND facilityId == %@", "\(id)", "\(facilityId)")
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func checkCDFacilityStaffExist(id: Int64, facilityID: Int64) throws -> Bool {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "staffId == %@ ANd facilityId == %@", "\(id)", "\(facilityID)")
        let facilityStaff = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        if facilityStaff.count > 0 {
            return true
        }else {
            return false
        }
    }
    
    public func deleteCDFacilityStaff(staffId: Int64, facilityID: Int64) throws {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "staffId == %@ AND facilityId == %@", "\(staffId)", "\(facilityID)")
        do {
            // Execute Batch Request
            let facilityStaff = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
            for object in facilityStaff {
                self.coreDataStack.manageObjectContext.delete(object)
            }
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
    
    public func deleteAllCDFacilityStaffWithFacilityId(facilityId: Int64) throws {
        let fetchRequest: NSFetchRequest<CDFacilityStaff> = CDFacilityStaff.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "facilityId == %@", "\(facilityId)")
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
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<CDFacilityStaff>,
           !insertedObjects.isEmpty {
            didChange = true
        }
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<CDFacilityStaff>,
           !updatedObjects.isEmpty {
            didChange = true
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] as? Set<CDFacilityStaff>,
           !deletedObjects.isEmpty {
            didChange = true
        }
        if didChange {
            print("CDFacilityStaff Changed")
        }
    }
    
}

extension FacilityStaffCoreDataStore {
    
    public func createCDFacilityStaff() -> CDFacilityStaff{
        return CDFacilityStaff(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDFacilityStaff(_ facilityStaff: CDFacilityStaff) {
        self.coreDataStack.saveContext()
    }
    
}
