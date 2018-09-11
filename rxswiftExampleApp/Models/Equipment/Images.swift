//
//  Images.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 1/31/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

protocol ImagesType {
    var smallIcon: String? { get }
    var contourIcon: String? { get }
    var bigIcon: String? { get }
}

class Images: ImagesType, Decodable {
    var smallIcon: String?
    var contourIcon: String?
    var bigIcon: String?
    
    private enum CodingKeys: String, CodingKey {
        case smallIcon = "small_icon"
        case contourIcon = "contour_icon"
        case bigIcon = "big_icon"
    }
}
