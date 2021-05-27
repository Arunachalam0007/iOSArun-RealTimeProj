//
//  MainTabController.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabControllers()
    }
    
    // MARK: - Helpers

    func configureTabControllers() {

        
        let profileSB = UIStoryboard(name: "Profile", bundle: nil)
        let profileVC = profileSB.instantiateViewController(identifier: "ProfileVC") as! ProfileViewController
        profileVC.tabBarItem.image = UIImage(systemName: "rectangle.stack.person.crop")
        profileVC.tabBarItem.selectedImage = UIImage(systemName: "rectangle.stack.person.crop.fill")
        
        let kartSB = UIStoryboard(name: "KartStoryboard", bundle: nil)
        let karVC = kartSB.instantiateViewController(identifier: "KartVC") as! KartTableViewController
        let navKarVC = UINavigationController(rootViewController: karVC)
        navKarVC.tabBarItem.image = UIImage(systemName: "cart")
        navKarVC.tabBarItem.selectedImage = UIImage(systemName: "cart.fill")
        
        // Adding Controllers
        viewControllers = [navKarVC,
                           profileVC]
        tabBar.tintColor = .red
    }
    
}
