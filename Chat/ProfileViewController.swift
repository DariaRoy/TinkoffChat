//
//  ViewController.swift
//  Chat
//
//  Created by Air on 27.09.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var editButton: UIButton! {
        didSet {
            editButton.layer.cornerRadius = 8
            editButton.layer.borderWidth = 1.5
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var pickImage: UIButton! {
        didSet {
            pickImage.backgroundColor = UIColor(red:0.25, green:0.47, blue:0.94, alpha:1.0)

            let img = UIImage(named: "slr-camera")
            pickImage.setImage(img, for: UIControlState.normal)
            pickImage.layer.masksToBounds = true
            let indent = pickImage.frame.height / 5
            pickImage.imageEdgeInsets = UIEdgeInsets(top: indent, left: indent, bottom: indent, right: indent)
            pickImage.layer.cornerRadius = pickImage.frame.height / 2
        }
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil,bundle: nibBundleOrNil)
        //print(editButton.frame)
        //Outlets еще не установлены

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //print(editButton.frame)
        //Outlets еще не установлены
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = pickImage.frame.height / 2
        
        print(editButton.frame)
    }

    override func viewWillAppear(_ animated: Bool) {
        print(editButton.frame)
        
        //frame не отличается
        //В методе viewDidAppear отличалось бы из-за изменений под верстку на запущенном девайсе
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Action
    
    @IBAction func pickImageProfile(_ sender: UIButton) {
        
        print("Выбери изображение профиля")
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Выберите изображение профиля", message: nil, preferredStyle: .actionSheet)
        let libButton = UIAlertAction(title: "Установить из галереи", style: .default) {
            (libSelected) in
            //print("Library Selected")
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        let cameraButton = UIAlertAction(title: "Сделать фото", style: .default) {
            (camSelected) in
            //print("Camera Selected")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) {
            (cancelSelected) in
            print("Cancel Selected")
        }
        actionSheet.addAction(libButton)
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(cancelButton)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
