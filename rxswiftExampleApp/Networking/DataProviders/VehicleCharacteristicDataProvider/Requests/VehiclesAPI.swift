//
//  VehiclesAPI.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/28/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import Moya

enum VehiclesAPI {
    case vehicle(configuration: ModulesConfiguration)
}

extension VehiclesAPI: TargetType {
    var baseURL: URL { return URL(string: "http://api.worldoftanks.ru/wot/encyclopedia")! }
    //base request    --->>>    https://api.worldoftanks.ru/wot/encyclopedia/vehicleprofile/?application_id=demo&tank_id=2401&radio_id=1639
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .vehicle:
            return "/vehicleprofile/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .vehicle:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .vehicle(let configuration):
            var parameters = [String: Any]()
            
            parameters["application_id"] = Server.apiKey
            parameters["tank_id"] = String(configuration.tankId)
            
            if let gunId = configuration.modules.gunId {
                parameters["gun_id"] = gunId
            }
            
            if let engineId = configuration.modules.engineId {
                parameters["engine_id"] = engineId
            }
            
            if let turretId = configuration.modules.turretId {
                parameters["turret_id"] = turretId
            }
            
            if let suspensionId = configuration.modules.suspensionId {
                parameters["suspension_id"] = suspensionId
            }
            
            if let radioId = configuration.modules.radioId {
                parameters["radio_id"] = radioId
            }
            
            return parameters
        }
    }
    
    var parametersEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parametersEncoding)
    }
    
}
