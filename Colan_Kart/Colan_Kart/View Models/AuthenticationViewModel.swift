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
        print("DEBUG: ",userInfo.count)
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
        return email?.isEmpty == false && mobile?.isEmpty == false
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
        return email?.isEmpty == false && mobile?.isEmpty == false && username?.isEmpty == false
    }
    
    var btnBackgroundColor: UIColor {
        return btnIsValid ? .systemPurple.withAlphaComponent(1) : .systemPurple.withAlphaComponent(0.2)
    }
    
}
