//
//  String.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/9/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

public extension String {
    
    public var getRomanianNumber: String {
        var str = self
        
        if str == "10" {
            return "\u{2169}"
        }
        
        let map = ["1": "\u{2160}",
                   "2": "\u{2161}",
                   "3": "\u{2162}",
                   "4": "\u{2163}",
                   "5": "\u{2164}",
                   "6": "\u{2165}",
                   "7": "\u{2166}",
                   "8": "\u{2167}",
                   "9": "\u{2168}"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    public var TransformedCountryName: String {
        var str = self
        
        let map = ["ussr": "USSR",
                   "usa": "U. S. A.",
                   "sweden": "Sweden",
                   "uk": "United Kingdom",
                   "poland": "Poland",
                   "germany": "Germany",
                   "czech": "Checkhoslovakiya",
                   "china": "China",
                   "japan": "Japan",
                   "france": "France"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    public var TransformedTankType: String {
        var str = self
        
        let map = ["mediumTank": "Medium Tank",
                   "lightTank": "Light Tank",
                   "heavyTank": "Heavy Tank",
                   "SPG": "Artillery",
                   "AT-SPG": "Destroyer"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
}
