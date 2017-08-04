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
        
        journals = journalManager.fetchJournals()
        
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
        
        cell.mainImageView.image = UIImage(data: journals[indexOfRow].image as! Data)
        
        cell.titleLabel.text = journals[indexOfRow].title

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let indexOfRow = indexPath.row
        
        if editingStyle == .delete {

            journalManager.deleteJournal(indexPath: indexOfRow)
            
            journals = journalManager.fetchJournals()
            
            self.tableView.reloadData()
            
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
