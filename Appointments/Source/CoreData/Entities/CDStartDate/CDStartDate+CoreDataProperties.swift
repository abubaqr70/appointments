//
//  CDStartDate+CoreDataProperties.swift
//  Alamofire
//
//  Created by Muhammad Abubaqr on 29/09/2021.
//
//

import Foundation
import CoreData


extension CDStartDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStartDate> {
        return NSFetchRequest<CDStartDate>(entityName: "CDStartDate")
    }

    @NSManaged public var date: String?
    @NSManaged public var timeString: String?
    @NSManaged public var ofAppointments: CDAppointment?

}
