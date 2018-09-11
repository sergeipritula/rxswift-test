//
//  TanksRequest.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/26/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire

enum TankListFunctionDataResult {
    case result(EquipmentList)
    case error(Error)
}

typealias TanksCompletionType = (TankListFunctionDataResult) -> ()


class TanksRequest {
    private var filter: TanksFilterBundle?
    
    private let decoder: JSONDecoder
    
    init(filter: TanksFilterBundle?) {
        self.decoder = JSONDecoder()
        self.filter = filter
    }
    
    func apiPath(pageNumber: Int) -> String {
        var apiPath = "?application_id=\(Server.apiKey)&page_no=\(pageNumber)"
        
        if let filter = self.filter {
            if filter.nations.count > 0 {
                apiPath = apiPath + "&nation="
                filter.nations.forEach{apiPath = apiPath + $0 + "," }
                apiPath.removeLast()
            }
            
            if filter.tankTypes.count > 0 {
                apiPath = apiPath + "&type="
                filter.tankTypes.forEach{apiPath = apiPath + $0 + "," }
                apiPath.removeLast()
            }
            
            if filter.tierTypes.count > 0 {
                apiPath = apiPath + "&tier="
                filter.tierTypes.forEach{apiPath = apiPath + String($0) + "," }
                apiPath.removeLast()
            }
        }
        
        return apiPath
    }
    
    func execute(pageNumber: Int, completion: @escaping TanksCompletionType) -> DataRequest? {
        if let url = URL(string: Server.tanksUrl + apiPath(pageNumber: pageNumber)) {
            return Alamofire.request(URLRequest(url: url)).responseJSON { [weak self] responce in
                guard let `self` = self else { return }
                
                switch responce.result {
                case .success( _):
                    guard let data = responce.data else { return }
                    
                    if let parsedData = try? self.decoder.decode(EquipmentList.self, from: data) {
                        completion(.result(parsedData))
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

