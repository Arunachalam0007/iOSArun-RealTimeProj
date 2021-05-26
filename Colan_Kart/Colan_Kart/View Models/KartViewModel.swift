//
//  KartViewModel.swift
//  Colan_Kart
//
//  Created by ArunSha on 26/05/21.
//

import Foundation

class KartViewModel {
    
    var kartModel:KartModel?
    
    var filterdKartData = [KartData] ()
    
    func loadKartData(){
        guard let kartInfoFileLocation = Bundle.main.url(forResource: "KartData", withExtension: ".json") else { return  }
        do {
           let data  = try Data(contentsOf: kartInfoFileLocation)
            kartModel = try JSONDecoder().decode(KartModel.self, from: data)
        } catch  {
            print("DEBUG: ",error.localizedDescription)
        }
    }
    
}
