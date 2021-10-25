//
//  CDAppointmentsType+CoreDataProperties.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 24/10/2021.
//
//

import Foundation
import CoreData


extension CDAppointmentsType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointmentsType> {
        return NSFetchRequest<CDAppointmentsType>(entityName: "CDAppointmentsType")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var facilityId: Int64
    @NSManaged public var rank: Int64
    @NSManaged public var active: Bool
    @NSManaged public var created: Int64
    @NSManaged public var modified: Int64
    @NSManaged public var createdById: Int64
    @NSManaged public var isSelected: Bool

}
