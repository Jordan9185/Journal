//
//  JournalManager.swift
//  Journal
//
//  Created by JordanLin on 2017/8/4.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

import UIKit

import CoreData

let addDelegate = UIApplication.shared.delegate as! AppDelegate

enum fetchDataError: Error {
    case fetchTitleError, fetchContentError, fetchImageDataError
}

class JournalManager {
    
    let context = addDelegate.persistentContainer.viewContext
    
    func addJournal(title: String, imageData: Data, content: String?) {
        
        let newJournal = Journal(context: context)
        
        newJournal.title = title
        newJournal.image = imageData as NSData
        
        if let content = content {
            newJournal.content = content
        }
        
        addDelegate.saveContext()
        
    }
    
    func fetchJournals() -> [Journal] {
        
        var Journals: [Journal] = []

        do {

            Journals = try context.fetch(Journal.fetchRequest())

        } catch (let error) {
            
            print(error)
        }
    
        return Journals
        
    }
//    
//    func searchProduct(productName: String) -> [Product] {
//        var products: [Product] = []
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
//        fetchRequest.predicate = NSPredicate(format: "name contains %@", productName)
//        
//        do {
//            
//            products = try context.fetch(fetchRequest) as! [Product]
//            
//        } catch (let error) {
//            print(error)
//        }
//        return products
//    }
//    
//    func updateProduct(indexPath: Int, id:String?, name: String?, price: Double?) {
//        let products = fetchProducts()
//        
//        if let productId = id {
//            products[indexPath].id = productId
//        }
//        if let productName = name {
//            products[indexPath].name = productName
//        }
//        if let productPrice = price {
//            products[indexPath].price = productPrice
//        }
//        
//        appDelegate.saveContext()
//    }
//    
//    func deleteProduct(indexPath: Int) {
//        let products = fetchProducts()
//        
//        context.delete(products[indexPath])
//        
//        appDelegate.saveContext()
//    }
//    

    
}

