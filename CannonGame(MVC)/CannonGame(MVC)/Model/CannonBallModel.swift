//
//  GameModel.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 포탄 데이터
 */
class CannonBallModel {
    
    //포탄 현재 센터 위치
    var position : CGPoint
    
    var key : Int
    var type : String
    
    //포탄 벡터
    var vector = CGVector()
    
    var radian : CGFloat 
    
    //초기화
    init(currentLoc: CGPoint, vector: CGVector, key: Int, radian: CGFloat) {
        self.vector = vector 
        self.key = key
        self.position = currentLoc
        self.radian = radian
        
        //default
        self.type = "Rect"
    }
    
    func moveCannonBall(){
        position.x += vector.dx
        position.y += vector.dy
    } 
}
