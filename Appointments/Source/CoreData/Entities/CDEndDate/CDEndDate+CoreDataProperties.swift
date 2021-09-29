//
//  CDEndDate+CoreDataProperties.swift
//  Alamofire
//
//  Created by Muhammad Abubaqr on 29/09/2021.
//
//

import Foundation
import CoreData


extension CDEndDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEndDate> {
        return NSFetchRequest<CDEndDate>(entityName: "CDEndDate")
    }

    @NSManaged public var date: String?
    @NSManaged public var timeString: String?
    @NSManaged public var ofAppointments: CDAppointment?

}
