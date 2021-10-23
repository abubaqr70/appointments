//
//  CDLastUpdated+CoreDataProperties.swift
//  Alamofire
//
//  Created by Mohammad Abubaqr on 21/10/2021.
//
//

import Foundation
import CoreData


extension CDLastUpdated {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLastUpdated> {
        return NSFetchRequest<CDLastUpdated>(entityName: "CDLastUpdated")
    }

    @NSManaged public var date: Date?

}
