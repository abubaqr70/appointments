// Copyright © 2021 Caremerge. All rights reserved.

import Foundation

//Mark:- Filters Extension Used For Filtering Appointments
extension AppointmentsViewModel {
    
    //Mark:- Main Filters which check if it is resident side or tab side
    func filtersApply(appointments: [Appointment]) -> [Appointment] {
        
        if  self.residentProvider?.currentResident?["resident_id"] as? Int != nil {
            return applyingAppointmentsFilter(appointments: appointments)
        } else {
            return applyCombinedFilters(appointments: appointments)
        }
    }
    
    //Mark:- Filters which are used for tab bar appointment
    func applyCombinedFilters(appointments: [Appointment]) -> [Appointment] {
        
        //Mark:- Initialising Properties
        guard let selectedResident = self.filterActionProvider?.allSelectedResidents()  else { return [] }
        guard let selectedGroups = self.filterActionProvider?.allSelectedGroups() else { return [] }
        
        let appointmentsTypes = self.appointmentsRepository.getAppointmentsTypeSelectedIds(facilityId: self.facilityId)
        let facilityStaffMembers = self.appointmentsRepository.getFacilityStaffSelectedIds(facilityId: self.facilityId)
        
        //Mark:- Checking wether we need to apply filter or not when all selected
        self.isAppointmentsFilterAppliedSubject.onNext(self.appointmentsRepository.isAppointmentsFilterApplied(facilityId: self.facilityId))
        
        //Mark:- Checking wether we need to apply filter or not
        if selectedResident.count >= 1 || selectedGroups.count >= 1 || appointmentsTypes.count >= 1 || facilityStaffMembers.count >= 1 {
            
            //Mark:- Skipping Appointment types and facility Staff members if all selected
            if self.appointmentsRepository.checkForMarkAppointmentsType(facilityId: self.facilityId) && self.appointmentsRepository.checkForMarkFacilityStaff(facilityId: self.facilityId, facilityDataStore: facilityDataStore) {
                
                //Mark:- Applying filters on selected resident and selected groups
                return appointments.filter{
                    appointment in
                    
                    if selectedResident.count >= 1  && selectedGroups.count >= 1 {
                        return selectedResident.contains(appointment.appointmentAttendance?.first?.residentId ?? 0) && selectedGroups.contains(appointment.groupId ?? 0)
                    } else if selectedResident.count >= 1 {
                        return selectedResident.contains(appointment.appointmentAttendance?.first?.residentId ?? 0)
                    } else {
                        return selectedGroups.contains(appointment.groupId ?? 0)
                    }
                }
                
                //Mark:- Skipping appointment Types only if all selected
            } else if self.appointmentsRepository.checkForMarkAppointmentsType(facilityId: facilityId) {
                
                var appointments = appointments
                
                //Mark:- Applying filters on both facility staff and selected group with OR condition
                if selectedGroups.count >= 1 || facilityStaffMembers.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return selectedGroups.contains(appointment.groupId ?? 0) || filterInStaffAndGroup(facilityStaffMembers: facilityStaffMembers, appointment: appointment)
                    }
                    
                    //Mark:- Applying filters on selected residents if any
                }
                if selectedResident.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return selectedResident.contains(appointment.appointmentAttendance?.first?.residentId ?? 0)
                    }
                }
                return appointments
                
                //Mark:- Skipping facility staff only if all selected
            } else if self.appointmentsRepository.checkForMarkFacilityStaff(facilityId: facilityId, facilityDataStore: facilityDataStore) {
                var appointments = appointments
                
                //Mark:- Applying filters on selected residents if any
                if selectedResident.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return selectedResident.contains(appointment.appointmentAttendance?.first?.residentId ?? 0)
                    }
                    
                    //Mark:- Applying filters on selected groups if any
                }
                if selectedGroups.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return selectedGroups.contains(appointment.groupId ?? 0)
                        
                    }
                    
                    //Mark:- Applying filters on appointment Types if any
                }
                if appointmentsTypes.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return appointmentsTypes.contains(appointment.therapyId ?? 0)
                    }
                }
                return appointments
                
            } else {
                
                var appointments = appointments
                
                //Mark:- Applying filters on both facility staff and selected group with OR condition
                if selectedGroups.count >= 1 || facilityStaffMembers.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return selectedGroups.contains(appointment.groupId ?? 0) || filterInStaffAndGroup(facilityStaffMembers: facilityStaffMembers, appointment: appointment)
                    }
                    
                    //Mark:- Applying filters on selected residents if any
                }
                if selectedResident.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return selectedResident.contains(appointment.appointmentAttendance?.first?.residentId ?? 0)
                    }
                    
                    //Mark:- Applying filters on appointment Types if any
                }
                if appointmentsTypes.count >= 1 {
                    appointments = appointments.filter{
                        appointment in
                        return appointmentsTypes.contains(appointment.therapyId ?? 0)
                    }
                }
                return appointments
                
            }
            
        }
        
        return appointments
    }
    
    //Mark:- Filters which are used for resident side
    func applyingAppointmentsFilter(appointments: [Appointment]) -> [Appointment] {
        
        //Mark:- Sending event for appointment Tab bar Filters are applied or not
        self.isAppointmentsFilterAppliedSubject.onNext(self.appointmentsRepository.isAppointmentsFilterApplied(facilityId: self.facilityId))
        
        //Mark:- Checking wether we need to apply filter or not when all selected
        if self.appointmentsRepository.checkForMarkAppointmentsType(facilityId: self.facilityId) && self.appointmentsRepository.checkForMarkFacilityStaff(facilityId: self.facilityId, facilityDataStore: facilityDataStore) {
            
            return appointments
        }
        
        //Mark:- Initialising Properties
        let appointmentsTypes = self.appointmentsRepository.getAppointmentsTypeSelectedIds(facilityId: self.facilityId)
        let facilityStaffMembers = self.appointmentsRepository.getFacilityStaffSelectedIds(facilityId: self.facilityId)
        
        
        //Mark:- Checking wether we need to apply filter or not
        if appointmentsTypes.count >= 1  || facilityStaffMembers.count >= 1 {
            
            //Mark:- Skipping appointment Types only if all selected
            if self.appointmentsRepository.checkForMarkAppointmentsType(facilityId: facilityId) {
                
                //Mark:- Applying filters on facility staff
                return appointments.filter{
                    appointment in
                    return filterInStaffAndGroup(facilityStaffMembers: facilityStaffMembers, appointment: appointment)
                }
                
                //Mark:- Skipping facility staff only if all selected
            } else if self.appointmentsRepository.checkForMarkAppointmentsType(facilityId: facilityId) {
                
                //Mark:- Applying filters on appointment Types if any
                return appointments.filter{
                    appointment in
                    return  appointmentsTypes.contains(appointment.therapyId ?? 0)
                }
                
            } else {
                return appointments.filter{
                    appointment in
                    
                    //Mark:- Applying filters on both appointment Types and facility staff members with AND condition
                    if appointmentsTypes.count >= 1 && facilityStaffMembers.count >= 1 {
                        return  appointmentsTypes.contains(appointment.therapyId ?? 0) && filterInStaffAndGroup(facilityStaffMembers: facilityStaffMembers, appointment: appointment)
                        
                        //Mark:- Applying filters on appointment Types if any
                    } else if appointmentsTypes.count >= 1 {
                        return  appointmentsTypes.contains(appointment.therapyId ?? 0)
                        
                        //Mark:- Applying filters on facility staff
                    } else {
                        return filterInStaffAndGroup(facilityStaffMembers: facilityStaffMembers, appointment: appointment)
                    }
                }
            }
        }
        
        return  appointments
    }
    
    
    //Mark:- Filters to check the staff member exist in group
    func filterInStaffAndGroup(facilityStaffMembers: [Int], appointment: Appointment) -> Bool{
        if appointment.user != nil {
            return facilityStaffMembers.contains(appointment.user?.id ?? 0)
        } else {
            
            guard let groups = appointment.userGroup?.facilityGroupMembers else { return false}
            
            let exist = groups.map{
                group -> Bool in
                facilityStaffMembers.contains(group.userId ?? 0)
            }
            
            if exist.contains(true) {
                return true
            } else {
                return false
            }
        }
    }
    
}
