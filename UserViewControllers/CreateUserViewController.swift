//
//  CreateUserViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import UIKit

class CreateUserViewController: UIViewController {

    var user: UserNew = UserNew()
    let userInfoController = UserController()
    
    
    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var firstLastnameField: UITextField!
    @IBOutlet var secondLastnameField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var maritalStatusField: UITextField!
    @IBOutlet var phoneField: UITextField!
    @IBOutlet var cellphoneField: UITextField!
    @IBOutlet var birthDateField: UITextField!
    @IBOutlet var birthPlaceField: UITextField!
    @IBOutlet var occupationField: UITextField!
    @IBOutlet var religionField: UITextField!
    @IBOutlet var zipCodeField: UITextField!
    @IBOutlet var streetField: UITextField!
    @IBOutlet var addressNumberField: UITextField!
    
    let alertSuccess = UIAlertController(title: "Usuario actualizado", message: "La informacion del usuario se ha actualizado en la base de datos", preferredStyle: .alert)
    
    let validationError = UIAlertController(title: "Datos no validos", message: "", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setEditing(true, animated: true)
        
        firstnameField.text = "test"
        firstLastnameField.text = "test"
        secondLastnameField.text = "test"
        genderField.text = "dudoso"
        maritalStatusField.text = "casado"
        phoneField.text = "55555555"
        cellphoneField.text = "5555555555"
        birthDateField.text = "1985-12-12"
        birthPlaceField.text = "test"
        occupationField.text = "test"
        religionField.text = "test"
        zipCodeField.text = "test"
        streetField.text = "test"
        addressNumberField.text = "69"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        alertSuccess.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        validationError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createButtonTrigger))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func createButtonTrigger() -> Void {
        view.endEditing(true)
        self.updateModel()
        // add validation
        userInfoController.createUser(user: user, completion: { DispatchQueue.main.async {
            self.present(self.alertSuccess, animated: true)
            self.disableEdit()
        }
        
        })
        setEditing(false, animated: true)
    }

    func updateModel() {
        user.firstname = firstnameField.text
        user.firstLastname = firstLastnameField.text
        user.secondLastname = secondLastnameField.text
        user.gender = genderField.text
        user.maritalStatus = maritalStatusField.text
        user.phone = phoneField.text
        user.cellphone = cellphoneField.text
        user.birthDate = birthDateField.text
        user.birthPlace = birthPlaceField.text
        user.occupation = occupationField.text
        user.religion = religionField.text
        user.zipCode = zipCodeField.text
        user.street = streetField.text
        user.addressNumber = addressNumberField.text
    }
    
    func disableEdit() {
        firstnameField.isUserInteractionEnabled = false
        firstLastnameField.isUserInteractionEnabled = false
        secondLastnameField.isUserInteractionEnabled = false
        genderField.isUserInteractionEnabled = false
        maritalStatusField.isUserInteractionEnabled = false
        phoneField.isUserInteractionEnabled = false
        cellphoneField.isUserInteractionEnabled = false
        birthDateField.isUserInteractionEnabled = false
        birthPlaceField.isUserInteractionEnabled = false
        occupationField.isUserInteractionEnabled = false
        religionField.isUserInteractionEnabled = false
        zipCodeField.isUserInteractionEnabled = false
        streetField.isUserInteractionEnabled = false
        addressNumberField.isUserInteractionEnabled = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
