//
//  CreateViewController.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 10/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var picture: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picture.isUserInteractionEnabled = true
    }
    
    @IBAction func create(_ sender: Any) {
        if let name = self.name.text {
            if let price = (self.price.text as NSString?)?.floatValue {
                if let picture = self.picture.image {
                    store.dispatch(CreateAction(name: name, price: price, picture: picture))
                } else {
                    self.invalidFieldsError()
                }
            } else {
                self.invalidFieldsError()
            }
        } else {
            self.invalidFieldsError()
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func setBeerPicture(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let shoot = UIAlertAction(title: "Shoot photo", style: .default, handler: { [unowned self] action in
            self.shootPhoto() })
        let select = UIAlertAction(title: "Pick photo", style: .default, handler: { [unowned self] action in
            self.showPickerPhoto() })
        alert.addAction(cancel)
        alert.addAction(select)
        alert.addAction(shoot)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func invalidFieldsError() {
        let alert = UIAlertController(title: "All fields are needed", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let shoot = UIAlertAction(title: "Ok", style: .default, handler: { [unowned self] action in self.shootPhoto() })
        alert.addAction(cancel)
        alert.addAction(shoot)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showPickerPhoto() {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
    }
    
    func shootPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ok",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.picture.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
