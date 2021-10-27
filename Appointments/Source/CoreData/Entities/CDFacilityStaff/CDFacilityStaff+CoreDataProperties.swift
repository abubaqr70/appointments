//
//  CDFacilityStaff+CoreDataProperties.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 27/10/2021.
//
//

import Foundation
import CoreData


extension CDFacilityStaff {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFacilityStaff> {
        return NSFetchRequest<CDFacilityStaff>(entityName: "CDFacilityStaff")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var lastName: String?
    @NSManaged public var staffId: Int64
    @NSManaged public var facilityId: Int64

}
