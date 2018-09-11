//
//  VehicleCharacteristicRequest.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/15/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire

enum VehicleFunctionDataResult {
    case result(DefaultProfile)
    case error(Error)
}

class VehicleCharacteristicRequest {
    typealias VehicleCompletionType = (VehicleFunctionDataResult) -> ()
    
    private let decoder = JSONDecoder()
    private var filter: TankMainInfoViewModelType!
    private var configuration: ModulesConfiguration?
    
    init(model: TankMainInfoViewModelType) {
        self.filter = model
        self.configuration = ModulesConfiguration(id: model.device.tankId, modules: model.equipment.defaultProfile.modules)
    }
    
    init(configuration: ModulesConfiguration?) {
        self.configuration = configuration
    }
    
    func apiPath() -> String {
        guard let configuration = self.configuration else {
            return ""
        }
        
         var apiPath = "?application_id=\(Server.apiKey)&tank_id=\(configuration.tankId)"
        
        apiPath += (configuration.modules.engineId != nil ? "&engine_id=\(configuration.modules.engineId!)" : "")
        apiPath += (configuration.modules.gunId != nil ? "&gun_id=\(configuration.modules.gunId!)" : "")
        apiPath += (configuration.modules.suspensionId != nil ? "&suspension_id=\(configuration.modules.suspensionId!)" : "")
        apiPath += (configuration.modules.turretId != nil ? "&turret_id=\(configuration.modules.turretId!)" : "")
        apiPath += (configuration.modules.radioId != nil ? "&radio_id=\(configuration.modules.radioId!)" : "")
        
        return apiPath
    }
    
    func apiPath(device: Device) -> String {
        switch device.type  {
        case .Engine:
            return "?application_id=\(Server.apiKey)&tank_id=\(device.tankId)&engine_id=\(device.deviceId)"
        case .Gun:
            return "?application_id=\(Server.apiKey)&tank_id=\(device.tankId)&gun_id=\(device.deviceId)"
        case .Radio:
            return "?application_id=\(Server.apiKey)&tank_id=\(device.tankId)&radio_id=\(device.deviceId)"
        case .Suspension:
            return "?application_id=\(Server.apiKey)&tank_id=\(device.tankId)&suspension_id=\(device.deviceId)"
        case .Turret:
            return "?application_id=\(Server.apiKey)&tank_id=\(device.tankId)&turret_id=\(device.deviceId)"
        }
    }
    
    func execute(completion: @escaping VehicleCompletionType) {
        if let url = URL(string: Server.vehicleCharacteristicUrl + apiPath())  {
            let request = URLRequest(url: url)
            
            Alamofire.request(request).responseJSON { [weak self] responce in
                guard let `self` = self else { return }
                
                switch responce.result {
                case .success( _):
                    guard let data = responce.data else { return }
                    if let tankDetails = try? self.decoder.decode(DefaultProfileData.self, from: data) {
                        let profile = tankDetails.data.map({$0.value})
                        completion(.result(profile[0]))
                    } else {
                        completion(.error(NSError(domain: "Could't load selected configuration", code: -1, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            }
        }
    }
    
    func execute(device: Device, completion: @escaping VehicleCompletionType) {
        if let url = URL(string: Server.vehicleCharacteristicUrl + apiPath(device: device))  {
            let request = URLRequest(url: url)
            
            Alamofire.request(request).responseJSON { [weak self] responce in
                guard let `self` = self else { return }
                
                switch responce.result {
                case .success( _):
                    guard let data = responce.data else { return }
                    if let tankDetails = try? self.decoder.decode(DefaultProfileData.self, from: data) {
                        let profile = tankDetails.data.map({$0.value})
                        completion(.result(profile[0]))
                    }
                case .failure(let error):
                    completion(.error(error))
                }
            }
        }
    }
    
    
}
