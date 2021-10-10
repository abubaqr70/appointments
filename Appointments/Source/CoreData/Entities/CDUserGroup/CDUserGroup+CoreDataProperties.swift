// Copyright © 2021 Caremerge. All rights reserved.

import Foundation
import CoreData


extension CDUserGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserGroup> {
        return NSFetchRequest<CDUserGroup>(entityName: "CDUserGroup")
    }

    @NSManaged public var categoryId: Int64
    @NSManaged public var facilityId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var facilityCategory: CDFacilityCategory?
    @NSManaged public var facilityGroupMembers: NSSet?
    @NSManaged public var ofAppointments: CDAppointment?

}

// MARK: Generated accessors for facilityGroupMembers
extension CDUserGroup {

    @objc(addFacilityGroupMembersObject:)
    @NSManaged public func addToFacilityGroupMembers(_ value: CDFacilityGroupMembers)

    @objc(removeFacilityGroupMembersObject:)
    @NSManaged public func removeFromFacilityGroupMembers(_ value: CDFacilityGroupMembers)

    @objc(addFacilityGroupMembers:)
    @NSManaged public func addToFacilityGroupMembers(_ values: NSSet)

    @objc(removeFacilityGroupMembers:)
    @NSManaged public func removeFromFacilityGroupMembers(_ values: NSSet)

}
