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
    
    let imagePicker = UIImagePickerController()
    
    var currentJournal:Journal?
    
    var currentIndex:Int?
    
    var isReadingMode:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setloaderImageViewConfig()
        
        setTextFieldConfig()
        
        if isReadingMode {
            
            setReadingModeConfig()
            
        }
        
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
    
    func setReadingModeConfig() {
        
        guard let data = currentJournal?.image as Data? else {
            
            print("Convert Image to Data fail.")
            
            return
            
        }
        
        let image = UIImage(data: data)
        
        loaderImageView.image = image
        
        loaderImageView.contentMode = .scaleAspectFill
        
        titleTextField.text = currentJournal?.title
        
        contentTextField.text = currentJournal?.content
        
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
        
        if isReadingMode {
            
            journalManager.updateProduct(
                indexPath: currentIndex!,
                title: title,
                imageData: imageData,
                content: content
            )
            
        } else {
            
            journalManager.addJournal(
                title: title,
                imageData: imageData,
                content: content
            )
            
        }
        
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

extension CreateJournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickImageAction() {
        
        self.imagePicker.delegate = self
        
        self.imagePicker.sourceType = .photoLibrary
        
        self.present(self.imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.loaderImageView.image = image
            
        } else {
            
            print("pick image fail")
            
        }
        
        self.loaderImageView.contentMode = .scaleAspectFill
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
