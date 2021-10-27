//
//  LastUpdatedDataStore.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//

import Foundation

protocol LastUpdatedDataStore {
    
    func saveLastUpdated(_ date: Date)
    func fetchLastUpdated() -> Date?
    func deleteLastUpdated() throws
    
}

extension LastUpdatedCoreDataStore : LastUpdatedDataStore {
    
    func fetchLastUpdated() -> Date? {
        try? self.fetchCDLastUpdated()?.date
    }
    
    func saveLastUpdated(_ date: Date) {
        let entity = self.createCDLastUpdated()
        entity.date = date
        self.saveCDLastUpdated(entity)
    }
    
    func deleteLastUpdated() throws {
        do {
            try self.deleteAllLastUpdated()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

