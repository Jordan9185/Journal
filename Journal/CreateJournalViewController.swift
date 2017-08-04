//
//  CreateJournalViewController.swift
//  Journal
//
//  Created by JordanLin on 2017/8/4.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

class CreateJournalViewController: UIViewController {

    @IBOutlet var loaderImageView: UIImageView!
    
    let journalManager = JournalManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setloaderImageViewConfig()
        
        
    }

    func setloaderImageViewConfig() {
        
        loaderImageView.tintColor = .white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
