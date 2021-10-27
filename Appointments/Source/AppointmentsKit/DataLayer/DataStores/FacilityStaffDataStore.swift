//
//  FacilityStaffDataStore.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//

import Foundation

protocol FacilityStaffDataStore {
    
    func fetchFacilityStaff(facilityId: Int) -> [FacilityStaff]
    func saveFacilityStaff(_ facilityStaff: FacilityStaff)
    func updateFacilityStaff (facilityId: Int, facilityStaff : FacilityStaff )
    func checkFacilityStaffExist(facilityId: Int, facilityStaff: FacilityStaff) -> Bool
    func deleteFacilityStaff(facilityId: Int, facilityStaff : FacilityStaff )
    func deleteFacilityStaffWithFacilityId(facilityId: Int) throws
    func deleteAllFacilityStaff() throws
    
}

extension FacilityStaffCoreDataStore : FacilityStaffDataStore{
 
    func fetchFacilityStaff(facilityId: Int) -> [FacilityStaff] {
        do {
            let facilityStaff = try self.fetchCDFacilityStaff(facilityId: Int64(facilityId))
            return facilityStaff.map{
                facilityStaffCoreData -> FacilityStaff in
                return FacilityStaff(managedObject: facilityStaffCoreData)
            }
        } catch { }
        
        return []
    }
    
    func saveFacilityStaff(_ facilityStaff: FacilityStaff) {
        let entity = self.createCDFacilityStaff()
        
        entity.firstName = facilityStaff.firstName
        entity.lastName = facilityStaff.lastName
        entity.isSelected = facilityStaff.isSelected ?? false
        entity.staffId = Int64(facilityStaff.staffId ?? 0)
        entity.facilityId = Int64(facilityStaff.facilityId ?? 0)
        self.saveCDFacilityStaff(entity)
    }
    
    func updateFacilityStaff(facilityId: Int, facilityStaff: FacilityStaff) {
        guard let objectUpdate = try? self.fetchCDFacilityStaffForUpdate(id: Int64(facilityStaff.staffId ?? 0),facilityId: Int64(facilityId)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(NSNumber(booleanLiteral: !(facilityStaff.isSelected ?? true)), forKey: "isSelected")
        self.coreDataStack.saveContext()
    }
    
    func checkFacilityStaffExist(facilityId: Int, facilityStaff: FacilityStaff) -> Bool {
        do {
            let isExist = try self.checkCDFacilityStaffExist(id: Int64(facilityStaff.staffId ?? 0),facilityID: Int64(facilityId))
            return isExist
        } catch { }
        return false
    }
    
    func deleteFacilityStaff(facilityId: Int, facilityStaff: FacilityStaff) {
        do {
            guard let staffId = facilityStaff.staffId else {return}
            try self.deleteCDFacilityStaff(staffId: Int64(staffId),facilityID: Int64(facilityId))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteFacilityStaffWithFacilityId(facilityId: Int) throws {
        do {
            try self.deleteAllCDFacilityStaffWithFacilityId(facilityId: Int64(facilityId))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    func deleteAllFacilityStaff() throws {
        do {
            try self.deleteAllCDFacilityStaff()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
