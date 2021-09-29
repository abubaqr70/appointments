//
//  CDFacilityCategory+CoreDataProperties.swift
//  Alamofire
//
//  Created by Muhammad Abubaqr on 29/09/2021.
//
//

import Foundation
import CoreData


extension CDFacilityCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFacilityCategory> {
        return NSFetchRequest<CDFacilityCategory>(entityName: "CDFacilityCategory")
    }

    @NSManaged public var facilityId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var ofUserGroup: CDUserGroup?

}
