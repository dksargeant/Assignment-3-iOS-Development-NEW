//
//  DatabaseHelper.swift
//  Assignment2
//
//  Created by Rocco Alexander on 2021-03-28.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    private static var shared : DatabaseHelper?
    
    static func getInstance() -> DatabaseHelper{
        if(shared != nil){
            return shared!
        }else{
            return DatabaseHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
    }
    
    private let moc : NSManagedObjectContext
    private let ENTITY_NAME = "Orders"
    
    private init(context: NSManagedObjectContext){
        self.moc = context
    }
    
//    Insert
    func insertOrder(new:Order){
        do{
            let newOrder = NSEntityDescription.insertNewObject(forEntityName: ENTITY_NAME, into: self.moc) as! Orders
            newOrder.size = new.size
            newOrder.name = new.name
            newOrder.quantity = new.quantity
            newOrder.date = Date()
            newOrder.id = UUID()
            
            if self.moc.hasChanges{
                try self.moc.save()
                print("Order saved")
            }
        }catch let error as NSError{
            print("Error inserting new Order: \(error)")
        }
    }
    
//    Search for Order by ID
    func searchOrder(orderID: UUID) -> Orders?{
        let fetchRequest = NSFetchRequest<Orders>(entityName: ENTITY_NAME)
        let predicateID = NSPredicate(format: "id == %@", orderID as CVarArg)
        fetchRequest.predicate = predicateID
        do{
            let result = try self.moc.fetch(fetchRequest)
            if(result.count > 0){
                return result.first as? Orders
            }
        }catch let error as NSError{
            print("Error searching for Oder: \(error)")
        }
        return nil
    }
    
//    Update order by ID
    func updateOrder(quantity: String, orderID: UUID){
        let result = self.searchOrder(orderID: orderID)
        if(result != nil){
            do{
                let updatedOrder = result
                updatedOrder?.quantity = quantity
                
                try self.moc.save()
                print("Order updated")
            }catch let error as NSError{
                print("Error updating order: \(error)")
            }
        }
    }
//    Delete Order by ID
    func deleteOrder(orderID: UUID){
        let result = self.searchOrder(orderID: orderID)
        if(result != nil){
            do{
                self.moc.delete(result!)
                try self.moc.save()
                print("Order Deleted")
            }catch let error as NSError{
                print("Error deleting order: \(error)")
            }
        }
    }
//    Get all Orders
    func getAllOrders() -> [Orders]?{
        let fetchRequest = NSFetchRequest<Orders>(entityName: ENTITY_NAME)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key:"date",ascending: false)]
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function,"Fetched Data: \(result as [Orders])")
            return result as [Orders]
        }catch let error as NSError{
            print("Error fetching list: \(error)")
        }
        return nil
    }
}
