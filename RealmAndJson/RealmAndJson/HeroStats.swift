//
//  HeroStats.swift
//  RealmAndJson
//
//  Created by Jh's Macbook Pro on 2020/09/09.
//  Copyright © 2020 전지훈. All rights reserved.
//

import Foundation

struct HeroStats: Codable {
    let id : Int?
    let localized_name : String?
    let attack_type : String?
    let base_health : Int?
}
