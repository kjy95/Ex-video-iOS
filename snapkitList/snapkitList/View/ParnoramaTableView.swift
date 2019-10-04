//
//  ParnoramaTableView.swift
//  snapkitList
//
//  Created by Tori on 04/10/2019.
//  Copyright © 2019 Tori. All rights reserved.
//

import UIKit
import Kingfisher

class ParnoramaTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifiler = "ParnoramaCell"
    var roomData = RoomData()
    // MARK: TableView Register
    func setTableRegister() {
        
        self.delegate = self
        self.dataSource = self
        
        self.register(ParnoramaCell.self, forCellReuseIdentifier: cellIdentifiler)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomData.roomDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParnoramaCell", for: indexPath) as! ParnoramaCell
        cell.roomTitle = roomData.roomDatas[indexPath.row].title ?? ""
        cell.addressText = roomData.roomDatas[indexPath.row].listAddress ?? ""
        cell.rateText = roomData.roomDatas[indexPath.row].rate ?? ""
        //thumbnail 
        let url = URL(string: roomData.roomDatas[indexPath.row].thumbnail ?? "")
        cell.thumbnailImg.kf.setImage(with: url)
        //cell.setUI()
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
