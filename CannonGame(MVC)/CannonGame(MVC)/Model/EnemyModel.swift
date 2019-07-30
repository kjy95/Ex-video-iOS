//
//  GameModel.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 적 데이터
 */
class EnemyModel {
    
    //포탄 현재 센터 위치
    var currentLoc : CGPoint
    var willMoveLoc : CGPoint?
    
    //포탄 벡터
    var vector : CGVector?
    var radian : CGFloat

    
    //초기화
    init(currentLoc: CGPoint, vector: CGVector) {
        self.currentLoc = currentLoc
        self.vector = vector
        
        //default
        radian = 0
    }
     
}
