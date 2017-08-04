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
    
}

