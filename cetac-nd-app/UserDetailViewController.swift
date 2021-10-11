//
//  UserDetailViewController.swift
//  cetac-nd-app
//
//  Created by user194238 on 10/8/21.
//

import UIKit

class UserDetailViewController: UIViewController {

    var user: UserDetail?
    var tempUser: UserDetail?
    var selectedUserId = 1
    let userInfoController = UserController()
    
    @IBOutlet weak var firstLastNameField: UITextField!
    @IBOutlet weak var secondLastNameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var maritalStatusField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var cellphoneField: UITextField!
    @IBOutlet weak var birthDateField: UITextField!
    @IBOutlet weak var birthPlaceField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var religionField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var addressNumberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        userInfoController.fetchDetail(userId: selectedUserId, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let userRes):
                    self.user = userRes
                    print(userRes)
                    self.fillData()
                
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.toggleEdit()
        if editing {
            self.tempUser = user
            navigationItem.title = NSLocalizedString("Editar usuario", comment: "Editar usuario")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
        } else {
            // show alert
        }
        navigationItem.title = NSLocalizedString("Detalle usuario", comment: "Detalle usuario")
        navigationItem.leftBarButtonItem = nil
    }

    @objc func cancelButtonTrigger() -> Void {
        self.user = tempUser
        self.tempUser = nil
        setEditing(false, animated: true)
    }
    
    func fillData() {
        firstLastNameField.text = user?.firstLastname
        secondLastNameField.text = user?.secondLastname
        nameField.text = user?.firstname
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
    }
    
    func toggleEdit() -> Void {
        firstLastNameField.isUserInteractionEnabled = !firstLastNameField.isUserInteractionEnabled
        secondLastNameField.isUserInteractionEnabled = !secondLastNameField.isUserInteractionEnabled
        nameField.isUserInteractionEnabled = !nameField.isUserInteractionEnabled
        genderField.isUserInteractionEnabled = !genderField.isUserInteractionEnabled
        maritalStatusField.isUserInteractionEnabled = !maritalStatusField.isUserInteractionEnabled
        phoneField.isUserInteractionEnabled = !phoneField.isUserInteractionEnabled
        cellphoneField.isUserInteractionEnabled = !cellphoneField.isUserInteractionEnabled
        birthDateField.isUserInteractionEnabled = !birthDateField.isUserInteractionEnabled
        birthPlaceField.isUserInteractionEnabled = !birthPlaceField.isUserInteractionEnabled
        occupationField.isUserInteractionEnabled = !occupationField.isUserInteractionEnabled
        religionField.isUserInteractionEnabled = !religionField.isUserInteractionEnabled
        zipCodeField.isUserInteractionEnabled = !zipCodeField.isUserInteractionEnabled
        streetField.isUserInteractionEnabled = !streetField.isUserInteractionEnabled
    }
}
