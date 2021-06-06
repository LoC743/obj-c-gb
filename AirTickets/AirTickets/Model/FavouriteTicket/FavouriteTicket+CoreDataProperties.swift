//
//  FavouriteTicket+CoreDataProperties.swift
//  AirTickets
//
//  Created by Alexey on 01.06.2021.
//
//

import Foundation
import CoreData


extension FavouriteTicket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteTicket> {
        return NSFetchRequest<FavouriteTicket>(entityName: "FavouriteTicket")
    }

    @NSManaged public var airline: String?
    @NSManaged public var created: Date?
    @NSManaged public var departure: Date?
    @NSManaged public var expires: Date?
    @NSManaged public var flightNumber: NSNumber
    @NSManaged public var from: String?
    @NSManaged public var price: NSNumber
    @NSManaged public var returnDate: Date?
    @NSManaged public var to: String?

}

extension FavouriteTicket : Identifiable {

}
