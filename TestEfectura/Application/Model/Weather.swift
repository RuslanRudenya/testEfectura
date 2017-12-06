//
//  Weather.swift
//  TestEfectura
//
//  Created by Руслан on 06.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var location: LocationData
    var current: CurrentData
}

struct LocationData: Codable {
    var country : String?
    var region : String?
    var localtime : String?
}

struct CurrentData: Codable {
    var last_updated : String?
    var temp_c : Int
    var condition: ConditionData
}

struct ConditionData: Codable {
    var icon: String?
}
