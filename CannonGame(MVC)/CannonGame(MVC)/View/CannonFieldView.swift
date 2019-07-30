//
//  CannonFieldView.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 30/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit
/**
 대포 필드
 */
class CannonFieldView: UIView {

    @IBOutlet weak var cannon: UIView!
    
    @IBOutlet weak var cannonBallGuideLine: UIView!
    @IBOutlet weak var triangleBall: TriangleView!
    @IBOutlet weak var commonBall: CannonBallView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func cannonFieldInit(){
        //---대포
        //대포각도 초기화 (90도)
        cannon.transform = cannon.transform.rotated(by: CGFloat.pi/2)
        
        //---포탄 가이드라인
        //초기화 (90도)
        cannonBallGuideLine.frame = CGRect(x: cannonBallGuideLine.frame.minX, y: cannonBallGuideLine.frame.minY, width: 1000 * 2, height: 1);
        cannonBallGuideLine.center = cannon.center
        cannonBallGuideLine.transform = cannonBallGuideLine.transform.rotated(by: CGFloat.pi/2)
        
        //triangle backgroundColor
        triangleBall.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    /*
     대포 회전할 때 관련 요소 모두 회전
     */
    func roateCannonStruct(radian: CGFloat){
        cannonBallGuideLine.transform = CGAffineTransform.identity.rotated(by: radian)
        cannon.transform = CGAffineTransform.identity.rotated(by: radian)
        triangleBall.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
        commonBall.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
    }
    
    /*
     사각형 또는 원, 삼각형 포탄 틀 보이기
     */
    func showChangeCannonBallType(type :String){
        switch type {
        case "triangle":
            commonBall.isHidden = true
            triangleBall.isHidden = false
            
        case "circle":
            triangleBall.isHidden = true
            commonBall.isHidden = false
            //원
            commonBall.layer.cornerRadius = commonBall.frame.size.width/2
            
        case "rectangle":
            triangleBall.isHidden = true
            commonBall.isHidden = false
            //사각형
            commonBall.layer.cornerRadius = 0.0
            
        default:
            print("default")
            
        }
    }
}
