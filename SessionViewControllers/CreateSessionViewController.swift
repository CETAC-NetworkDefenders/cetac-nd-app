//
//  CreateSessionViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 16/10/21.
//

import UIKit

class CreateSessionViewController: UIViewController {
    
    
    @IBOutlet var dateField: UITextField!
    @IBOutlet var motivePicker: UIPickerView!
    @IBOutlet var servicePicker: UIPickerView!
    @IBOutlet var interventionPicker: UIPickerView!
    @IBOutlet var toolPicker: UIPickerView!
    @IBOutlet var evaluationField: UITextView!
    @IBOutlet var donationField: UITextField!
    @IBOutlet var isClosing: UISwitch!
    
    var session: SessionDetail = SessionDetail()
    let sessionController = SessionController()
    var recordId: Int? 
    
    let alertSuccess = UIAlertController(title: "Sesión agregada", message: "La nueva sesión se ha agregado a la base de datos.", preferredStyle: .alert)
    
    let validationError = UIAlertController(title: "Datos no válidos", message:"", preferredStyle: .alert)
    
    let motives = ["", "Abuso", "Adicción", "Ansiedad", "Baja autoestima", "Codependencia", "Comunicación Familiar", "Conflicto con hermano", "Conflicto con madre", "Conflicto con padre", "Dependencia", "Divorcio", "Duelo", "Duelo Grupal", "Enfermeda", "Enfermedad crónico degenerativa", "Heridas de la infancia", "Identidad de género", "Infertilidad", "Infidelidad", "Intento de suicidio", "Miedo", "Pérdida de bienes materiales", "Pérdida de identidad", "Pérdida laboral", "Relación con los padres", "Ruptura de noviazgo", "Stress", "Trastorno Obsesivo", "Violación", "Violencia intrafamiliar", "Violencia psicológica", "Viudez", "Otro"]
    
    let services = ["", "Servicios Acompañamiento", "Servicios Holísticos", "Herramientas Alternativas"]
    
    let interventions_acompanamiento = ["", "Tanatología", "Acompañamiento Individual", "Acompañamiento Grupal", "Logoterapia", "Mindfulness"]
    
    let interventions_holistico = ["", "Aromaterapia y Musicoterapia", "Cristaloterapia", "Reiki", "Biomagetismo", "Angeloterapia", "Cama térmica de Jade"]
 
    let interventions_alternativas = ["", "Flores de Bach", "Brisas Ambientales"]
    
    let interventions_base = [""]
    
    var interventions_current = [""]
    
    let tools = ["", "Contención", "Diálogo", "Ejercicio", "Encuadre", "Infografía", "Dinámica", "Lectura", "Meditación", "Video", "Otro"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(postSession))
        
        self.navigationItem.rightBarButtonItem = doneBarButton
        
        self.setEditing(true, animated: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.interventionPicker.delegate = self
        self.motivePicker.delegate = self
        self.servicePicker.delegate = self
        self.toolPicker.delegate = self
        
        alertSuccess.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        validationError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

    }
    
    @objc func postSession(){
        self.setEditing(false, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if !editing {
            self.updateModel()
            let valid = session.isValid()
            if valid != nil{
                self.validationError.message = valid
                self.present(validationError, animated: true)
            } else{
                navigationItem.rightBarButtonItem = nil
                sessionController.createSession(session: session, completion: {
                    DispatchQueue.main.async {
                        self.present(self.alertSuccess, animated: true)
                        self.disableEdit()
                        super.setEditing(editing, animated: animated)
                    }
                })
            }
        }
    }
    
    func updateModel(){
        session.sessionDate = dateField.text
        session.recoveryFee = Double(donationField.text!)
        session.evaluation = evaluationField.text
        session.isOpen = !isClosing.isOn
        session.recordId = recordId
    }
    
    func disableEdit(){
        dateField.isUserInteractionEnabled = false
        motivePicker.isUserInteractionEnabled = false
        servicePicker.isUserInteractionEnabled = false
        interventionPicker.isUserInteractionEnabled = false
        toolPicker.isUserInteractionEnabled = false
        evaluationField.isUserInteractionEnabled = false
        donationField.isUserInteractionEnabled = false
        isClosing.isUserInteractionEnabled = false
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension CreateSessionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MOTIVO - 0
    // SERVICIO - 1
    // INTERVENCIÓN - 2
    // HERRAMIENTA - 3
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return motives.count
        } else if pickerView.tag == 1 {
            return services.count
        } else if pickerView.tag == 2 {
            return interventions_current.count
        }
        else if pickerView.tag == 3 {
            return tools.count
        }
        else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return motives[row]
        } else if pickerView.tag == 1 {
            return services[row]
        } else if pickerView.tag == 2 {
            return interventions_current[row]
        }
        else if pickerView.tag == 3 {
            return tools[row]
        }
        else{
            return ""
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            self.session.motive = motives[row]
        } else if pickerView.tag == 1 {
            let selected_service = services[row]
            self.session.serviceType = selected_service
            if selected_service == "Servicios Acompañamiento" {
                self.interventions_current = self.interventions_acompanamiento
            } else if selected_service == "Servicios Holísticos" {
                self.interventions_current = self.interventions_holistico
            } else if selected_service == "Herramientas Alternativas" {
                self.interventions_current = self.interventions_alternativas
            }
            else {
                self.interventions_current = self.interventions_base
            }
            self.interventionPicker.reloadAllComponents()
        } else if pickerView.tag == 2 {
            self.session.interventionType =  interventions_current[row]
        } else if pickerView.tag == 3 {
            self.session.tool = tools[row]
        }
    }
}
