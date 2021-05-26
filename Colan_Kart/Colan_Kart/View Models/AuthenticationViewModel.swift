//
//  AuthenticationViewModel.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

protocol FormViewModel {
    func updateFormBtn()
}

protocol FormAutheticationViewModel {
    var btnIsValid:Bool { get }
    var btnBackgroundColor:UIColor { get }
}

struct FeedAuthenticationViewModel {
    
    func getUserLogout(completion: @escaping (String?)->()){
//        authServie.userLogOut { result in
//            completion(result)
//        }
    }
    func getCurrentUser(completion: @escaping (String?)->()) {
//        authServie.getCurrentUser { result in
//            completion(result)
//        }
    }
}

struct LoginViewModel: FormAutheticationViewModel {
    var email:String?
    var password:String?
    var btnIsValid:Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    var btnBackgroundColor:UIColor {
        return btnIsValid ? .systemPurple.withAlphaComponent(1) : .systemPurple.withAlphaComponent(0.2)
    }
    
    func userLogin(completion: @escaping (String?)->()){
        guard let email = email, let password = password else {
            print("DEBUG: Email and Password Should Not Be Empty")
            return
        }
//        AuthService().userLogIn(email: email, password: password) { authDataResult in
//            guard let authDataResult = authDataResult else {
//                completion(nil)
//                return
//            }
//            completion(authDataResult.user.email)
//        }
    }
}

struct RegistrationViewModel: FormAutheticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var profileImage: UIImage?
    
    var btnIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var btnBackgroundColor: UIColor {
        return btnIsValid ? .systemPurple.withAlphaComponent(1) : .systemPurple.withAlphaComponent(0.2)
    }
    
    func registerUserDetails(completion:@escaping (String?)->()) {
        guard let email = email,let password = password,let fullname = fullname,let username = username,let profileImageData = profileImage?.jpegData(compressionQuality: 0.7) else {
            print("DEBUG: please fill all your information")
            return
        }
        
//        let authCredentials = AuthenticationCredentials(email: email, password: password, username: username, fullname: fullname, imageData: profileImageData)
//        AuthService().registerUser(authCredentials: authCredentials) { response in
//            completion(response)
//        }
    }
}
