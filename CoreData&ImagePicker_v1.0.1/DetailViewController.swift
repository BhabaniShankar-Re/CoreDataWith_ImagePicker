//
//  DetailViewController.swift
//  CoreData&ImagePicker_v1.0.1
//
//  Created by Bhabani Shankar on 30/10/19.
//  Copyright © 2019 Bhabani Shankar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileNamelabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    var imagePicker: ImagePicker!
    var imageFile: UIImage!
    var text: String!
    var coredataStf = CoredatStuff()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = imageFile
        profileNamelabel.text = self.text
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tapedImage(tapgesture:)))
        imageView.isUserInteractionEnabled = true
        
        imageView.addGestureRecognizer(tapgesture)
        
        self.imagePicker = ImagePicker(presntationContr: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        editButton.layer.cornerRadius = editButton.frame.height/2
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        print("find button")
        if inputField.isHidden == true{
            inputField.isHidden = false
            editButton.backgroundColor = .init(red: 0, green: 122, blue: 255, alpha: 1)
            editButton.setTitleColor(.white, for: .normal)
            editButton.setTitle("Save", for: .normal)
        }else{
            inputField.isHidden = true
            editButton.backgroundColor = .red //.init(red: 180, green: 180, blue: 244, alpha: 1)
            editButton.setTitleColor(.blue, for: .normal)
            editButton.setTitle("edit", for: .normal)
            
            if let newNameis = inputField?.text, newNameis != ""{
                if let name = profileNamelabel.text{
                    coredataStf.updateData(name: name, image: nil, newName: newNameis)
                }
                profileNamelabel.text = inputField.text
            }
        }
        
    }
    @objc func tapedImage(tapgesture:UITapGestureRecognizer){
        self.imagePicker.present(from: tapgesture)
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        guard let image = imageView.image, let text = profileNamelabel.text else{
//            fatalError("found error when unwraping value in image and name")
//        }
//        coredataStf.updateData(name: text, image: image)
//    }
    

}
extension DetailViewController: PickerDelegate{
    func didSelect(image: UIImage?) {
        self.imageView.image = image
      //  print(profileNamelabel.text,image?.pngData())
         if let text = profileNamelabel.text, let imageData = image {
            print(text,imageData)
            coredataStf.updateData(name: text, image: imageData, newName: nil)
            try? coredataStf.managedContext.save()
        }
        
    }

}



//extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    
//}

