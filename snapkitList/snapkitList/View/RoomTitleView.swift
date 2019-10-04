//
//  RoomTitleView.swift
//  snapkitList
//
//  Created by Tori on 04/10/2019.
//  Copyright © 2019 Tori. All rights reserved.
//

import UIKit
import SnapKit
import Then

/**
 객실 타이틀
 */

class RoomTitleView: UIView {
    var title = UILabel()
    var address = UILabel()
    var rate = UILabel()
    
    var titleText = "roomTitle"
    var addressText = "roomTitle"
    var rateText = "rate"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(address)
        self.addSubview(rate)
        title.text = titleText
        

        title.backgroundColor = .green
        address.backgroundColor = .red
        rate.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(){
           
        title.snp.makeConstraints{(make) in
                   make.top.equalToSuperview()
                   make.left.equalToSuperview()
                   make.height.equalTo(30)
           }
           
        address.snp.makeConstraints{(make) in
            make.top.equalTo(title.snp.bottom)
               make.left.equalToSuperview()
               make.height.equalTo(20)
           }
        
       rate.snp.makeConstraints{(make) in
                make.top.equalTo(title.snp.bottom)
                   make.left.equalTo(address)
                   make.height.equalTo(20) 
               }
       }
    
}
