//
//  VehicleCharactersticRequest.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/28/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire

enum VehicleCharacteristicDataResult {
    case result(DefaultProfile)
    case error(Error)
}

typealias VehicleCharacteristicCompletionType = (VehicleCharacteristicDataResult) -> ()

class VehicleCharacteristicsRequest {
    
    var configuration: ModulesConfiguration?
    private let decoder = JSONDecoder()
    
    init() {
    }
    
    func apiPath() -> String {
        var apiPath = "?application_id=\(Server.apiKey)"
        
        if let configuration = configuration {
            apiPath += "&tank_id=\(configuration.tankId)"
            
            if let gunId = configuration.modules.gunId {
                apiPath += "&gun_id=\(gunId)"
            }
            
            if let engineId = configuration.modules.engineId {
                apiPath += "&engine_id=\(engineId)"
            }
            
            if let turretId = configuration.modules.turretId {
                apiPath += "&turret_id=\(turretId)"
            }
            
            if let suspensionId = configuration.modules.suspensionId {
                apiPath += "&suspension_id=\(suspensionId)"
            }
            
            if let radioId = configuration.modules.radioId {
                apiPath += "&radio_id=\(radioId)"
            }
        }
        
        return apiPath
    }
    
    func execute(completion: @escaping VehicleCharacteristicCompletionType) -> DataRequest? {
        if let url = URL(string: Server.vehicleCharacteristicUrl + apiPath()) {
            return Alamofire.request(URLRequest(url: url)).responseJSON { [weak self] responce in
                guard let `self` = self else { return }
                
                switch responce.result {
                case .success( _):
                    guard let data = responce.data else { return }
                    
                    if let parsedData = try? self.decoder.decode(DefaultProfileData.self, from: data) {
                        let profile = parsedData.data.map({$0.value})
                        completion(.result(profile[0]))
                    } else {
                        completion(.error(NSError(domain: "Error", code: -1, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            }
        } else {
            return nil
        }
    }
}
