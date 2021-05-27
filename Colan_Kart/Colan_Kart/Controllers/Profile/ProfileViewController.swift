//
//  ViewController.swift
//  Colan_Kart
//
//  Created by ArunSha on 25/05/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    private let profileVM:ProfileViewModel = ProfileViewModel()

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bgProfileImage: UIImageView!
    @IBOutlet weak var profileFirstName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var profFirstName: UILabel!
    @IBOutlet weak var profLastName: UILabel!
    @IBOutlet weak var profEmail: UILabel!
    @IBOutlet weak var profContact: UILabel!
    @IBOutlet weak var profDOB: UILabel!
    @IBOutlet weak var profAddress: UILabel!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        configureUI()
        
        profileVM.profileInfoDelegate = self
        profileVM.loadProfileInfo()
    }
    
    // MARK: - Helpers

    func configureUI() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.red.cgColor
    }
    
    // MARK: - Actions
    
    func updateProfileUIValue(){
        profileFirstName.text = profileVM.firstname
        profileEmail.text = profileVM.email
        profFirstName.text = profileVM.firstname
        profEmail.text = profileVM.firstname
        profLastName.text = profileVM.lastname
        profDOB.text = profileVM.dob
        profContact.text = profileVM.contact
        profAddress.text = profileVM.address
    }


}

// MARK: - ProfileDelegate

extension ProfileViewController: ProfileDelegate {
    func didProfileLoad() {
        DispatchQueue.main.async {
            self.updateProfileUIValue()
        }
    }
    
}
