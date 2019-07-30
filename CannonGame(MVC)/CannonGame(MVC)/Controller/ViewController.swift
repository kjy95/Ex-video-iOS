//
//  ViewController.swift
//  CannonGame(MVC)
//
//  Created by 김지영 on 29/07/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CannonControlViewDelegate {
    //MARK: - Define Value
    //MARK: View
    @IBOutlet weak var cannonControlView: CannonControlView!
    @IBOutlet weak var cannonFieldView: CannonFieldView!
    var cannonBallViews = [Int:UIView]()
    
    //MARK: Model
    var cannonBallModels : [CannonBallModel]()
    
    //MARK: value
    var key : Int = 0
    var timer : Timer = Timer()
    var potentialCannonSpeed : CGFloat = 10
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        //delegate
        cannonControlView.delegate = self
        
        //init cannonModel
        gameModel?.cannonStructModel = CannonStructModel.init(currentLoc: cannonFieldView.cannon.center, frame: cannonFieldView.commonBall.frame)
        gameModel?.cannonStructModel?.updateCannonVector(radian: CGFloat.pi/2, speed: potentialCannonSpeed)
        //view init
        cannonFieldView.cannonFieldInit()
        
        //timer init
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(changeCannonBallPosition), userInfo: nil, repeats: true)
    }
    //-------------------------------------------------------------
    // MARK: - Implementation of CannonContorlView's protocol method
    //
    
    /*
     포탄 type 바꾸기
     버튼에 해당하는 type으로 포탄 type 바꿈
     */
    func changeType(type: String) {
        switch type {
            
        case "triangle":
            gameModel?.cannonStructModel?.type = type
            cannonFieldView.showChangeCannonBallType(type: type)
        case "circle":
            gameModel?.cannonStructModel?.type = type
            cannonFieldView.showChangeCannonBallType(type: type)
            
        case "rectangle":
            gameModel?.cannonStructModel?.type = type
            cannonFieldView.showChangeCannonBallType(type: type)
        default:
            print("default")
            
        }
    }
    
    func changeDegreeCannon(sliderValue: Float) {
        //움직인 슬라이더 값을 라디안으로 변환.
        //슬라이더 값: 왼쪽 - 가운데 - 오른쪽 == 0 - 0.5 - 1
        let radian = sliderValueToRadian(sliderValue: sliderValue)
        
        //Model update : 대포, 포탄 라디안 업데이트
        gameModel?.cannonStructModel?.updateCannonVector(radian: radian, speed: potentialCannonSpeed)
        
        //View update : cannonStructView rotate
        cannonFieldView.roateCannonStruct(radian: radian)
        
    }
    
    //MARK: 계산 값
    
    /**
     슬라이더 값을 라디안 값으로 전환 후 리턴
     슬라이더 값 -> 라디안 값 (-45 - 45도 처럼 보임)
    */
    private func sliderValueToRadian(sliderValue: Float) -> CGFloat{
        let radian = CGFloat.pi/4 + (3*CGFloat.pi/4 - CGFloat.pi/4) * CGFloat(sliderValue)
        return radian
    }
    
    //tap fire
    func fireCannonBall(){
        //define value
        let currentCannonLoc = gameModel?.cannonStructModel?.currentLoc ?? CGPoint(x: 0, y: 0)
        let cannonVector = gameModel?.cannonStructModel?.vector ?? CGVector(dx: 0, dy: 0)
        let radian = gameModel?.cannonStructModel?.radian ?? 0 
        key += 1
        //key값이 커졌을 때 0으로 초기화
        if key == Int.max{
            key = 0
        }
        
        let cannonBallModel = CannonBallModel(currentLoc: currentCannonLoc, vector: cannonVector, key: key, radian: radian)
        
        //update model
        gameModel?.cannonBallModel?.append(cannonBallModel)
        
        //make view
        var cannonBallView = CannonBallView()
        
        let type = gameModel?.cannonStructModel?.type
        let frame = gameModel?.cannonStructModel?.frame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
        
        switch type {
            case "rectangle":
                cannonBallView = CannonBallView(frame: frame)
                cannonBallView.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
            case "circle":
                cannonBallView = CannonBallView(frame: frame)
                cannonBallView.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
                cannonBallView.circleView()
            case "triangle":
                cannonBallView = TriangleView(frame: frame)
                cannonBallView.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2)
            default:
                cannonBallView = CannonBallView(frame: frame)
                cannonBallView.transform = CGAffineTransform.identity.rotated(by: radian - CGFloat.pi/2) 
        }
        //dict 기록
        cannonBallViews[cannonBallModel.key] = cannonBallView
        //뷰 추가
        self.cannonFieldView.addSubview(cannonBallView)
    }

    //timer
    @objc func changeCannonBallPosition(){
        
        if let cannonBallModels = gameModel?.cannonBallModel{
            for index in 0..<cannonBallModels.count{
                let willRemove = moveOrRemove(cannonBallModel: cannonBallModels[index])
                if willRemove{
                   // gameModel?.cannonBallModel?.remove(at: index)
                }
            }
        }
    }
    
    func moveOrRemove(cannonBallModel : CannonBallModel)->Bool{
        cannonBallModel.moveCannonBall()
        cannonBallViews[cannonBallModel.key]?.center = cannonBallModel.position
        //수퍼뷰 관점에서 포탄 위치
        let currentBallLoc = cannonFieldView.convert(cannonBallViews[cannonBallModel.key]?.center ?? CGPoint(x: 0, y: 0), to: nil)
        print(currentBallLoc)
        //화면 밖으로 나가면
        if currentBallLoc.x <= 0 || currentBallLoc.x >= ((self.view.frame.maxX) + CGFloat(0))  || currentBallLoc.y <= 0 {
            print("제거")
            //view 제거
            cannonBallViews[cannonBallModel.key]?.removeFromSuperview()
            cannonBallViews.removeValue(forKey: cannonBallModel.key)
            return true
        }else{
            return false
        }
    }
    
}

