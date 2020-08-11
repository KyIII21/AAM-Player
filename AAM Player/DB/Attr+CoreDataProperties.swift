//
//  Attr+CoreDataProperties.swift
//  AAM Player
//
//  Created by Дмитрий on 08.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension Attr {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Attr> {
        return NSFetchRequest<Attr>(entityName: "Attr")
    }

    @NSManaged public var key: String?
    @NSManaged public var text: String?
    @NSManaged public var sound: String?
    @NSManaged public var display: Bool
    @NSManaged public var item: Item?
    
    public var wrappedText: String {
        if display {
            return text ?? ""
        }else {
            return ""
        }
    }
    
    public var wrappedSound: String {
        if display {
            return sound ?? ""
        }else {
            return ""
        }
    }

}
