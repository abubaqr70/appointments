//
//  CDFacilityGroupMembers+CoreDataProperties.swift
//  Alamofire
//
//  Created by Muhammad Abubaqr on 29/09/2021.
//
//

import Foundation
import CoreData


extension CDFacilityGroupMembers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFacilityGroupMembers> {
        return NSFetchRequest<CDFacilityGroupMembers>(entityName: "CDFacilityGroupMembers")
    }

    @NSManaged public var groupId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var memberType: String?
    @NSManaged public var userId: Int64
    @NSManaged public var ofUserGroup: CDUserGroup?

}
