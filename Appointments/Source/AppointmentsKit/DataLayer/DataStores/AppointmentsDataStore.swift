//
//  AppointmentsDataStore.swift
//  Appointments
//
//  Created by Hussaan S on 27/08/2021.
//

import Foundation

protocol AppointmentsDataStore {
    
    func fetchAppointments() -> [Appointment]
    func saveAppointment(_ appointment: Appointment)

}


extension Appointment {
    
    init(with cdAppointment: CDAppointment) {
        self.title = cdAppointment.title ?? ""
    }
}

extension AppointmentsCoreDataStore: AppointmentsDataStore {
    
    func fetchAppointments() -> [Appointment] {
        
        do {
            let appointments = try self.fetchCDAppointments()
            return appointments.map (Appointment.init(with:))
        } catch { }
        
        return []
    }
    
    func saveAppointment(_ appointment: Appointment) {
        let entity = self.createCDAppointment()
        entity.title = appointment.title
        self.saveCDAppointment(entity)
    }

}
