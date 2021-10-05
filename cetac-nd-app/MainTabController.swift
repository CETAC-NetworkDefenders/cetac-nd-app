//
//  MainTabController.swift
//  cetac-nd-app
//
//  Created by Diego Urgell on 04/10/21.
//

import UIKit

var globalSelectedTab: Int? = 0
var services: [ServiceGroup]?


class MainTabController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        if services == nil {
            print("Drawing the jsjs")
            do {
                if let bundlePath = Bundle.main.path(forResource: "services", ofType: "json"),
                    let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    services = try JSONDecoder().decode([ServiceGroup].self,from: jsonData)
                }
            } catch {
                print(error)
            }
            for var i in 0..<tabBar.items!.count {
                tabBar.items![i].title = services![i].groupName
                tabBar.items![i].image = UIImage(named: services![i].iconImage)
                tabBar.items![i].selectedImage = UIImage(named: services![i].iconSelectedImage)
            }
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        globalSelectedTab = self.selectedIndex
    }
        
}
