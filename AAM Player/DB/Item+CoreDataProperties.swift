//
//  Item+CoreDataProperties.swift
//  AAM Player
//
//  Created by Дмитрий on 11.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID
    @NSManaged public var attrs: NSOrderedSet?
    @NSManaged public var playlist: Playlist?
    
    public var wrappedName: String {
        name ?? "Unknown ItemName"
    }
    
    public var attrsArray: [Attr] {
        return attrs?.array as? [Attr] ?? []
    }
    
    public var displayAttr: Attr {
        for attr in attrsArray{
            if attr.display{
                return attr
            }
        }
        return attrsArray[0]
    }

}

// MARK: Generated accessors for attrs
extension Item {

    @objc(insertObject:inAttrsAtIndex:)
    @NSManaged public func insertIntoAttrs(_ value: Attr, at idx: Int)

    @objc(removeObjectFromAttrsAtIndex:)
    @NSManaged public func removeFromAttrs(at idx: Int)

    @objc(insertAttrs:atIndexes:)
    @NSManaged public func insertIntoAttrs(_ values: [Attr], at indexes: NSIndexSet)

    @objc(removeAttrsAtIndexes:)
    @NSManaged public func removeFromAttrs(at indexes: NSIndexSet)

    @objc(replaceObjectInAttrsAtIndex:withObject:)
    @NSManaged public func replaceAttrs(at idx: Int, with value: Attr)

    @objc(replaceAttrsAtIndexes:withAttrs:)
    @NSManaged public func replaceAttrs(at indexes: NSIndexSet, with values: [Attr])

    @objc(addAttrsObject:)
    @NSManaged public func addToAttrs(_ value: Attr)

    @objc(removeAttrsObject:)
    @NSManaged public func removeFromAttrs(_ value: Attr)

    @objc(addAttrs:)
    @NSManaged public func addToAttrs(_ values: NSOrderedSet)

    @objc(removeAttrs:)
    @NSManaged public func removeFromAttrs(_ values: NSOrderedSet)

}
