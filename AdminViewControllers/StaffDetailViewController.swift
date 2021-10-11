//
//  StaffDetailViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 06/10/21.
//

import UIKit

class StaffDetailViewController: UIViewController {
    
    var parentRef: StaffListingViewController?
    
    var staff: StaffDetail?
    var tempStaff: StaffDetail?
    var selectedStaffId: Int?
    var isThanatologist: Bool? 
    
    let staffInfoController = StaffController()
    
    @IBOutlet var specialtyStack: UIStackView!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var firstLastNameField: UITextField!
    @IBOutlet var secondLastNameField: UITextField!
    @IBOutlet var cellphoneField: UITextField!
    @IBOutlet var neighborhoodField: UITextField!
    @IBOutlet var streetField: UITextField!
    @IBOutlet var zipCodeField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var specialtyField: UITextView!
    
    let alertSuccess = UIAlertController(title: "Staff actualizado", message: "La información del Staff se ha actualizado en la base de datos.", preferredStyle: .alert)
    
    let validationError = UIAlertController(title: "Datos no válidos", message:"", preferredStyle: .alert)
    
    let authenticationError = UIAlertController(title: "Permiso denegado", message:"Su rol de acceso es Soporte de Administración, por lo que no puede editar la información. Comuniquese con un administrador CETAC.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem

        staffInfoController.fetchDetail(staffId: selectedStaffId!, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let staffRes):
                        self.staff = staffRes
                        self.fillData()
                    
                    case .failure(let error):
                        print(error)
                }
            }
        })
        
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        alertSuccess.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        validationError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        authenticationError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        if editing {
            if currentSession?.accessLevel == "admin_support"{
                cancelButtonTrigger()
                self.present(self.authenticationError, animated: true)
                return
            }
            
            super.setEditing(editing, animated: animated)
            self.toggleEdit()
            self.tempStaff = staff
            navigationItem.title = NSLocalizedString("Editar Staff", comment: "Editar staff")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
            
        } else {
            if tempStaff != nil { // If not already erased, means it was not canceled
                self.updateModel()
                let valid = self.staff!.isValid()
                if valid == nil{
                    staffInfoController.updateStaff(staff: staff!, completion: {
                        DispatchQueue.main.async {
                            self.tempStaff = nil
                            self.present(self.alertSuccess, animated: animated)
                        }
                    })
                    super.setEditing(editing, animated: animated)
                    self.toggleEdit()
                }
                else{
                    self.validationError.message = valid
                    self.present(self.validationError, animated: animated)
                }
            }
            navigationItem.title = NSLocalizedString("Detalle Staff", comment: "Detalle Staff")
            navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func cancelButtonTrigger() -> Void{
        // If canceled revert changes and delete temp
        self.staff = tempStaff
        self.tempStaff = nil
        setEditing(false, animated: true)
    }
    
    func updateModel(){
        staff?.firstname = nameField.text
        staff?.firstLastname = firstLastNameField.text
        staff?.secondLastname = secondLastNameField.text
        staff?.cellphone = cellphoneField.text
        staff?.neighborhood = neighborhoodField.text
        staff?.street = streetField.text
        staff?.zipCode = zipCodeField.text
        staff?.addressNumber = Int(numberField.text!)
        staff?.specialty = specialtyField.text
    }
    
    func fillData(){
        nameField.text = staff?.firstname
        firstLastNameField.text = staff?.firstLastname
        secondLastNameField.text = staff?.secondLastname
        cellphoneField.text = staff?.cellphone
        neighborhoodField.text = staff?.neighborhood
        streetField.text = staff?.street
        zipCodeField.text = staff?.zipCode
        let number: Int = staff!.addressNumber!
        numberField.text = String(number)
        specialtyField.text = staff?.specialty
    }
    
    func toggleEdit() -> Void {
        nameField.isUserInteractionEnabled = !nameField.isUserInteractionEnabled
        firstLastNameField.isUserInteractionEnabled = !firstLastNameField.isUserInteractionEnabled
        secondLastNameField.isUserInteractionEnabled = !secondLastNameField.isUserInteractionEnabled
        cellphoneField.isUserInteractionEnabled = !cellphoneField.isUserInteractionEnabled
        neighborhoodField.isUserInteractionEnabled = !neighborhoodField.isUserInteractionEnabled
        streetField.isUserInteractionEnabled = !streetField.isUserInteractionEnabled
        zipCodeField.isUserInteractionEnabled = !zipCodeField.isUserInteractionEnabled
        numberField.isUserInteractionEnabled = !numberField.isUserInteractionEnabled
        specialtyField.isUserInteractionEnabled = !specialtyField.isUserInteractionEnabled
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
