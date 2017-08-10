//
//  Beer+CoreDataProperties.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 03/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension Beer {
    
    @nonobjc private class func fetchRequest() -> NSFetchRequest<Beer> {
        return NSFetchRequest<Beer>(entityName: "Beer")
    }
    
    @nonobjc private class func fetchRequest(by name: String) -> NSFetchRequest<Beer> {
        let fetch = NSFetchRequest<Beer>(entityName: "Beer")
        fetch.predicate = NSPredicate(format: "name CONTAINS %@", name)
        return fetch
    }
    
    @nonobjc public class func fetchAll() -> [Beer] {
        do {
            let entities = try DatabaseController.persistentContainer.viewContext.fetch(Beer.fetchRequest())
            if let beers = entities as? [Beer] {
                return beers
            }
        } catch {
            fatalError("Failed to fetch beers: \(error)")
        }
        return []
    }
    
    @nonobjc public class func fetch(by name: String) -> [Beer] {
        do {
            return try (DatabaseController.persistentContainer.viewContext.fetch(Beer.fetchRequest(by: name))) as [Beer]
        } catch {
            fatalError("Failed to fetch beers: \(error)")
        }
        return []
    }
    
    @nonobjc public class func insertBeer(with name: String, and price: Float, and picture: UIImage?) -> [String] {
        var errors: [String] = []
        
        if !name.isValid() { errors.append("Nome inválido")     }
        if price.isZero    { errors.append("Preço inválido")    }
        if picture == nil  { errors.append("Foto não inserida") }
        
        if errors.isEmpty {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Beer", into: DatabaseController.persistentContainer.viewContext)
            if let beer = entity as? Beer {
                beer.name = name
                beer.price = price
                if let validPicture = picture {
                    beer.setPicture(image: validPicture)
                }
            }
            DatabaseController.saveContext()
        }
        
        return errors
    }
    
    public func setPicture(image: UIImage) {
        picture = NSData(data: UIImageJPEGRepresentation(image, 0.9)!)
    }
    
    public func getPicture() -> UIImage {
        return UIImage(data: self.picture! as Data)!
    }
    
    @NSManaged public var name: String?
    @NSManaged public var price: Float
    @NSManaged public var picture: NSData?
    
    
    
}
