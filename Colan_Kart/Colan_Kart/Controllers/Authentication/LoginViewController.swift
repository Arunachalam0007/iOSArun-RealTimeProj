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
    
    var emailTextField: UITextField = {
        var emailTextField = CustomTextField(placeHolderName: "Email")
        emailTextField.keyboardType = .emailAddress
        return emailTextField
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationUI()
        configurePropertyUI()
        configureNotificationObservers()
    }
    
    // MARK: - Actions
    
    @objc func textFieldDidChanged(sender: UITextField){
        if sender ==  emailTextField {
            loginVM.email = sender.text
        } else if sender == mobileTextField {
            loginVM.mobile = sender.text
        }
        loginBtn.isEnabled = loginVM.btnIsValid
        loginBtn.backgroundColor = loginVM.btnBackgroundColor
    }
    
    @objc func handleShowSignUp() {
        let registrationVC = RegistrationViewController()
        registrationVC.modalPresentationStyle = .fullScreen
        self.present(registrationVC, animated: true, completion: nil)
    }
    
    @objc func handleSignIn(){
        
        let canLogin =  loginVM.canLogin(mobile: loginVM.mobile!)
        
        if canLogin {
            UserDefaults.standard.setIsloggedIn(true)
            let mainTabController = MainTabController()
            mainTabController.modalPresentationStyle = .fullScreen
            self.present(mainTabController, animated: true, completion: nil)
        } else {
            let refreshAlert = UIAlertController(title: "Login Failed", message: "Mobile Number is Not Register or Enterd Wrong Number", preferredStyle: UIAlertController.Style.alert)

            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers

    func configurationUI(){
        navigationController?.navigationBar.isHidden = true
        // This will Make barStyle to while color instead of black
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        mobileTextField.delegate = self
        self.hideKeyboardWhenTappedAround()

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
                                                       emailTextField,
                                                       loginBtn,
                                                       dontHaveAccountBtn])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: colanLogoImage.bottomAnchor, constant: 30).isActive = true
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
       func configureNotificationObservers() {
        mobileTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
}

// MARK: -  Delegate

extension LoginViewController: UITextFieldDelegate {
    //MARK - UITextField Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == mobileTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
