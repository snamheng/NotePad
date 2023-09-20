//
//  DataNotes+CoreDataProperties.swift
//  EditSpace
//
//  Created by heng on 14/9/23.
//
//

import Foundation
import CoreData


extension DataNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataNotes> {
        return NSFetchRequest<DataNotes>(entityName: "DataNotes")
    }

    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?

}

extension DataNotes : Identifiable {

}
