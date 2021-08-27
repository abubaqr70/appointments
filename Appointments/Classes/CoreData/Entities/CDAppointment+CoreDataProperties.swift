//
//  CDAppointment+CoreDataProperties.swift
//  Appointments
//
//  Created by Hussaan S on 27/08/2021.
//
//

import Foundation
import CoreData


extension CDAppointment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDAppointment> {
        return NSFetchRequest<CDAppointment>(entityName: "CDAppointment")
    }

    @NSManaged public var title: String?

}
