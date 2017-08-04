//
//  File.swift
//  Journal
//
//  Created by JordanLin on 2017/8/4.
//  Copyright © 2017年 JordanLin. All rights reserved.
//

import Foundation

import UIKit

extension CreateJournalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func pickImageAction() {
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            let openCamera = UIAlertAction(title: "Open camera", style: .default) { action in
                
                imagePicker.sourceType = .camera
                
                self.present(imagePicker, animated: true, completion: nil)
                
            }
            
            actionSheet.addAction(openCamera)
            
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let openPhotoAlbum = UIAlertAction(title: "Open album", style: .default) { action in
                
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: true, completion: nil)
                
            }
            
            actionSheet.addAction(openPhotoAlbum)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
        
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
