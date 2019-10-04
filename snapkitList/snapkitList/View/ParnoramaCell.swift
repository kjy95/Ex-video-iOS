//
//  ParnoramaCell.swift
//  snapkitList
//
//  Created by Tori on 04/10/2019.
//  Copyright © 2019 Tori. All rights reserved.
//

import UIKit

class ParnoramaCell: UITableViewCell {
    
    var roomTitle = ""
    var rateText = ""
    var addressText = ""
    var thumbnailImg = UIImageView()
    var roomTitleViews = RoomTitleView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    //set cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { 
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        thumbnailImg.roundCorners(corners: [.bottomRight], radius: 10)
        roomTitleViews.titleText = roomTitle
         setUI()
        layoutIfNeeded()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        //photo
        thumbnailImg =  UIImageView().then{
            self.addSubview($0)
            $0.snp.makeConstraints{(make) in
                make.top.right.left.equalTo(0)
                make.height.equalTo(240)
            }
//            $0.roundCorners(corners: [.bottomRight], radius: 0)
            $0.backgroundColor = .black
        }
        roomTitleViews = RoomTitleView().then{
            $0.titleText = roomTitle
            $0.rateText = rateText
            $0.addressText = addressText
            $0.setView()
            self.addSubview($0)
            $0.snp.makeConstraints { (make) in
                make.top.equalTo(thumbnailImg.snp.bottom)
                make.left.right.equalToSuperview()
            }
        }
    }
}
