//
//  CDAppointmentTags+CoreDataProperties.swift
//  Alamofire
//
//  Created by Muhammad Abubaqr on 29/09/2021.
//
//

import Foundation
import CoreData


extension CDAppointmentTags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointmentTags> {
        return NSFetchRequest<CDAppointmentTags>(entityName: "CDAppointmentTags")
    }

    @NSManaged public var appointmentId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var tagActualText: String?
    @NSManaged public var tagId: Int64
    @NSManaged public var ofAppointments: CDAppointment?

}
