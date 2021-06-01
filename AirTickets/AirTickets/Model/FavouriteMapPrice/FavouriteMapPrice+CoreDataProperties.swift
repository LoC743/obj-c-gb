//
//  FavouriteMapPrice+CoreDataProperties.swift
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//
//

import Foundation
import CoreData

extension FavouriteMapPrice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMapPrice> {
        return NSFetchRequest<FavouriteMapPrice>(entityName: "FavouriteMapPrice")
    }

    @NSManaged public var price: String?
    @NSManaged public var destination: String?
    @NSManaged public var departure: Date?
    @NSManaged public var created: Date?

}
