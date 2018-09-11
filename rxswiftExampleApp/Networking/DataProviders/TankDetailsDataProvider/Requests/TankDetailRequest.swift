//
//  TankDetailsRequest.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/27/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire

enum TankDetailFunctionDataResult {
    case result(EquipmentType)
    case error(Error)
}

typealias TankDetailsCompletionType = (TankDetailFunctionDataResult) -> ()

class TankDetailRequest {
    private var id: Int
    private let decoder: JSONDecoder
    
    init(id: Int) {
        self.id = id
        self.decoder = JSONDecoder()
    }
    
    func apiPath() -> String {
        return "?application_id=\(Server.apiKey)&tank_id=\(id)"
    }
    
    func execute(completion: @escaping TankDetailsCompletionType) -> DataRequest? {
        if let url = URL(string: Server.tanksUrl + apiPath()) {
            return Alamofire.request(URLRequest(url: url)).responseJSON { [weak self] responce in
                guard let `self` = self else { return }
                
                switch responce.result {
                case .success( _):
                    guard let data = responce.data else { return }
                    
                    if let parsedData = try? self.decoder.decode(EquipmentList.self, from: data) {
                        let vehicle = parsedData.data.map({ $0.value })
                        
                        if vehicle.count > 0 {
                            completion(.result(vehicle[0]))
                        }
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
