//
//  ProfileSettingsController.swift
//  TuTour
//
//  Created by Alan Boo on 2/5/19.
//  Copyright © 2019 JoshTaylorKardos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import TextFieldEffects

class ProfileSettingsController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
  
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var schoolField: UITextField!
    @IBOutlet weak var majorField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    // for profile picture choosing
    var selectedPhoto : UIImage?
    @IBAction func confirmAction(_ sender: Any) {
        
        
        
        
    }
    func getData(uid: String) {
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {(snapshot) in
            
            let profileImageString = (snapshot.value as! NSDictionary)["profileImageUrl"] as! String
            let url = URL(string: profileImageString)
            let imageData = NSData.init(contentsOf: url as! URL)
            self.profilePhoto?.image = UIImage(data: imageData as! Data)
            
        })
        
    }
    
    func styleFields(field: UITextField) -> IsaoTextField {
        
        let styledField = IsaoTextField(frame: field.frame)
        //styledField.placeholderColor = .lightGray
        styledField.activeColor = UIColor(red: 0/255, green: 106/255, blue: 255/255, alpha: 1.0)
        styledField.inactiveColor = .lightGray
        
        return styledField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userID = Auth.auth().currentUser!.uid
        
        getData(uid: userID)
        
        //update photo
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileSettingsController.handleSelectProfileImageView))
        // adds interaction to photo
        profilePhoto.isUserInteractionEnabled = true
        profilePhoto.addGestureRecognizer(tapGesture)
        
        let nameFieldIsao = styleFields(field: nameField)
        nameFieldIsao.placeholder = "Name"
        let schoolFieldIsao = styleFields(field: schoolField)
        schoolFieldIsao.placeholder = "School"
        let majorFieldIsao = styleFields(field: majorField)
        majorFieldIsao.placeholder = "Major"
        let yearFieldIsao = styleFields(field: yearField)
        yearFieldIsao.placeholder = "Year"
        let descriptionFieldIsao = styleFields(field: descriptionField)
        descriptionFieldIsao.placeholder = "Description"

        
        self.view.addSubview(nameFieldIsao)
        self.view.addSubview(schoolFieldIsao)
        self.view.addSubview(majorFieldIsao)
        self.view.addSubview(yearFieldIsao)
        self.view.addSubview(descriptionFieldIsao)
    }
    
    //UIPicker protocol stubs!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    @objc func handleSelectProfileImageView() {
        let pickerController = UIImagePickerController()
        //access to extension
        pickerController.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        present(pickerController, animated: true, completion: nil)
        
    }

    
}

extension ProfileSettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.selectedPhoto = image
            profilePhoto.image  = image
            
        }
        //print("** \(info) **")
        //profileImage.image = infoPhoto
        dismiss(animated: true, completion: nil)
    }
    
    
}
