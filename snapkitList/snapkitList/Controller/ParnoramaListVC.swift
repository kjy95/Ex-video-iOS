//
//  ParnoramaListVC.swift
//  snapkitList
//
//  Created by Tori on 04/10/2019.
//  Copyright © 2019 Tori. All rights reserved.
//

import UIKit

class ParnoramaListVC: UIViewController {
    
    var roomData = RoomData()
    let parnoramaTableView = ParnoramaTableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get room data and give the data to tableview
        roomData.getDataFromUrl{ (roomDatas) in
            self.roomData.roomDatas = roomDatas
            self.parnoramaTableView.setTableRegister()
            self.view.addSubview(self.parnoramaTableView)
            self.parnoramaTableView.snp.makeConstraints{(make) in
                make.edges.equalToSuperview()
            }
            self.parnoramaTableView.roomData = self.roomData 
        }
        // Do any additional setup after loading the view.
    }
     
    override func viewWillAppear(_ animated: Bool) { 
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
