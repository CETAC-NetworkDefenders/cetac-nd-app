//
//  UserInformationViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import UIKit

class UserInformationViewController: UIViewController {
    
    var parentRef: UserDetailViewController?
    
    var user: User?
    var tempUser: User?
    var selectedUserId: Int? 
    
    let userInfoController = UserController()
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var firstLastNameField: UITextField!
    @IBOutlet var secondLastNameField: UITextField!
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
    @IBOutlet var recordField: UITextField!
    
    let alertSuccess = UIAlertController(title: "Usuario actualizado", message: "La informacion del usuario se ha actualizado en la base de datos", preferredStyle: .alert)
    
    let validationError = UIAlertController(title: "Datos no validos", message: "", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parentRef = self.parent as? UserDetailViewController
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        alertSuccess.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        validationError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Information view just appeared")
        self.updateData()
        parentRef!.navigationItem.rightBarButtonItem = self.editButtonItem

    }
    
    func updateData(){
        print("Fetching the data for user id \(selectedUserId)")
        
        userInfoController.fetchDetail(userId: selectedUserId!, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let userRes):
                    self.user = userRes
                    self.fillData()
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            super.setEditing(editing, animated: animated)
            self.toggleEdit()
            self.tempUser = user
            navigationItem.title = NSLocalizedString("Editar usuario", comment: "Editar usuario")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
        } else {
            if tempUser != nil {
                self.updateModel()
                userInfoController.updateUser(user: user!, completion: {
                    DispatchQueue.main.async {
                        self.tempUser = nil
                        self.present(self.alertSuccess, animated: animated)
                    }
                })
                super.setEditing(editing, animated: animated)
            }
        }
        navigationItem.title = NSLocalizedString("Detalle Usuario", comment: "Detalle Usuario")
        navigationItem.leftBarButtonItem = nil
    }
    
    @objc func cancelButtonTrigger() -> Void {
        self.user = tempUser
        self.tempUser = nil
        setEditing(false, animated: true)
    }
    
    func updateModel() {
        user?.firstname = nameField.text
        user?.firstLastname = firstLastNameField.text
        user?.secondLastname = secondLastNameField.text
        user?.gender = genderField.text
        user?.maritalStatus = maritalStatusField.text
        user?.phone = phoneField.text
        user?.cellphone = cellphoneField.text
        user?.birthDate = birthDateField.text
        user?.birthPlace = birthPlaceField.text
        user?.occupation = occupationField.text
        user?.religion = religionField.text
        user?.zipCode = zipCodeField.text
        user?.street = streetField.text
        user?.addressNumber = addressNumberField.text
    }
    
    func fillData() {
        print("Data")
        print(user?.occupation)
        nameField.text = user?.firstname
        firstLastNameField.text = user?.firstLastname
        secondLastNameField.text = user?.secondLastname
        genderField.text = user?.gender
        maritalStatusField.text = user?.maritalStatus
        phoneField.text = user?.phone
        cellphoneField.text = user?.cellphone
        birthDateField.text = user?.birthDate
        birthPlaceField.text = user?.birthPlace
        occupationField.text = user?.occupation
        religionField.text = user?.religion
        zipCodeField.text = user?.zipCode
        streetField.text = user?.street
        addressNumberField.text = user?.addressNumber
        recordField.text = String(user!.record_id!)
    }
    
    func toggleEdit() -> Void {
        nameField.isUserInteractionEnabled = !nameField.isUserInteractionEnabled
        firstLastNameField.isUserInteractionEnabled = !firstLastNameField.isUserInteractionEnabled
        secondLastNameField.isUserInteractionEnabled = !secondLastNameField.isUserInteractionEnabled
        genderField.isUserInteractionEnabled = !genderField.isUserInteractionEnabled
        maritalStatusField.isUserInteractionEnabled = !maritalStatusField.isUserInteractionEnabled
        phoneField.isUserInteractionEnabled = !phoneField.isUserInteractionEnabled
        cellphoneField.isUserInteractionEnabled = !cellphoneField.isUserInteractionEnabled
        birthDateField.isUserInteractionEnabled = !birthDateField.isUserInteractionEnabled
        birthPlaceField.isUserInteractionEnabled = !birthPlaceField.isUserInteractionEnabled
        zipCodeField.isUserInteractionEnabled = !zipCodeField.isUserInteractionEnabled
        streetField.isUserInteractionEnabled = !streetField.isUserInteractionEnabled
        addressNumberField.isUserInteractionEnabled = !addressNumberField.isUserInteractionEnabled
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
