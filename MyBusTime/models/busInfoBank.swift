//
//  busInfoBank.swift
//  MyBusTime
//
//  Created by mio kato on 2018/02/03.
//  Copyright © 2018 mio kato. All rights reserved.
//

import Foundation
import RealmSwift
import CSV

func registerBusInfo(realm: Realm) {
    let fileManager = FileManager()
    
    let busInfoPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/businfo.realm"
    
    if fileManager.fileExists(atPath: busInfoPath) {
        try! fileManager.removeItem(atPath: busInfoPath)
    }
    try! realm.write {
        realm.deleteAll()
    }
    
    // ファイル読み込み
    let path = Bundle.main.path(forResource: "businfo", ofType: "csv")
    let stream = InputStream(fileAtPath: path!)
    let csv = try! CSVReader(stream: stream!)
    while let row = csv.next() {
        let businfo = BusInfo()
        businfo.hour = Int(row[0])!
        businfo.minute = Int(row[1])!
        businfo.t = businfo.hour * 60 + businfo.minute
        businfo.is_kuhonji = row[2]
        businfo.direction = row[3]

        try! realm.write {
            realm.add(businfo)
        }
    }
    
}



