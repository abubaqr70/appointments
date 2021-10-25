//
//  CDStaffRole+CoreDataProperties.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 24/10/2021.
//
//

import Foundation
import CoreData


extension CDStaffRole {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStaffRole> {
        return NSFetchRequest<CDStaffRole>(entityName: "CDStaffRole")
    }

    @NSManaged public var staffId: Int64
    @NSManaged public var isEmployee: Int64
    @NSManaged public var isProfile: Int64
    @NSManaged public var roleId: Int64
    @NSManaged public var roleName: String?
    @NSManaged public var ofFacilityStaff: CDFacilityStaff?

}
