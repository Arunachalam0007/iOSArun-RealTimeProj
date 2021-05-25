//
//  ProfileModel.swift
//  Colan_Kart
//
//  Created by ArunSha on 25/05/21.
//

import Foundation

struct ProfileModel: Decodable {
    var data: ProfileData
}

struct ProfileData: Decodable {
    var firstname: String
    var lastname: String
    var email: String
    var contact: String
    var date_of_birth: String
    var profile: String
    var address: String
}
