//
//  CDAppointmentUser+CoreDataProperties.swift
//  Alamofire
//
//  Created by Muhammad Abubaqr on 29/09/2021.
//
//

import Foundation
import CoreData


extension CDAppointmentUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointmentUser> {
        return NSFetchRequest<CDAppointmentUser>(entityName: "CDAppointmentUser")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
    @NSManaged public var id: Int64
    @NSManaged public var lastName: String?
    @NSManaged public var profileImageRoute: String?
    @NSManaged public var roomNo: String?
    @NSManaged public var ofAppointments: CDAppointment?
    @NSManaged public var ofAppointmentAttendance: CDAppointmentAttendance?

}
