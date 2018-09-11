//
//  Provider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/26/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire
import Moya

enum TanksAPI {
    case tanks(pageNumber: Int, filter: TanksFilterBundle?)
    case tank(id: String)
}

extension TanksAPI: TargetType {
    var baseURL: URL { return URL(string: "http://api.worldoftanks.ru/wot/encyclopedia")! }
    //base request    --->>>    https://api.worldoftanks.ru/wot/encyclopedia/vehicles/?application_id=demo
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .tanks:
            return "/vehicles/"
        case .tank:
            return "/vehicles/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tanks:
            return .get
        case .tank:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .tanks(let number, let filter):
            var parameters = [String: Any]()
            parameters["application_id"] = Server.apiKey
            parameters["page_no"] = String(number)
            
            if let filter = filter {
                if filter.tankTypes.count > 0 {
                    parameters["type"] = filter.tankTypes.joined(separator: ",")
                }
                
                if filter.tierTypes.count > 0 {
                    parameters["tier"] = filter.tierTypes.map { String($0) }.joined(separator: ",")
                }
                
                if filter.nations.count > 0 {
                    parameters["nation"] = filter.nations.joined(separator: ",")
                }
            }
            
            return parameters
        case .tank(let id):
            var parameters = [String: Any]()
            parameters["application_id"] = Server.apiKey
            parameters["tank_id"] = id
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

