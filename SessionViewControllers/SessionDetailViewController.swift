//
//  SessionDetailViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 16/10/21.
//

import UIKit

class SessionDetailViewController: UIViewController {
    
    let sessionController = SessionController()
    var session: SessionDetail?
    var sessionId: Int?
    
    @IBOutlet var numberField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var motiveField: UITextField!
    @IBOutlet var serviceField: UITextField!
    @IBOutlet var interventionField: UITextField!
    @IBOutlet var toolField: UITextField!
    @IBOutlet var evaluationField: UITextView!
    @IBOutlet var recoveryField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sessionController.fetchDetail(id: sessionId!, completion: { (result) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let sessionDetail):
                        self.session = sessionDetail
                        self.updateView()
                        print("Successful session detail request")
                    
                    case .failure(let error):
                        print(error)
                }
            }
        })
    }
    
    func updateView(){
        numberField.text = String(session!.sessionNumber!)
        dateField.text = session?.sessionDate
        motiveField.text = session?.motive
        serviceField.text = session?.serviceType
        interventionField.text = session?.interventionType
        toolField.text = session?.tool
        evaluationField.text = session?.evaluation
        recoveryField.text = String(session!.recoveryFee!)
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
