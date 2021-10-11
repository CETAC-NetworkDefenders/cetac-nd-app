//
//  LoginController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 05/10/21.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    let authTool = AuthenticationController()
    var staff: CurrentStaff?
    
    let alertData = UIAlertController(title: "Datos incompletos", message: "Se necesita el usuario y la contraseña para iniciar sesión.", preferredStyle: .alert)
    
    let authenticationFailed = UIAlertController(title: "Datos incorrectos", message: "Las credenciales de acceso son incorrectas. Verificar los datos. Si desea registrarse en el sistema, contacte a algún administrador CETAC.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertData.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        authenticationFailed.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func userField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func passwordField(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func login(_ sender: UIButton) {
        let email = usernameField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        print(email)
        print(password)
        
        if (email == "" || password == ""){
            self.present(alertData, animated: true)
        }
        else{
            
            currentSession = authTool.authenticate(email: email, password: password)
            let currentAccessLevel = currentSession?.accessLevel
            
            if currentAccessLevel == nil{
                self.present(authenticationFailed, animated: true)
            }
            else{
                self.passwordField.text = nil
                self.usernameField.text = nil
                let segue_identifier = currentAccessLevel == "admin_support" ? "show_admin" : "show_\(currentAccessLevel!)"
                performSegue(withIdentifier: segue_identifier, sender:self)
            }
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
