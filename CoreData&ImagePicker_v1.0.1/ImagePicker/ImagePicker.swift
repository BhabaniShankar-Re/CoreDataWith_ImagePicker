//
//  ImagePicker.swift
//  CoreData&ImagePicker_v1.0.1
//
//  Created by Bhabani Shankar on 02/11/19.
//  Copyright © 2019 Bhabani Shankar. All rights reserved.
//

import UIKit

protocol PickerDelegate: class {
    func didSelect(image: UIImage?)
}

class ImagePicker: NSObject{
    let imagePicker: UIImagePickerController
    weak var presentationControler: UIViewController?
    weak var delegate: PickerDelegate?
    
    init(presntationContr: UIViewController, delegate: PickerDelegate) {
        self.imagePicker = UIImagePickerController()
        super.init()
        
        self.presentationControler = presntationContr
        self.delegate = delegate
        
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = false
        self.imagePicker.mediaTypes = ["public.image"]
        self.imagePicker.sourceType = .photoLibrary
    }
    func present(from source: Any){
        self.presentationControler?.present(imagePicker, animated: true, completion: nil)
    }
    
}
extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegate?.didSelect(image: nil)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else{
            return print("cant pick the image")
        }
        self.delegate?.didSelect(image: image)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}
