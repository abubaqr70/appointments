//
//  AppointmentTypesDataStore.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//

import Foundation

protocol AppointmentsTypeDataStore {
    
    func fetchAppointmentsType(facilityId: Int) -> [AppointmentsType]
    func fetchAppointmentsTypeSelected(facilityId: Int) -> [AppointmentsType]
    func saveAppointmentsType(_ appointmentsType: AppointmentsType)
    func updateAppointmentType (facilityId: Int, appointmentType : AppointmentsType )
    func markAllAppointmentsType(facilityId: Int, status: Bool)
    func updateAllAppointmentsType(facilityId: Int, appointmentsType: AppointmentsType)
    func deleteAppointmentsType (facilityId: Int, appointmentTypeId : Int )
    func checkAppointmentsTypeExist(facilityId: Int, appointmentsType: AppointmentsType) -> Bool
    func deleteAllAppointmentType() throws
    
}

extension AppointmentsTypeCoreDataStore : AppointmentsTypeDataStore {
    
    func fetchAppointmentsType(facilityId: Int) -> [AppointmentsType] {
        do {
            let appointmentsType = try self.fetchCDAppointmentsType(facilityId: Int64(facilityId))
            return appointmentsType.map{
                appointmentsTypeCoreData -> AppointmentsType in
                return AppointmentsType(managedObject: appointmentsTypeCoreData)
            }
        } catch { }
        
        return []
    }
    
    func fetchAppointmentsTypeSelected(facilityId: Int) -> [AppointmentsType] {
        do {
            let appointmentsType = try self.fetchCDAppointmentsTypeSelected(facilityId: Int64(facilityId))
            return appointmentsType.map{
                appointmentsTypeCoreData -> AppointmentsType in
                return AppointmentsType(managedObject: appointmentsTypeCoreData)
            }
        } catch { }
        
        return []
    }
    
    func checkAppointmentsTypeExist(facilityId : Int, appointmentsType: AppointmentsType) -> Bool {
        do {
            let isExist = try self.checkCDAppointmentsTypeExist(id: Int64(appointmentsType.id ?? 0),facilityID: Int64(facilityId))
            return isExist
        } catch { }
        return false
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
    
    func updateAppointmentType(facilityId: Int, appointmentType: AppointmentsType) {
        guard let objectUpdate = try? self.fetchCDAppointmentsTypeForUpdate(id: Int64(appointmentType.id ?? 0),facilityId: Int64(facilityId)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(NSNumber(booleanLiteral: !(appointmentType.isSelected ?? true)), forKey: "isSelected")
        self.coreDataStack.saveContext()
    }
    
    func updateAllAppointmentsType(facilityId: Int, appointmentsType: AppointmentsType) {
        guard let objectUpdate = try? self.fetchCDAppointmentsTypeForUpdate(id: Int64(appointmentsType.id ?? 0),facilityId: Int64(facilityId)) else { return }
        print(objectUpdate)
        objectUpdate.setValue(appointmentsType.name, forKey: "name")
        objectUpdate.setValue(appointmentsType.active, forKey: "active")
        objectUpdate.setValue(Int64(appointmentsType.created ?? 0), forKey: "created")
        objectUpdate.setValue(Int64(appointmentsType.modified ?? 0), forKey: "modified")
        objectUpdate.setValue(Int64(appointmentsType.createdById ?? 0), forKey: "createdById")
        objectUpdate.setValue(Int64(appointmentsType.facilityId ?? 0), forKey: "facilityId")
        objectUpdate.setValue(Int64(appointmentsType.rank ?? 0), forKey: "rank")
        self.coreDataStack.saveContext()
    }
    
    func markAllAppointmentsType(facilityId: Int, status: Bool) {
        do {
            try self.markAllCDAppointmentsType(status: status,facilityID: Int64(facilityId))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
        
    
    func deleteAppointmentsType(facilityId: Int, appointmentTypeId: Int) {
        do {
            try self.deleteCDAppointmentTypes(id: Int64(appointmentTypeId),facilityID: Int64(facilityId))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllAppointmentType() throws {
        do {
            try self.deleteAllCDAppointmentsType()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
