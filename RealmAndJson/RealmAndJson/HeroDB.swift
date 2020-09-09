//
//  HeroDB.swift
//  RealmAndJson
//
//  Created by Jh's Macbook Pro on 2020/09/09.
//  Copyright © 2020 전지훈. All rights reserved.
//

import Foundation
import RealmSwift

class HeroDB: Object{
    
    @objc dynamic var id = 0
    @objc dynamic var localized_name = ""
    @objc dynamic var attack_type = ""
    @objc dynamic var base_health = 0
    
}
