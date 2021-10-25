//
//  CDFacilityStaff+CoreDataProperties.swift
//  Appointments
//
//  Created by Mohammad Abubaqr on 24/10/2021.
//
//

import Foundation
import CoreData


extension CDFacilityStaff {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFacilityStaff> {
        return NSFetchRequest<CDFacilityStaff>(entityName: "CDFacilityStaff")
    }

    @NSManaged public var codeStatus: String?
    @NSManaged public var email: String?
    @NSManaged public var facilities: String?
    @NSManaged public var facilityId: Int64
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var profileImageRoute: String?
    @NSManaged public var roomNo: String?
    @NSManaged public var staffId: Int64
    @NSManaged public var isSelected: Bool
    @NSManaged public var staff: NSSet?

}

// MARK: Generated accessors for staff
extension CDFacilityStaff {

    @objc(addStaffObject:)
    @NSManaged public func addToStaff(_ value: CDStaffRole)

    @objc(removeStaffObject:)
    @NSManaged public func removeFromStaff(_ value: CDStaffRole)

    @objc(addStaff:)
    @NSManaged public func addToStaff(_ values: NSSet)

    @objc(removeStaff:)
    @NSManaged public func removeFromStaff(_ values: NSSet)

}
