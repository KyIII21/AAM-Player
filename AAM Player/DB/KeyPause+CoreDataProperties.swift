//
//  KeyPause+CoreDataProperties.swift
//  AAM Player
//
//  Created by Дмитрий on 10.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension KeyPause {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeyPause> {
        return NSFetchRequest<KeyPause>(entityName: "KeyPause")
    }

    @NSManaged public var key: String?
    @NSManaged public var pause: Int16
    @NSManaged public var playlist: Playlist?

}
