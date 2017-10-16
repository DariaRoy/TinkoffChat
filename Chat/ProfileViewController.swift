//
//  ViewController.swift
//  Chat
//
//  Created by Air on 27.09.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit
import Foundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    //model
//    var profileInfo: ProfileInfo? {
//        didSet {
//            self.nameTextField?.text = profileInfo?.name
//            self.profileImage?.image = profileInfo?.image
//            self.descriptionTextField?.text = profileInfo?.description
//        }
//    }
    
    
    var profileChange = false {
        didSet {
            saveButtonGCD.isEnabled = profileChange
            saveButtonOperation.isEnabled = profileChange
        }
    }
    
    
    @IBOutlet weak var saveButtonGCD: UIButton! {
        didSet {
            saveButtonGCD.isEnabled = false
            saveButtonGCD.layer.cornerRadius = 8
            saveButtonGCD.layer.borderWidth = 1.5
        }
    }
    @IBOutlet weak var saveButtonOperation: UIButton!  {
        didSet {
            saveButtonOperation.isEnabled = false
            saveButtonOperation.layer.cornerRadius = 8
            saveButtonOperation.layer.borderWidth = 1.5
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet weak var descriptionTextField: UITextField! {
        didSet {
            descriptionTextField.delegate = self
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var activeTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            //profileInfo?.image = profileImage.image
            profileImage.layer.masksToBounds = true
        }
    }

    let dataManagerGCD = GCDDataManager()
    let dataManagerOperation = OperationDataManager()
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = pickImage.frame.height / 2
       

        
        
        dataManagerGCD.loadData() {[weak self] (profile) in
            if profile != nil {
                //self?.profileInfo = profile
                self?.nameTextField?.text = profile?.name
                self?.profileImage?.image = profile?.image
                self?.descriptionTextField?.text = profile?.description
                print("YES, i am in viewdidload")
            } else {
                print("NOOOO")
                self?.nameTextField?.text = "Name"
                self?.profileImage?.image = #imageLiteral(resourceName: "placeholder")
                self?.descriptionTextField?.text = "About you"
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    @objc func keyboardDidShow (notification: Notification) {
        print("keyboardDidShow")
        
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height

        let editingTextFieldY: CGFloat! =  self.activeTextField?.frame.origin.y
        let edit = editingTextFieldY + (activeTextField.superview?.frame.origin.y)!

        if  edit > keyboardY - 60  {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - keyboardSize.height + self.saveButtonGCD.frame.height , width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
        }

    }
    
    @objc func keyboardWillHide (notification: Notification) {
                print("keyboardWillHide")
        UIView.animate(withDuration: 0.25, delay: 0.00, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)

    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        self.profileChange = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        //new
//        if textField === nameTextField {
//            profileInfo?.name = textField.text ?? "Name"
//        }
//        if textField === descriptionTextField {
//            profileInfo?.description = textField.text ?? "about you"
//        }
        
        //Hide the keyboard.
        textField.resignFirstResponder()
        return true
        
    }

    
    //MARK: Action
    
    @IBAction func pickImageProfile(_ sender: UIButton) {
//        nameTextField.resignFirstResponder()
//        descriptionTextField.resignFirstResponder()
        self.profileChange = true

        
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
    
    @IBAction func saveGCD(_ sender: UIButton) {
        
        saveButtonGCD.isEnabled = false
        saveButtonOperation.isEnabled = false
        spinner?.startAnimating()
        
        let info = ProfileInfo(name: nameTextField.text ?? "Name", description: descriptionTextField.text ?? "about you", image: profileImage.image)
        dataManagerGCD.saveData(info: info) { [weak self] (result) in
            self?.spinner.stopAnimating()
            self?.saveButtonGCD.isEnabled = true
            self?.saveButtonOperation.isEnabled = true
            if result {
                let alertController = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(actionOK)
                
                self?.present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
                
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(actionOK)
                
                let actionRepeat = UIAlertAction(title: "Повторить", style: .default, handler: { _ in self?.saveGCD((self?.saveButtonGCD)!)})
                alertController.addAction(actionRepeat)
                
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveOperation(_ sender: UIButton) {
        saveButtonGCD.isEnabled = false
        saveButtonOperation.isEnabled = false
        spinner?.startAnimating()
        
        let info = ProfileInfo(name: nameTextField.text ?? "Name", description: descriptionTextField.text ?? "about you", image: profileImage.image)
        dataManagerOperation.saveData(info: info) { [weak self] (result) in
            self?.spinner.stopAnimating()
            self?.saveButtonGCD.isEnabled = true
            self?.saveButtonOperation.isEnabled = true
            if result {
                let alertController = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(actionOK)
                
                self?.present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
                
                let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(actionOK)
                
                let actionRepeat = UIAlertAction(title: "Повторить", style: .default, handler: { _ in self?.saveOperation((self?.saveButtonOperation)!)})
                alertController.addAction(actionRepeat)
                
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }

}
