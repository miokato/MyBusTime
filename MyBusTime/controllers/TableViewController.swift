//
//  ViewController.swift
//  MyBusTime
//
//  Created by mio kato on 2018/02/03.
//  Copyright © 2018 mio kato. All rights reserved.
//

import UIKit
import RealmSwift
import CSV

class ViewController: UITableViewController {
    
    let realm = try! Realm()
    var busInfoList: Results<BusInfo>?
    var isGoHome: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90
        self.tableView.register(UINib(nibName: "BusInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "busInfoCell")
        
        // 時刻表登録処理
        //registerBusInfo(realm: realm)
        
        loadBusInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func refreshBtnPressed(_ sender: UIBarButtonItem) {
        loadBusInfo()
    }
    
    @IBAction func changeBtnPressed(_ sender: UIBarButtonItem) {
        isGoHome = !isGoHome
        loadBusInfo()
    }
    
    func loadBusInfo() {
        // 現在時刻を取得
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        let date = Date()
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let total = hour * 60 + minute
        
        // 現在時刻から2時間後までの出発バスを取得
        if isGoHome {
            busInfoList = realm.objects(BusInfo.self).filter("t > %@ && t < %@ && direction == %@", total, total + 120, "kamakura")
        } else {
            busInfoList = realm.objects(BusInfo.self).filter("t > %@ && t < %@ && direction == %@", total, total + 120, "home")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "busInfoCell", for: indexPath) as! BusInfoTableViewCell
        if let businfo = busInfoList?[indexPath.row] {
            let time_string = "\(businfo.hour) : \(businfo.minute)"
            
            cell.timeLabel?.text = time_string
            cell.totalTime?.text = String(businfo.t)
            
            if businfo.direction == "kamakura" {
                cell.directionLabel.text = "鎌倉行き"
            } else if businfo.direction == "home" {
                cell.directionLabel.text = "自宅行き"
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busInfoList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

