//
//  Order.swift
//  Assignment2
//
//  Created by Rocco Alexander on 2/19/21.
//  033315151

import UIKit

class Order{
    var name: String
    var size: String
    var quantity: String
    
  
    init() {
        self.name = ""
        self.size = ""
        self.quantity = "0"
    }
    
    init?(name: String, size: String, quantity: String) {
        if(quantity.isEmpty){
           return nil
        }
        // Initialize the class
        self.name = name
        self.size = size
        self.quantity = quantity
    }
}
