//
//  CreateJournalViewController.swift
//  Journal
//
//  Created by JordanLin on 2017/8/4.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import UIKit

enum CreateJournalError:Error {
    
    case ImageIsNil,ImageConvertFail
    
}

class CreateJournalViewController: UIViewController {

    @IBOutlet var loaderImageView: UIImageView!
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var contentTextField: UITextField!
    
    let journalManager = JournalManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setloaderImageViewConfig()
        
        setTextFieldConfig()
        
    }

    func setloaderImageViewConfig() {
        
        loaderImageView.tintColor = .white
        
        loaderImageView.isUserInteractionEnabled = true
        
        loaderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImageAction)))
        
    }
    
    func setTextFieldConfig() {
        
        titleTextField.delegate = self
        
        contentTextField.delegate = self
        
    }
    
    func pickImageAction() {
        
        print("pickImageAction()")
        
    }
    
    @IBAction func saveJournalActionTapped(_ sender: UIButton) {
        
        let title = titleTextField.text ?? ""
        
        let content = contentTextField.text ?? ""
        
        guard let image = loaderImageView.image else {
            
            print(CreateJournalError.ImageIsNil)
            
            return
            
        }
        
        guard let imageData = UIImagePNGRepresentation(image) else {

            print(CreateJournalError.ImageConvertFail)
            
            return
            
        }
        
        if title == "" {
            
            showWarningforTitleIsEmpty()
            
        }
        
        journalManager.addJournal(title: title, imageData: imageData, content: content)
        
        dismiss(animated: true, completion: nil)
    
    }
    
    func showWarningforTitleIsEmpty() {
        
        let alertController = UIAlertController(title: "Empty", message: "Title must exist.", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelCreateEvent(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension CreateJournalViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}
