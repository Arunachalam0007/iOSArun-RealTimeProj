//
//  ProfileViewModel.swift
//  Colan_Kart
//
//  Created by ArunSha on 25/05/21.
//

import Foundation

protocol ProfileDelegate {
    func didProfileLoad()
}

class ProfileViewModel {
    
    var profileModel: ProfileModel?
    var profileInfoDelegate: ProfileDelegate?
    
    var firstname:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.firstname
        }
    }
    
    var lastname:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.lastname
        }
    }
    
    var email:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.email
        }
    }
    
    var contact:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.contact
        }
    }
    
    var dob:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.date_of_birth
        }
    }
    
    var profileImage:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.profile
        }
    }
    
    var address:String {
        
        get {
            guard let profileModel = profileModel else { return "" }
            return profileModel.data.address
        }
    }
    
    func loadProfileInfo() {
        
        guard let profileURL = NSURL(string: Constants.Profile.url) as URL? else { return  }
        
        // Set Generic ProfileResource (ProfileModel)
        let profileResource = ProfileResource<ProfileModel>(url: profileURL, authBearer: Constants.Profile.authBearer, reqMethod: "GET") { byteData in // closure
            try? JSONDecoder().decode(ProfileModel.self, from: byteData)
        }
        
        // Call ProfileWebService to fetchProfileData with passing ProfileResouce Generic Input
        ProfileWebService.fetchProfileData(profileResource: profileResource) {
            profileData in // escaping closure
            guard let profileData = profileData else { return }
            self.profileModel = profileData
            self.profileInfoDelegate?.didProfileLoad()
        }
    }
}
