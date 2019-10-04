//
//  RoomData.swift
//  snapkitList
//
//  Created by Tori on 04/10/2019.
//  Copyright © 2019 Tori. All rights reserved.
//

import Foundation
import Alamofire

/**
 숙소 정보
 */
class RoomData{
    //data form
    var roomDatas : [RoomData] = []
    
    var items : [Any] = []
    var title: String?//업체명
    var listAddress: String?//주소
    var rate: String?//평점
    var reviewCount: String? //리뷰갯수
    var thumbnail: String?
    var rentInfo: [String:Any] = [:]//대실정보 = strikePrice(원가, strike), listPrice(할인가), badgeInfo(뱃지정보) = title(뱃지타이틀)
    var stayInfo: [String:Any] = [:]//대실정보 = strikePrice(원가, strike), listPrice(할인가), badgeInfo(뱃지정보) = title(뱃지타이틀)
    var placeInfo: [String:Any] = [:]//하단이벤트 정보 = promotion(이벤트명)
    
    func getDataFromUrl(_ complete: @escaping ([RoomData]) -> ()){
        //url
        guard let url = URL(string: "https://dev-api-gw.abouthere.kr/v3/products?browser=iPhone10%2C4&category=1&check_in=2019-10-04&check_out=2019-10-05&deviceid=EA35F2B5-8FF6-4CD7-93CA-EB4A9A5F77D3&lat=37.513209749687&lon=127.05339665181&mode=around&page=1&uosgubn=I") else{
            print("url error")
            return
        }
        
        //get data
        Alamofire.request(url, method: .get).validate().responseJSON{ response in
            guard response.result.isSuccess else{
                print("Error remote")
                return
            }
            
            guard let value = response.result.value as? [String: Any],
                let data = value["data"] as? [String: Any], let items = data["items"] as? [Any] else{
                print("no vlaue")
                return
            }
            self.items = items

            self.setItem()
            complete(self.roomDatas)
        }
    }
    
    func setItem(){
        for item in items{
            let temp = item as? [String:Any]
            
            let roomData = RoomData()
            
            if let title = temp?["title"]{
                roomData.title = title as? String
            }
            if let listAddress = temp?["listAddress"]{
                roomData.listAddress = listAddress as? String
            }
            if let rate = temp?["rate"] {
                roomData.rate = rate as? String
            }
            if let reviewCount = temp?["reviewCount"]{
                roomData.reviewCount = reviewCount as? String
            }
            if let rentInfo = temp?["rentInfo"]{
                roomData.rentInfo = rentInfo as? [String:Any] ?? [:]
            }
            if let stayInfo = temp?["stayInfo"]{
                roomData.stayInfo = stayInfo as? [String:Any] ?? [:]
            }
            if let placeInfo = temp?["placeInfo"]{
                roomData.placeInfo = placeInfo as? [String:Any] ?? [:]
            }
            if let thumbnail = temp?["thumbnail"]{
                roomData.thumbnail = "http://image.dev.abouthere.kr\(thumbnail as! String)"
            }
            print(roomData.title)
            roomDatas.append(roomData)
        }
    }
}
