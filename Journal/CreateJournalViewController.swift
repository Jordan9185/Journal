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
    
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var isKeyboardShowed: Bool = false
    
    let journalManager = JournalManager()
    
    var currentJournal:Journal?
    
    var currentIndex:Int?
    
    var isReadingMode:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setloaderImageViewConfig()
        
        setTextFieldConfig()
        
        setSaveButtonConfig()
        
        if isReadingMode {
            
            setReadingModeConfig()
            
        }
        
        setKeyboardObserver()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    func setKeyboardObserver() {
        
        let center = NotificationCenter.default
        
        center.addObserver(self,
                           selector: #selector(keyboardWillShow),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if self.isKeyboardShowed == false {
            
            self.isKeyboardShowed = true
            
            let userInfo: NSDictionary = notification.userInfo! as NSDictionary
            
            let keyboardSize = (userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey)! as AnyObject).cgRectValue.size
            
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
            scrollView.contentInset = contentInsets
            
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        if self.isKeyboardShowed == true {
            
            self.isKeyboardShowed = false
            
            scrollView.contentInset = UIEdgeInsets.zero
            
        }
        
    }
    
    func setSaveButtonConfig() {
        
        saveButton.backgroundColor = dustyOrangeColor
        
        saveButton.layer.cornerRadius = 22
        
        saveButton.layer.shadowColor = blushColor.cgColor
        
        saveButton.layer.shadowOpacity = 1
        
        saveButton.layer.shadowOffset = CGSize.zero
        
        saveButton.titleLabel?.font = UIFont(name: ".SFUIText-Regular", size: 20)
        
    }
    
    func setloaderImageViewConfig() {
        
        loaderImageView.tintColor = .white
        
        loaderImageView.isUserInteractionEnabled = true
        
        loaderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pickImageAction)))
        
    }
    
    func setTextFieldConfig() {
        
        titleTextField.delegate = self
        
        titleTextField.font = UIFont(name: ".SFUIText-Regular", size: 30)
        
        titleTextField.font = titleTextField.font?.withSize(30)
        
        titleTextField.textColor = slateColor
        
        contentTextField.delegate = self
        
        contentTextField.font = UIFont(name: ".SFUIText-Regular", size: 18)
        
        contentTextField.font = contentTextField.font?.withSize(18)
        
        contentTextField.textColor = contentTextColor
        
        contentTextField.contentVerticalAlignment = .top
        
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

        guard let imageData = UIImageJPEGRepresentation(image, 0.7) else {

            print(CreateJournalError.ImageConvertFail)
            
            return
            
        }
        
        if title == "" {
            
            showWarningforTitleIsEmpty()
            
            return
            
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
