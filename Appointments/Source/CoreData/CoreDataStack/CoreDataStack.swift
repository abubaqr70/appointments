// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData

public protocol AnyCoreDataStack {
    // Context
    var manageObjectContext: NSManagedObjectContext { get }

    //Operations
    func saveContext()
}

public class CoreDataStack {
    
    let modelName: String
    let bundle: Bundle
    
    public init(modelName: String = "AppointmentsDataModel",
                in bundle: Bundle = Bundle(for: CoreDataStack.self)) {
        self.modelName = modelName
        self.bundle = bundle
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        guard let url = self.bundle.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to find data model resource in bundle: \(String(describing: self.bundle.bundleIdentifier))")
        }
        
        guard let model =  NSManagedObjectModel(contentsOf: url) else {
            fatalError("Unable to load Data model")
        }
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unable to load persistent store from data model")
            }
        })
        
        return container
    }()
    
    
}

extension CoreDataStack: AnyCoreDataStack {
    
    public var manageObjectContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    public func saveContext() {
        
        guard self.manageObjectContext.hasChanges else { return }
        
        do {
            try self.manageObjectContext.save()
        } catch let error as NSError {
            print("Error \(error), \(error.userInfo)")
        }
    }
}
