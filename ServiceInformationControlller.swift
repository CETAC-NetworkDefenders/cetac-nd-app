//
//  ServiceInformationControlller.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 04/10/21.
//

import UIKit

class ServiceInformationControlller: UIViewController {
    
    var service: Service?
    
    
    @IBOutlet var serviceDescription: UILabel!
    
    @IBOutlet var serviceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.serviceDescription.text = self.service!.description
        self.title = self.service?.serviceName
        self.serviceImage.image = UIImage(named: self.service!.image)
    }
}
