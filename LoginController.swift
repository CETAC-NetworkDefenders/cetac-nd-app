//
//  LoginController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 05/10/21.
//

import UIKit

class LoginController: UIViewController {
    
    var username: String?
    var password: String?
    
    let alertData = UIAlertController(title: "Datos incompletos", message: "Se necesita el usuario y la contraseña para iniciar sesión.", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        alertData.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    @IBAction func userField(_ sender: UITextField) {
        self.username = sender.text
        sender.resignFirstResponder()
    }
    
    @IBAction func passwordField(_ sender: UITextField) {
        self.password = sender.text
        sender.resignFirstResponder()
    }
    
    @IBAction func login(_ sender: UIButton) {
        if (username == nil || password == nil){
            self.present(alertData, animated: true)
        }
        else{
            // Here, we will execute the HTTP request for authentication
            access = username
            let segue_identifier = access == "admin_support" ? "show_admin" : "show_\(access!)"
            performSegue(withIdentifier: segue_identifier, sender:self)
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ResultadosViewController {
            let vc = segue.destination as? ResultadosViewController
            let imc_h: Double = (weight! / pow(height!, 2)) * 100.0
            vc?.imc = imc_h.rounded() / 100.0
            vc?.selectedSex = selectedSex!
        }
    }
    */
    

}
