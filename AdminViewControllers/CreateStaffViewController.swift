//
//  CreateStaffViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 08/10/21.
//

import UIKit

class CreateStaffViewController: UIViewController {
    
    var staff: StaffNew = StaffNew()
    let staffInfoController = StaffController()
    
    let accessLevelValues = ["", "thanatologist", "admin", "admin_support"]
    let accessLevelOptions = ["", "Tanatólogo", "Admin", "Soporte"]

    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var firstLastnameField: UITextField!
    @IBOutlet var secondLastnameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var cellphoneField: UITextField!
    @IBOutlet var neighborhoodField: UITextField!
    @IBOutlet var streetField: UITextField!
    @IBOutlet var zipCodeField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var specialtyField: UITextView!
    @IBOutlet var accessLevelField: UIPickerView!
    
    let alertSuccess = UIAlertController(title: "Staff agregado", message: "El nuevo staff se ha agregado a la base de datos. Debe proporcionarle la contraseña de acceso para que pueda cambiarla e iniciar sesión.", preferredStyle: .alert)
    
    let validationError = UIAlertController(title: "Datos no válidos", message:"", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setEditing(true, animated: true)
        
        firstnameField.text = ""
        firstLastnameField.text = ""
        secondLastnameField.text = ""
        emailField.text = ""
        passwordField.text = ""
        cellphoneField.text = ""
        neighborhoodField.text = ""
        streetField.text = ""
        zipCodeField.text = ""
        numberField.text = ""
        specialtyField.text = ""
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        alertSuccess.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        validationError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        accessLevelField.delegate = self
        accessLevelField.dataSource = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createButtonTrigger))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc func createButtonTrigger() -> Void{
        view.endEditing(true)
        self.updateModel()
        let validation = self.staff.isValid()
        if validation != nil {
            self.validationError.message = validation
            self.present(self.validationError, animated: true)
        }
        else{
            self.staff.makeSecure()
            staffInfoController.createStaff(staff: staff, completion: {
                DispatchQueue.main.async {
                    self.present(self.alertSuccess, animated: true)
                    self.disableEdit()
                }
            })
            setEditing(false, animated: true)
        }
    }
    
    func updateModel(){
        staff.firstname = firstnameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        staff.firstLastname = firstLastnameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        staff.secondLastname = secondLastnameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        staff.cellphone = cellphoneField.text
        staff.neighborhood = neighborhoodField.text
        staff.street = streetField.text
        staff.zipCode = zipCodeField.text
        staff.addressNumber = numberField.text
        staff.specialty = specialtyField.text
        staff.email = emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        staff.password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func disableEdit(){
        firstnameField.isUserInteractionEnabled = false
        firstLastnameField.isUserInteractionEnabled = false
        secondLastnameField.isUserInteractionEnabled = false
        cellphoneField.isUserInteractionEnabled = false
        neighborhoodField.isUserInteractionEnabled = false
        streetField.isUserInteractionEnabled = false
        zipCodeField.isUserInteractionEnabled = false
        numberField.isUserInteractionEnabled = false
        specialtyField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        passwordField.isUserInteractionEnabled = false
        accessLevelField.isUserInteractionEnabled = false
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension CreateStaffViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return accessLevelOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return accessLevelOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.staff.accessLevel = accessLevelValues[row]
    }
}
