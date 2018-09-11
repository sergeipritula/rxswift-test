//
//  BaseRequest.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/29/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire

struct Server {
    static let tanksUrl = "http://api.worldoftanks.ru/wot/encyclopedia/vehicles/"
    static let vehicleCharacteristicUrl = "http://api.worldoftanks.ru/wot/encyclopedia/vehicleprofile/"
    
    static let apiKey = "9603499c70d12a16d958b906c159efb8"
}

protocol BaseRequestProtocol {
    func apiPath() -> String
    func method() -> HTTPMethod
}

class BaseRequest: BaseRequestProtocol {
    
    func apiPath() -> String {
        return ""
    }
    
    func method() -> HTTPMethod {
        return .get
    }
    
}
