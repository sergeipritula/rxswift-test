//
//  PlayersListDataProvider.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/22/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation
import Alamofire

enum PlayersFunctionDataResult {
    case result([PlayerType])
    case error(Error)
}


enum PlayerFunctionDataResult {
    case result(PlayerInfoType?)
    case error(Error)
}

class PlayersDataProvider {
    typealias PlayersListCompletionType = (PlayersFunctionDataResult) -> ()
    private let request = PlayersListRequest()
    
    func load(completion: @escaping PlayersListCompletionType) {
        request.start(completion: completion)
    }
}
