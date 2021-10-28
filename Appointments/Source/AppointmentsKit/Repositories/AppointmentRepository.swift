// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import RxSwift

class AppointmentRepository {
    
    let appointmentService: AppointmentService
    let appointmentDataStore: AppointmentsDataStore
    let facilityStaffDataStore: FacilityStaffDataStore
    let appointmentsTypeDataStore: AppointmentsTypeDataStore
    let lastUpdatedDataStore: LastUpdatedDataStore
    let reachabilityService: ReachabilityService
    var isSyncing: Bool
    
    init(appointmentService: AppointmentService, appointmentDataStore: AppointmentsDataStore, facilityStaffDataStore: FacilityStaffDataStore, appointmentsTypeDataStore: AppointmentsTypeDataStore, lastUpdatedDataStore: LastUpdatedDataStore, facilityDataStore: FacilityDataStore?) {
        self.appointmentService = appointmentService
        self.appointmentDataStore = appointmentDataStore
        self.facilityStaffDataStore = facilityStaffDataStore
        self.appointmentsTypeDataStore = appointmentsTypeDataStore
        self.lastUpdatedDataStore = lastUpdatedDataStore
        self.reachabilityService = ReachabilityService()
        self.isSyncing = false
    }
    
    //Mark:- Fetch Appointments with facilityID and date
    func getAppointments(for facilityID: Int,
                         date: Date) ->  Observable<([Appointment],Date?)> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            
            //Mark:- Checking Internet Connection
            let reachability = self.reachabilityService.reachabilityType
            switch reachability {
            
            //Mark:- Internet Connected
            case .connected:
                observer.onNext((self.appointmentDataStore.fetchAppointments(facilityId: facilityID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                let appointments = self.appointmentDataStore.fetchAppointmentsSyncedFalseWithFacilityId(facilityId: facilityID)
                if appointments.count >= 1 {
                    
                    //Mark:- Sync Appointments from server
                    if self.isSyncing == false {
                        self.localFacilitySyncData(facilityId: facilityID){
                            (result: Result<Void,Error>) in
                            self.isSyncing = false
                            switch result {
                            case .failure (let error) :
                                print(error.localizedDescription)
                            case .success (_):
                                print("success")
                                self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: nil)
                            }
                        }
                    }else{
                        
                        observer.onNext((self.appointmentDataStore.fetchAppointments(facilityId: facilityID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                    }
                }else {
                    self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: nil)
                }
                
            //Mark:- Internet Disconnected
            case .disconnected:
                
                observer.onNext((self.appointmentDataStore.fetchAppointments(facilityId: facilityID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
            }
            
            return Disposables.create()
        }
    }
    
    //Mark:- Fetch Appointments with facilityID, residentId and date
    func getAppointmentsForResident(for facilityID: Int,
                                    residentID: Int,
                                    date: Date) -> Observable<([Appointment],Date?)> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            //Mark:- Checking Internet Connection
            let reachability = self.reachabilityService.reachabilityType
            switch reachability {
            
            //Mark:- Internet Connected
            case .connected:
                
                observer.onNext((self.appointmentDataStore.fetchAppointmentsForResident(facilityId: facilityID, residentID: residentID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                let appointments = self.appointmentDataStore.fetchAppointmentsSyncedFalseWithFacilityId(facilityId: facilityID)
                if appointments.count >= 1 {
                    
                    //Mark:- Sync Appointments from server
                    if self.isSyncing == false {
                        self.localFacilitySyncData(facilityId: facilityID) {
                            (result: Result<Void,Error>) in
                            self.isSyncing = false
                            switch result {
                            case .failure (let error) :
                                print(error.localizedDescription)
                            case .success (_):
                                print("success")
                                self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: residentID)
                            }
                        }
                    }else{
                        
                        observer.onNext((self.appointmentDataStore.fetchAppointmentsForResident(facilityId: facilityID, residentID: residentID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                    }
                }else {
                    self.fetchAppointmentsFromServer(date: date, observer: observer, facilityID: facilityID, residentId: residentID)
                }
                
            //Mark:- Internet Disconnected
            case .disconnected:
                
                observer.onNext((self.appointmentDataStore.fetchAppointmentsForResident(facilityId: facilityID, residentID: residentID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                
            }
            
            return Disposables.create()
        }
    }
    
    //Mark:- Fetch Appointments from server
    func fetchAppointmentsFromServer(date : Date, observer : AnyObserver<([Appointment],Date?)>, facilityID: Int, residentId: Int?) {
        
        //Mark:- Appointments Service fetching appointments
        self.appointmentService.getAppointments(for: facilityID,
                                                startDate: Date.startOfMonth(date: date).timeIntervalSince1970,
                                                endDate: Date.endOfMonth(date: date).timeIntervalSince1970) { (result: Result<[Appointment], Error>) in
            
            switch result {
            case .failure(let error):
                observer.onError(error)
            case .success(let appointments):
                
                //Mark:- Checking if appointments of that month exist
                let exist = self.checkAppointmentsExist(facilityId: facilityID, startDate: Date.startOfMonth(date: date), with: Date.endOfMonth(date: date))
                
                //Mark:- Deleting appointments for that month
                if exist {
                    self.deleteAppointments(facilityId: facilityID, startDate: Date.startOfMonth(date: date), with: Date.endOfMonth(date: date))
                }
                try? self.lastUpdatedDataStore.deleteLastUpdated()
                
                //Mark:- Saving appointments for that month
                let updatedTime: Date = Date()
                self.lastUpdatedDataStore.saveLastUpdated(updatedTime)
                
                for appointment in appointments {
                    self.appointmentDataStore.saveAppointment(appointment,updatedTime)
                }
                
                //Mark:- Returning appointments for that day
                if residentId != nil {
                    
                    observer.onNext((self.appointmentDataStore.fetchAppointmentsForResident(facilityId: facilityID, residentID: residentId ?? 0, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                } else {
                    
                    observer.onNext((self.appointmentDataStore.fetchAppointments(facilityId: facilityID, startDate: Date.startOfDay(date: date)),self.lastUpdatedDataStore.fetchLastUpdated()))
                }
                observer.onCompleted()
            }
        }
        
    }
    
    
    //Mark:- Marking appointments in dataStore
    func updateAppointment(_ appointment: Appointment) {
        
        self.appointmentDataStore.updateAppointment(facilityId: appointment.facilityId ?? 0, appointment: appointment)
        
    }
    
    //Mark:- Syncing appointments on Server
    func markAppointmentsOnServer(_ appointments: [Appointment],completion: @escaping (Result<AppointmentsResponse,Error>) -> Void) {
        
        //Mark:- Appointments Service syncing appointments
        self.appointmentService.syncAppointments(for: appointments.first?.facilityId ?? 0, params: appointments,completion: completion )
        
    }
    
    //Mark:- Setting Syncing Status
    func setIsSyncing(isSyncing: Bool) {
        self.isSyncing = isSyncing
    }
    
    //Mark:- Getting Syncing Status
    func getIsSyncing() -> Bool {
        return self.isSyncing
    }
    
    //Mark:- Syncing appointments on dataStore
    func localFacilitySyncData(facilityId: Int, completion: @escaping (Result<Void,Error>) -> Void) {
        
        //Mark:- Setting isSyncing True
        self.isSyncing = true
        
        //Mark:- Fetch Appointments from dataStore which are not synced
        let appointments = self.appointmentDataStore.fetchAppointmentsSyncedFalseWithFacilityId(facilityId: facilityId)
        
        //Mark:- Syncing appointments on server
        self.markAppointmentsOnServer(appointments) {
            (result: Result<AppointmentsResponse, Error>) in
            switch result {
            
            //Mark:- Checking Syncing appointments success
            case .success(let appointmentsResponse):
                
                //Mark:- Marking appointments synced true in dataStore
                if appointmentsResponse.success == true {
                    
                    for appointment in appointments {
                        self.appointmentDataStore.markAppointmentsSyncedTrue(facilityId: facilityId, appointment: appointment)
                    }
                    
                }else {
                    
                    //Mark:- Marking only those appointments which are synced true from server in dataStore
                    let appointmentsSuccess : [Appointment] = appointments.filter { appointment in
                        return !(appointmentsResponse.failures?.contains(where: { appointmentFailure in
                            return appointmentFailure.id == appointment.id && appointmentFailure.occurrenceId == appointment.occurrenceId
                        }) ?? false)
                    }
                    
                    for appointment in appointmentsSuccess {
                        self.appointmentDataStore.markAppointmentsSyncedTrue(facilityId: facilityId, appointment: appointment)
                    }
                    
                }
                completion(Result.success(Void()))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    //Mark:- Syncing appointments on dataStore
    func syncData(completion: @escaping (Result<Void,Error>) -> Void) {
        
        //Mark:- Setting isSyncing True
        self.isSyncing = true
        
        //Mark:- Fetch Appointments from dataStore which are not synced
        let appointments = self.appointmentDataStore.fetchAppointmentsSyncedFalse()
        
        //Mark:- Syncing appointments on server
        self.markAppointmentsOnServer(appointments) {
            (result: Result<AppointmentsResponse, Error>) in
            switch result {
            
            //Mark:- Checking Syncing appointments success
            case .success(let appointmentsResponse):
                
                //Mark:- Marking appointments synced true in dataStore
                if appointmentsResponse.success == true {
                    
                    for appointment in appointments {
                        self.appointmentDataStore.markAppointmentsSyncedTrue(facilityId: appointment.facilityId ?? 0, appointment: appointment)
                    }
                    
                }else {
                    
                    //Mark:- Marking only those appointments which are synced true from server in dataStore
                    let appointmentsSuccess : [Appointment] = appointments.filter { appointment in
                        return !(appointmentsResponse.failures?.contains(where: { appointmentFailure in
                            return appointmentFailure.id == appointment.id && appointmentFailure.occurrenceId == appointment.occurrenceId
                        }) ?? false)
                    }
                    
                    for appointment in appointmentsSuccess {
                        self.appointmentDataStore.markAppointmentsSyncedTrue(facilityId: appointment.facilityId ?? 0, appointment: appointment)
                    }
                    
                }
                completion(Result.success(Void()))
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    //Mark:- Checking appointments of that month exist in dataStore
    func checkAppointmentsExist(facilityId: Int, startDate: Date, with endDate: Date) -> Bool {
        return self.appointmentDataStore.checkAppointmentsExist(facilityId: facilityId, startDate: Double(startDate.timeIntervalSince1970), endDate: Double(endDate.timeIntervalSince1970))
    }
    
    //Mark:- Deleting appointments of that month from dataStore
    func deleteAppointments(facilityId: Int, startDate: Date, with endDate: Date) {
        do {
            try self.appointmentDataStore.deleteAppointments(facilityId: facilityId, startDate: Double(startDate.timeIntervalSince1970), endDate: Double(endDate.timeIntervalSince1970))
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //Mark:- Deleting all appointments from dataStore
    func clearAllData(){
        do {
            try self.appointmentDataStore.deleteAllAppointment()
            try self.lastUpdatedDataStore.deleteLastUpdated()
            try self.appointmentsTypeDataStore.deleteAllAppointmentType()
            try self.facilityStaffDataStore.deleteAllFacilityStaff()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //Mark:- Marking all appointments type from dataStore
    public func markAllAppointmentsTypeStatus(facilityId: Int, status: Bool) {
        self.appointmentsTypeDataStore.markAllAppointmentsType(facilityId: facilityId, status: status)
    }
    
    //Mark:- Selecting Or Deselecting all Facility staff from dataStore
    public func markAllFacilityStaffStatus( facilityId: Int, facilityDataStore: FacilityDataStore,status: Bool) {
        if status {
            let facilityStaff = self.getFacilityStaffFromDictionary(for: facilityDataStore)
            for staff in facilityStaff {
                if !self.facilityStaffDataStore.checkFacilityStaffExist(facilityId: facilityId, facilityStaff: staff) {
                    self.facilityStaffDataStore.saveFacilityStaff(staff)
                }
            }
        } else {
            do {
                try self.facilityStaffDataStore.deleteFacilityStaffWithFacilityId(facilityId: facilityId)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    //Mark:- Marking appointments type from dataStore
    public func markAppointmentsType( facilityId: Int, appointmentType: AppointmentsType) {
        self.appointmentsTypeDataStore.updateAppointmentType(facilityId: facilityId, appointmentType: appointmentType)
    }
    
    //Mark:- Selecting Or Deselecting Facility staff from dataStore
    public func markFacilityStaff(facilityId: Int, facilityStaff: FacilityStaff) {
        
        if self.facilityStaffDataStore.checkFacilityStaffExist(facilityId: facilityId, facilityStaff: facilityStaff) {
            self.facilityStaffDataStore.deleteFacilityStaff(facilityId: facilityId, facilityStaff: facilityStaff)
        } else {
            self.facilityStaffDataStore.saveFacilityStaff(facilityStaff)
        }
        
    }
    
    //Mark:- Fetching selected AppointmentsType from dataStore
    public func getAppointmentsTypeSelected(facilityId: Int) -> [AppointmentsType] {
        self.appointmentsTypeDataStore.fetchAppointmentsTypeSelected(facilityId: facilityId)
    }
    
    //Mark:-  Fetching local AppointmentsType from dataStore
    public func getLocalAppointmentsType(facilityId: Int) -> [AppointmentsType] {
        self.appointmentsTypeDataStore.fetchAppointmentsType(facilityId: facilityId)
    }
    
    //Mark:- checking appointmentsFilter Applied
    public func isAppointmentsFilterApplied(facilityId: Int) -> Bool {
        if self.getFacilityStaffSelectedIds(facilityId: facilityId).count >= 1 {
            return true
        }
        if self.getAppointmentsTypeSelectedIds(facilityId: facilityId).count >= 1 {
            return true
        }
        return false
    }
    
    
    //Mark:- Fetching Selected Appointment Type Ids
    public func getAppointmentsTypeSelectedIds(facilityId: Int) -> [Int] {
        var selectedMembers = [Int]()
        for appointmentType in self.appointmentsTypeDataStore.fetchAppointmentsTypeSelected(facilityId: facilityId) {
            if appointmentType.id != nil {
                selectedMembers.append(appointmentType.id!)
            }
        }
        return selectedMembers
    }
    
    //Mark:- Fetching Selected Appointment Type Ids
    public func getFacilityStaffSelected(facilityId: Int) -> [FacilityStaff] {
        self.facilityStaffDataStore.fetchFacilityStaff(facilityId: facilityId)
    }
    
    //Mark:- Fetching Selected Staff Ids
    public func getFacilityStaffSelectedIds(facilityId: Int) -> [Int] {
        var selectedMembers = [Int]()
        for members in self.facilityStaffDataStore.fetchFacilityStaff(facilityId: facilityId) {
            if members.staffId != nil {
                selectedMembers.append(members.staffId!)
            }
        }
        return selectedMembers
    }
    
    //Mark:- Check wether mark or unmark Appointments Type
    public func checkForMarkAppointmentsType(facilityId: Int) -> Bool {
        if self.appointmentsTypeDataStore.fetchAppointmentsTypeSelected(facilityId: facilityId).count == self.appointmentsTypeDataStore.fetchAppointmentsType(facilityId: facilityId).count {
            return true
        }
        return false
    }
    
    //Mark:- Check wether isSelectedSome Appointments Type
    public func isSelectedSomeAppointmentsType(facilityId: Int) -> Bool {
        if self.getAppointmentsTypeSelectedIds(facilityId: facilityId).count >= 1 && !checkForMarkAppointmentsType(facilityId: facilityId){
            return true
        }
        return false
    }
    
    //Mark:- Check wether mark or unmark Facility Staff
    public func checkForMarkFacilityStaff(facilityId: Int, facilityDataStore: FacilityDataStore) -> Bool {
        if self.facilityStaffDataStore.fetchFacilityStaff(facilityId: facilityId).count == self.getFacilityStaffFromDictionary(for: facilityDataStore).count {
            return true
        }
        return false
    }
    
    //Mark:- Check wether isSelectedSome FacilityStaff
    public func isSelectedSomeFacilityStaff(facilityId: Int, facilityDataStore: FacilityDataStore) -> Bool {
        if self.getFacilityStaffSelectedIds(facilityId: facilityId).count >= 1 && !checkForMarkFacilityStaff(facilityId: facilityId, facilityDataStore: facilityDataStore){
            return true
        }
        return false
    }
    
    //Mark:- Fetch Appointments Type with FacilityId
    func getAppointmentsType(for facilityID: Int) ->  Observable<[AppointmentsType]> {
        
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            //Mark:- Checking Internet Connection
            let reachability = self.reachabilityService.reachabilityType
            switch reachability {
            
            //Mark:- Internet Connected
            case .connected:
                
                observer.onNext(self.appointmentsTypeDataStore.fetchAppointmentsType(facilityId: facilityID))
                self.appointmentService.getAppointmentsType(for: facilityID) { (result: Result<[AppointmentsType], Error>) in
                    
                    switch result {
                    case .success(let appointmentsType):
                        
                        //Mark:- Fetching CoreData appointments type Ids
                        let coreDataAppointmentsType : [Int] = self.appointmentsTypeDataStore.fetchAppointmentsType(facilityId: facilityID).map{
                            appointmentsType in
                            appointmentsType.id ?? 0
                        }
                        
                        //Mark:- Fetching Server appointments type Ids
                        let serverAppointmentsType : [Int] = appointmentsType.map{
                            appointmentsType in
                            appointmentsType.id ?? 0
                        }
                        
                        //Mark:- Deleting CoreData appointments type which are deleted from server
                        for appointmentType in coreDataAppointmentsType {
                            if !serverAppointmentsType.contains(appointmentType) {
                                self.appointmentsTypeDataStore.deleteAppointmentsType(facilityId: facilityID, appointmentTypeId: appointmentType)
                            }
                        }
                        
                        for appointmentType in appointmentsType {
                            
                            //Mark:- Checking if Appointment Type Exist
                            if !self.appointmentsTypeDataStore.checkAppointmentsTypeExist(facilityId: facilityID, appointmentsType: appointmentType) {
                                //Mark:- Saving New Appointment Type
                                self.appointmentsTypeDataStore.saveAppointmentsType(appointmentType)
                            } else {
                                //Mark:- Updating Existing Appointment Type
                                self.appointmentsTypeDataStore.updateAllAppointmentsType(facilityId: facilityID, appointmentsType: appointmentType)
                            }
                        }
                        
                        observer.onNext(self.appointmentsTypeDataStore.fetchAppointmentsType(facilityId: facilityID))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                
            //Mark:- Internet Disconnected
            case .disconnected:
                
                observer.onNext(self.appointmentsTypeDataStore.fetchAppointmentsType(facilityId: facilityID))
                
            }
            
            return Disposables.create()
        }
        
    }
    
    //Mark:- Fetch Facility Staff Observable
    func getFacilityStaff(for facilityDataStore: FacilityDataStore) ->  Observable<[FacilityStaff]> {
        
        return Observable.create { [weak self] observer in
            
            guard let self = self else { return Disposables.create() }
            
            let facilityStaff = self.getFacilityStaffFromDictionary(for: facilityDataStore)
            observer.onNext(facilityStaff)
            observer.onCompleted()
            return Disposables.create()
        }
        
    }
    
    //Mark:- Fetch Facility Staff From Dictionary
    func getFacilityStaffFromDictionary(for facilityDataStore: FacilityDataStore) -> [FacilityStaff] {
        do {
            guard let dictionary = facilityDataStore.currentFacility?["staff"] as? [[String : Any]] else {
                return [] }
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted])
            let facilityStaff : [FacilityStaff] = try self.decode(data: jsonData)
            
            //Mark:- Saving Facility staff
            return facilityStaff
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        return []
    }
    
    func decode<T: Codable>(data: Data) throws -> T {
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
}
