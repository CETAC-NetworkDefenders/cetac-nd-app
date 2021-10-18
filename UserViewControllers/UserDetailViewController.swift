//
//  UserDetailViewController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 10/10/21.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var segmentControl: UISegmentedControl!
    var selectedUser: UserSummary?
    
    
    private lazy var userInformationController: UserInformationViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "userInformationView") as! UserInformationViewController
        
        self.add(asChildViewController: viewController)


        return viewController
    }()

    private lazy var sessionListingController: SessionListingTableViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: "sessionTableViewController") as! SessionListingTableViewController
        
        self.add(asChildViewController: viewController)


        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "Información del Usuario", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Sesiones", at: 1, animated: false)
        segmentControl.addTarget(self, action: #selector(toggleView), for: .valueChanged)
        
        print("Before updating subview info")
        self.updateSubViews()
        print("After updating subview info")

        self.add(asChildViewController: userInformationController)
        self.remove(asChildViewController: sessionListingController)
        segmentControl.selectedSegmentIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.sessionListingController.updateData()
    }

    func updateSubViews(){
        self.userInformationController.selectedUserId = self.selectedUser!.id
        self.sessionListingController.selectedUserId = self.selectedUser!.id
    }
    
    @objc func toggleView() -> Void{
        if segmentControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionListingController)
            add(asChildViewController: userInformationController)
        } else {
            remove(asChildViewController: userInformationController)
            add(asChildViewController: sessionListingController)
        }
    }
    
    func add(asChildViewController viewController: UIViewController){
        addChild(viewController)
        view.addSubview(viewController.view)
        
        viewController.view.frame = containerView.frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CreateSessionViewController {
            let vc = segue.destination as? CreateSessionViewController
            vc?.recordId = self.selectedUser?.recordId
        }
    }
}
