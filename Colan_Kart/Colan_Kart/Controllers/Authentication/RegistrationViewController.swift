//
//  RegistrationViewController.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    
    var registrationVM = RegistrationViewModel()
    
    
    let mobileTextF: UITextField = {
        let mobTF = CustomTextField(placeHolderName: "Mobile Number")
        return mobTF
    }()
    
    let emailTextF: UITextField = {
        let emailTF = CustomTextField(placeHolderName: "Email")
        emailTF.keyboardType = .emailAddress
        return emailTF
    }()
    
    let userNameTextF: UITextField = {
        let uNameTF = CustomTextField(placeHolderName: "Username")
        return uNameTF
    }()
    

    
    let signUpBtn: UIButton = {
        let signBtn = UIButton(type: .system)
        signBtn.setTitle("Sign Up", for: .normal)
        signBtn.setTitleColor(.white, for: .normal)
        signBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        signBtn.isEnabled = false
        signBtn.backgroundColor = .systemPurple.withAlphaComponent(0.2)
        signBtn.layer.cornerRadius = 5
        signBtn.setHeight(50)
        signBtn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return signBtn
    }()
    
    let alreadyHaveAnAccount: UIButton = {
        let haveAccountBtn = UIButton(type: .system)
        haveAccountBtn.setCustomAtrributedTitle(firstPart: "Already have an account?  ", seccondPart: "Sign In")
        haveAccountBtn.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return haveAccountBtn
    }()
    
    // MARK: - Actions

   @objc func handleShowSignIn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleShowSignUp(){
        registrationVM.email = emailTextF.text
        registrationVM.fullname = mobileTextF.text
        registrationVM.username = userNameTextF.text
        
        // Perform Storing Value Into DB
        
        UserDefaults.standard.setIsloggedIn(true)
        let mainTabController = MainTabController()
        mainTabController.modalPresentationStyle = .fullScreen
        self.present(mainTabController, animated: true)

    }
    
    @objc func textFieldDidChanged(sender: UITextField) {
        if sender == emailTextF {
            registrationVM.email = sender.text
        }else if sender == userNameTextF {
            registrationVM.username = sender.text
        } else if sender == mobileTextF {
            registrationVM.fullname = sender.text
        }
        updateFormBtn()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
    }
    
    // MARK: - Helpers

    func configureUI() {
        
        configureGradientLayer()

        // add stackviw of textFields and btn
        
        let stackView = UIStackView(arrangedSubviews: [mobileTextF,
                                                       userNameTextF,
                                                       emailTextF,
                                                       signUpBtn,
                                                       alreadyHaveAnAccount])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 200).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func configureNotificationObservers(){
        emailTextF.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        mobileTextF.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        userNameTextF.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension RegistrationViewController: FormViewModel {
    func updateFormBtn() {
        signUpBtn.isEnabled = registrationVM.btnIsValid
        signUpBtn.backgroundColor = registrationVM.btnBackgroundColor
    }
}
