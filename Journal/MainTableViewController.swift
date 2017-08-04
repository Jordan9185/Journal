//
//  MainTableViewController.swift
//  Journal
//
//  Created by JordanLin on 2017/8/4.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let journalManager = JournalManager()
    
    var journals: [Journal] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        syncDataWithCoreDataAndReloadTableView()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return journals.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell

        let indexOfRow = indexPath.row
        
        cell.mainImageView.image = UIImage(data: journals[indexOfRow].image! as Data)
        
        cell.titleLabel.text = journals[indexOfRow].title

        cell.tag = indexOfRow
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let indexOfRow = indexPath.row
        
        if editingStyle == .delete {

            journalManager.deleteJournal(indexPath: indexOfRow)
            
            syncDataWithCoreDataAndReloadTableView()
            
        }
        
    }
    
    func syncDataWithCoreDataAndReloadTableView() {
        
        journals = journalManager.fetchJournals()
        
        self.tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ReadingMode" {
            
            let nextViewController = segue.destination as! CreateJournalViewController
            
            let cellOfRow = (sender as! MainTableViewCell).tag
            
            nextViewController.currentJournal = journals[cellOfRow]
            
            nextViewController.currentIndex = cellOfRow
            
            nextViewController.isReadingMode = true
            
        }
        
    }
    
}
