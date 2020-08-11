//
//  Playlist+CoreDataProperties.swift
//  AAM Player
//
//  Created by Дмитрий on 11.08.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var name: String?
    @NSManaged public var order: NSOrderedSet?
    @NSManaged public var items: NSOrderedSet?
    
    public var wrappedName: String {
        name ?? "Unknown PlaylistName"
    }
    
    public var itemsArray: [Item] {
        return items?.array as? [Item] ?? []
    }
    
    public var orderArray: [KeyPause] {
        return order?.array as? [KeyPause] ?? []
    }
    
    public var playlistForPlayer: PlaylistForPlayer{
        var queueArray = [PlaylistForPlayer.QueuePlaylist]()
        for item in itemsArray{
            for i in 0..<orderArray.count{
                var queue = PlaylistForPlayer.QueuePlaylist()
                let findAttr = item.attrsArray.first(where: {$0.key == orderArray[i].key})
                queue.sound = findAttr?.sound  ?? "Not URL"
                queue.pause = orderArray[i].pause
                queue.id = item.id
                queueArray.append(queue)
            }
        }
        return PlaylistForPlayer(playlistName: name ?? "Noname Playlist", queue: queueArray)
    }

}

// MARK: Generated accessors for order
extension Playlist {

    @objc(insertObject:inOrderAtIndex:)
    @NSManaged public func insertIntoOrder(_ value: KeyPause, at idx: Int)

    @objc(removeObjectFromOrderAtIndex:)
    @NSManaged public func removeFromOrder(at idx: Int)

    @objc(insertOrder:atIndexes:)
    @NSManaged public func insertIntoOrder(_ values: [KeyPause], at indexes: NSIndexSet)

    @objc(removeOrderAtIndexes:)
    @NSManaged public func removeFromOrder(at indexes: NSIndexSet)

    @objc(replaceObjectInOrderAtIndex:withObject:)
    @NSManaged public func replaceOrder(at idx: Int, with value: KeyPause)

    @objc(replaceOrderAtIndexes:withOrder:)
    @NSManaged public func replaceOrder(at indexes: NSIndexSet, with values: [KeyPause])

    @objc(addOrderObject:)
    @NSManaged public func addToOrder(_ value: KeyPause)

    @objc(removeOrderObject:)
    @NSManaged public func removeFromOrder(_ value: KeyPause)

    @objc(addOrder:)
    @NSManaged public func addToOrder(_ values: NSOrderedSet)

    @objc(removeOrder:)
    @NSManaged public func removeFromOrder(_ values: NSOrderedSet)

}

// MARK: Generated accessors for items
extension Playlist {

    @objc(insertObject:inItemsAtIndex:)
    @NSManaged public func insertIntoItems(_ value: Item, at idx: Int)

    @objc(removeObjectFromItemsAtIndex:)
    @NSManaged public func removeFromItems(at idx: Int)

    @objc(insertItems:atIndexes:)
    @NSManaged public func insertIntoItems(_ values: [Item], at indexes: NSIndexSet)

    @objc(removeItemsAtIndexes:)
    @NSManaged public func removeFromItems(at indexes: NSIndexSet)

    @objc(replaceObjectInItemsAtIndex:withObject:)
    @NSManaged public func replaceItems(at idx: Int, with value: Item)

    @objc(replaceItemsAtIndexes:withItems:)
    @NSManaged public func replaceItems(at indexes: NSIndexSet, with values: [Item])

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSOrderedSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSOrderedSet)

}
