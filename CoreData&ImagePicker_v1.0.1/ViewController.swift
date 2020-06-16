//
//  ViewController.swift
//  CoreData&ImagePicker_v1.0.1
//
//  Created by Bhabani Shankar on 30/10/19.
//  Copyright © 2019 Bhabani Shankar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let coredataStf = CoredatStuff()
    var profiles:[Profile]?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        //profiles = [Profile]()
      //  UpdataTableData()
        let barRightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = barRightButton
    }
    @objc func action(){
        let alertView = UIAlertController(title: "Profile", message: nil, preferredStyle: .alert)
        alertView.addTextField { (textField) in
            textField.placeholder = "EnterProfileName"
        }
        alertView.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak self](action) in
            if let textFiled = alertView.textFields?.first, let data = textFiled.text{
                print(data)
                self?.coredataStf.addData(name: data, image: nil)
                try? self?.coredataStf.managedContext.save()
                self?.UpdataTableData()
            }
        }))
        present(alertView, animated: true, completion: nil)
//        { [weak self] in
//            if let textFiled = alertView.textFields?.first, let data = textFiled.text{
//                print(data)
//                self?.coredataStf.addData(name: data, image: nil)
//           //     self?.UpdataTableData()
//            }
//
//        }
       // UpdataTableData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UpdataTableData()
    }


}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = profiles?.count{
            if count == 0{
                return 1
            }else{
                return count
            }
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! viewCell
        if let count = profiles?.count, count != 0{
            let data = profiles?[indexPath.item]
            print(indexPath.item)
           
            if let image = data?.profileImage{
                cell.image.image = UIImage(data: image)
            }else{
                cell.image.image = UIImage(named: "defaultImage")
            }
            
            if let name = data?.profileName{
                print("cell \(name)")
                cell.label.text = name
            }
        }else{
            cell.image.image = UIImage(named: "defaultImage")
            cell.label.text = "profileName"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        if let count = profiles?.count, count != 0{
            let data = profiles?[indexPath.item]
            if let image = data?.profileImage{
                view.imageFile = UIImage(data: image)
            }else{
                view.imageFile = UIImage(named: "defaultImage")
            }
            if let name = data?.profileName{
                view.text = name
            }
            
        }else{
              // view.imageView.image = UIImage(named: "defaultImage")
             //   view.profileNamelabel.text = "profileName"
            
            view.imageFile = UIImage(named: "defaultImage")
            view.text = "profileName"
        }
        navigationController?.pushViewController(view, animated: true)
        
        
    }
    func UpdataTableData(){
        profiles = coredataStf.fetchData()
        collectionView.reloadData()

    }
//    override func viewWillAppear(_ animated: Bool) {
//        profiles = coredataStf.fetchData()
//        if let count = profiles?.count{
//            print("array \(count)")
//        }
//        collectionView.reloadData()
//    }
}

