//
//  AuthenticationViewModel.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import UIKit

class AuthenticationDB {
    let dbHandler = DataBaseHandler()
    
    func addUser(mobile:String, name:String, email:String)  {
        let obj = dbHandler.add(User.self)
        obj?.mobile = mobile
        obj?.name = name
        obj?.email = email
        dbHandler.save()
    }
    
    func isRegisterdUser(mobile: String) -> Bool {
        let registerUser = dbHandler.fetch(_type: User.self,mobileInput: mobile)
        return registerUser.count > 0 ? true : false
    }
    
    func canLogin(mobile: String)  -> Bool {
        let userInfo = dbHandler.fetch(_type: User.self,mobileInput: mobile)
        return userInfo.count > 0 ? true : false
    }
    func loadData(){
        let users = dbHandler.fetchAll(_type: User.self)
        print(users.map{$0.mobile})
    }
}

class LoginViewModel: AuthenticationDB {
    var email:String?
    var mobile:String?

    var btnIsValid:Bool {
        return isValidPhoneNumber(phone: mobile ?? "") && isValidEmail(email: email ?? "")
    }
    
    func isValidPhoneNumber(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }
    
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
    }

    
    var btnBackgroundColor:UIColor {
        return btnIsValid ? .systemPurple.withAlphaComponent(1) : .systemPurple.withAlphaComponent(0.2)
    }
    
}

class RegistrationViewModel: AuthenticationDB {
    var email: String?
    var mobile: String?
    var username: String?
    
    var btnIsValid: Bool {
        
        return  username?.isEmpty == false && isValidPhoneNumber(phone: mobile ?? "") && isValidEmail(email: email ?? "")
    }
    
    func isValidPhoneNumber(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
    }
    
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
    }
    
    var btnBackgroundColor: UIColor {
        return btnIsValid ? .systemPurple.withAlphaComponent(1) : .systemPurple.withAlphaComponent(0.2)
    }
    
}
