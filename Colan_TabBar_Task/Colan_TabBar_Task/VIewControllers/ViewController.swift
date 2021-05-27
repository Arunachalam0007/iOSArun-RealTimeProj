//
//  ViewController.swift
//  Colan_TabBar_Task
//
//  Created by ArunSha on 27/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func showTabBarController(controller: UIViewController){
        let tabBarController = UITabBarController()
        controller.tabBarItem.image = UIImage(systemName: "homekit")
        let controller2 = UIViewController()
        let controller3 = UIViewController()
        controller2.tabBarItem.image = UIImage(systemName: "person.circle.fill")
        controller3.tabBarItem.image = UIImage(systemName: "message.fill")
    
        tabBarController.viewControllers = [controller,controller2,controller3]
        navigationController?.pushViewController(tabBarController, animated: true)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        cell.titleLabel.text = "View Controller \(indexPath.row+1)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 7) / 2
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.row+1
        switch item {
        case 1:
            showTabBarController(controller: FirstViewController())
        case 2:
            showTabBarController(controller: SecondViewController())
        case 3:
            showTabBarController(controller: ThiredViewController())
        case 4:
            showTabBarController(controller: FourthViewController())
        case 5:
            showTabBarController(controller: FifthViewController())
        case 6:
            showTabBarController(controller: SixthViewController())
        case 7:
            showTabBarController(controller: SeventhViewController())
        default:
            ""
        }
        
    }
}


