//
//  CDLastUpdatedCoreDataStore.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//

import Foundation
import CoreData

public class LastUpdatedCoreDataStore {
    
    let coreDataStack: AnyCoreDataStack
    
    public init(coreDataStack: AnyCoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    //Mark:- CDLastUpdated Fetching + Syncing + Deleting
    public func fetchCDLastUpdated() throws -> CDLastUpdated? {
        let fetchRequest: NSFetchRequest<CDLastUpdated> = CDLastUpdated.fetchRequest()
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
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
    
    public func observeChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    @objc
    func contextDidSave(_ notification: Notification) {
        guard let context = notification.object as? NSManagedObjectContext else { return }
        guard context === self.coreDataStack.manageObjectContext else { return }
        
        var didChange = false
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<CDLastUpdated>,
           !insertedObjects.isEmpty {
            didChange = true
        }
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<CDLastUpdated>,
           !updatedObjects.isEmpty {
            didChange = true
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] as? Set<CDLastUpdated>,
           !deletedObjects.isEmpty {
            didChange = true
        }
        if didChange {
            print("CDAppointment Changed")
        }
    }
    
}

extension LastUpdatedCoreDataStore {
    
    public func createCDLastUpdated() -> CDLastUpdated{
        return CDLastUpdated(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDLastUpdated(_ date: CDLastUpdated) {
        self.coreDataStack.saveContext()
    }
    
}
