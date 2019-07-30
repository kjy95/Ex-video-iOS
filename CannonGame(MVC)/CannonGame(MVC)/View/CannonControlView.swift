//
//  ButtonPicker.swift
//  CannonGame
//
//  Created by Vimosoft on 26/07/2019.
//  Copyright © 2019 kjy95. All rights reserved.
//

import UIKit

/**
 각 버튼 선택 했을 때 함수 (프로토콜)
 */
protocol CannonControlViewDelegate : class {
    func changeType(type: String)
    func changeDegreeCannon(sliderValue: Float)
    func fireCannonBall()
}

/**
 대포 조작 창
 */
class CannonControlView: UIView {
    weak var delegate: CannonControlViewDelegate?
    
    //각 버튼을 눌렀을 때 
    @IBAction func tapCircle(_ sender: UIButton) {
        delegate?.changeType(type: "circle")
    }
    @IBAction func tapTriangle(_ sender: UIButton) {
        delegate?.changeType(type: "triangle")
    }
    @IBAction func tapRect(_ sender: UIButton) {
        delegate?.changeType(type: "rectangle")
    }
    
    //슬라이더 움직였을 때
    @IBAction func changeDegreeCannon(_ sender: UISlider) {
        delegate?.changeDegreeCannon(sliderValue: sender.value)
    }
    
    @IBAction func tapFire(_ sender: Any) {
        delegate?.fireCannonBall()
    }
}
