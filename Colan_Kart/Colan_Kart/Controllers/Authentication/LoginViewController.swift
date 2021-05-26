//
//  LoginViewController.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    var loginVM = LoginViewModel()
    
    var colanLogoImage: UIImageView = {
        var colanImage = UIImageView()
        colanImage.image = UIImage(systemName: "cart.badge.plus")
        colanImage.tintColor = .systemGray6
        colanImage.contentMode = .scaleAspectFill
        return colanImage
    }()
    
    var mobileTextField: UITextField = {
        var mobileTextF = CustomTextField(placeHolderName: "Mobile Number")
        mobileTextF.keyboardType = .numberPad
        return mobileTextF
    }()
    
    var userNameTextF: UITextField = {
        var userNameTextF = CustomTextField(placeHolderName: "User Name")
        return userNameTextF
    }()
    
    var loginBtn: UIButton = {
        var lgnBtn = UIButton(type: .system)
        
        lgnBtn.setTitle("Log In", for: .normal)
        lgnBtn.setTitleColor(.white, for: .normal)
        lgnBtn.isEnabled = false
        lgnBtn.backgroundColor = .systemPurple.withAlphaComponent(0.2)
        lgnBtn.setHeight(50)
        lgnBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        lgnBtn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return lgnBtn
    }()
    
    var dontHaveAccountBtn: UIButton = {
        var dontHaveAccBtn = UIButton(type: .system)
        dontHaveAccBtn.setCustomAtrributedTitle(firstPart: "Dont' have an account?  ", seccondPart: "Sign Up")
        dontHaveAccBtn.addTarget(self, action: #selector(handleShowSignUp) , for: .touchUpInside)
        return dontHaveAccBtn
    }()
    
    var forgotPasswordBtn: UIButton = {
        var forgotPassBtn = UIButton(type: .system)
        
        forgotPassBtn.setCustomAtrributedTitle(firstPart: "Forgot your password?  ", seccondPart: "Get help signing in")
        
        return forgotPassBtn
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        configurePropertyUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChanged(sender: UITextField){
        if sender == mobileTextField {
            loginVM.email = sender.text
        } else if sender == userNameTextF {
            loginVM.password = sender.text
        }
        updateFormBtn()
    }
    
    @objc func handleShowSignUp() {
        let registrationVC = RegistrationViewController()
        registrationVC.modalPresentationStyle = .fullScreen
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    @objc func handleSignIn(){
        loginVM.email = mobileTextField.text
        loginVM.password = userNameTextF.text
        UserDefaults.standard.setIsloggedIn(true)
        let mainTabController = MainTabController()
        mainTabController.modalPresentationStyle = .fullScreen
        self.present(mainTabController, animated: true, completion: nil)
    }
    
    // MARK: - Helpers

    func configurationUI(){
        navigationController?.navigationBar.isHidden = true
        // This will Make barStyle to while color instead of black
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()

    }
    
    
    func configurePropertyUI() {
        
        // Add Colan logo
        view.addSubview(colanLogoImage)
        
        colanLogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        colanLogoImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        colanLogoImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        colanLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        colanLogoImage.translatesAutoresizingMaskIntoConstraints = false
        
        //Add mobileTextField, userNameTextField,LoginBtn,ForgotpassowrdBtn to View
        
        let stackView = UIStackView(arrangedSubviews: [mobileTextField,
                                                       userNameTextF,
                                                       loginBtn,
                                                       dontHaveAccountBtn])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: colanLogoImage.bottomAnchor, constant: 30).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
//        //Add DontHaveAccountBtn to View
//        view.addSubview(dontHaveAccountBtn)
//
//        dontHaveAccountBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
//
//        dontHaveAccountBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        dontHaveAccountBtn.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
       func configureNotificationObservers() {
        mobileTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        userNameTextF.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
}

// MARK: - FormViewModel

extension LoginViewController: FormViewModel {
    func updateFormBtn() {
        loginBtn.isEnabled = loginVM.btnIsValid
        loginBtn.backgroundColor = loginVM.btnBackgroundColor
    }
}
