//
//  ProfileWebService.swift
//  Colan_Kart
//
//  Created by ArunSha on 25/05/21.
//

import Foundation

struct ProfileResource<T>{
    let url: URL
    let authBearer: String
    let reqMethod: String
    let parse: (Data) -> T?
}

class ProfileWebService {
    
    static func fetchProfileData<T>(profileResource: ProfileResource<T>, completion: @escaping (T?) ->()) {
        
     //   let request = NSMutableURLRequest(url: NSURL(string: Constants.Profile.url)! as URL)
        let request = NSMutableURLRequest(url: profileResource.url)
        request.setValue(profileResource.authBearer, forHTTPHeaderField: "Authorization")
        request.httpMethod = profileResource.reqMethod
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }
            completion( profileResource.parse(data))
        }.resume()

    }
    
}
