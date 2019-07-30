//
//  Triangle.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit
/**
 삼각형 포탄
 */
class TriangleView : CannonBallView {
    
    //MARK: 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        //background color
        backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //background color
        backgroundColor = UIColor(white: 0, alpha: 0)
    }
    
    //삼각형 그리기
    override func draw(_ rect: CGRect) {
        
        //컨텍스트 얻기
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        //컨텍스트 시작
        context.beginPath()
        //왼쪽 하단으로 이동
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        //오른쪽 하단까지 선 추가
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        //꼭짓점 그리기
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        //context.bound
        //컨텍스트 종료
        context.closePath()
        
        //color 설정
        context.setFillColor(UIColor.red.cgColor)
        
        //그린 부분 채우기
        context.fillPath() 
    }
}
