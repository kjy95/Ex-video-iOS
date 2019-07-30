//
//  CannonBall.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

/**
 일반 포탄
 */
class CannonBallView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cannonBallInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cannonBallInit()
    }
    
    func cannonBallInit(){
        self.backgroundColor = UIColor.red
    }
    
    //circleview 로 변환
    func circleView(){
        self.layer.cornerRadius = self.frame.size.width/2
    }
}
