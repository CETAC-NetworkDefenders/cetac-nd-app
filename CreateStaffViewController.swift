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

    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var firstLastnameField: UITextField!
    @IBOutlet var secondLastnameField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var cellphoneField: UITextField!
    @IBOutlet var neighborhoodField: UITextField!
    @IBOutlet var streetField: UITextField!
    @IBOutlet var zipCodeField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var accessLevelField: UITextField!
    @IBOutlet var specialtyField: UITextView!
    
    let alertSuccess = UIAlertController(title: "Datos incompletos", message: "Se necesita el usuario y la contraseña para iniciar sesión.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setEditing(true, animated: true)
        
        firstnameField.text = ""
        firstLastnameField.text = ""
        secondLastnameField.text = ""
        cellphoneField.text = ""
        neighborhoodField.text = ""
        streetField.text = ""
        zipCodeField.text = ""
        numberField.text = ""
        specialtyField.text = ""
        
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        alertData.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

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
        updateModel()
        
        staffInfoController.createStaff(staff: staff, completion: {
            DispatchQueue.main.async {
                print("Successfully added staff")
            }
        })
        
        setEditing(false, animated: true)
    }
    
    func updateModel(){
        staff.firstname = firstnameField.text
        staff.firstLastname = firstLastnameField.text
        staff.secondLastname = secondLastnameField.text
        staff.cellphone = cellphoneField.text
        staff.neighborhood = neighborhoodField.text
        staff.street = streetField.text
        staff.zipCode = zipCodeField.text
        staff.addressNumber = Int(numberField.text!)!
        staff.specialty = specialtyField.text
        staff.accessLevel = accessLevelField.text
        staff.username = usernameField.text
        staff.password = "db124066384060b7c132c51e3606338811a99912761eaf973dea64c4f1214c1a"
        staff.salt = "c3d4e5f6g7h8i9j0"
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
