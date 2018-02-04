//
//  model.swift
//  MyBusTime
//
//  Created by mio kato on 2018/02/03.
//  Copyright © 2018 mio kato. All rights reserved.
//

import Foundation
import RealmSwift


class BusInfo: Object {
    // is_kuhonji : true -> 九品寺循環, false -> それ以外
    // direction : kamakura -> 鎌倉駅行き, home -> 自宅行き
    @objc dynamic var hour: Int = 0
    @objc dynamic var minute: Int = 0
    @objc dynamic var t: Int = 0
    @objc dynamic var is_kuhonji: String = ""
    @objc dynamic var direction: String = ""
    @objc dynamic var type: String = ""
}
