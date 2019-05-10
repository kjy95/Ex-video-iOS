//
//  SmiParser.swift
//  ScriptJumper
//
//  Created by 김지영 on 07/05/2019.
//  Copyright © 2019 김지영. All rights reserved.
//

import Foundation
import UIKit
class SmiParser {
    var clockList = [String]()
    var onlySubtitleList: Array<String>?
    init(subfileName: String, ofType: String){
        let smiUtf8 = getEncodingSmiUtf8(forResource: subfileName, ofType: ofType)
        let timeList = getRegexArr(pattern:"(?<=<sync start=)[0-9]+(?=>)", string: smiUtf8)
        setClockList(timeList: timeList)
        var subtitleListWithTag = getRegexArr(pattern:"(?<=<sync start=)[\\S\\s]+?(?=<sync start=|</body>)", string: smiUtf8)
        onlySubtitleList = subtitleListWithTag
        //divide onlySubtitleList & subtitleListWithTag
        for i in Range(0...subtitleListWithTag.count-1){
            let subtitle = subtitleListWithTag[i]
            if let index = (subtitle.range(of: ">")?.upperBound)
            {
                let afterEqualsTo = String(subtitle.suffix(from: index))
                subtitleListWithTag[i] = afterEqualsTo
            }
            onlySubtitleList![i] = subtitleListWithTag[i].withoutHtml
        }
        // Without Html Tag
        printSubtitleWithTime(timeList: timeList, onlySubtitleList: onlySubtitleList!)
        // With Html Tag
        //printSubtitleWithTime(timeList: timeList, onlySubtitleList: subtitleList)
    }
    func getEncodingSmiUtf8(forResource: String, ofType: String)->String{
        var text : String!
        let path = Bundle.main.path(forResource: forResource, ofType: ofType) // file
        do {
            text = try String(contentsOfFile: path!, encoding: .utf8)
        }
        catch(_){print("error")}
        return text
    }
    func getRegexArr(pattern: String, string: String)->Array<String>{
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let NSsmiUtf8List = string as NSString
        let leachedStringArray = regex?.matches(in: string, range: NSRange(location: 0, length: NSsmiUtf8List.length)).map {
            NSsmiUtf8List.substring(with: $0.range)
        }
        return leachedStringArray!
    }
    func printSubtitleWithTime(timeList: Array<String>, onlySubtitleList: Array<String>){
        for (time, subtitle) in zip(timeList, onlySubtitleList){
            if let milliseconds = Int(time){
                let seconds = milliseconds  / 1000 % 60
                let minutes =  milliseconds  / 1000 / 60
                let hours =  minutes / 60
                let clock = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                print("\(clock)\n\(subtitle)")
            }
        }
    }
    func setClockList(timeList: Array<String>){
        for time in timeList{
            if let milliseconds = Int(time){
                let seconds = milliseconds  / 1000 % 60
                let minutes =  milliseconds  / 1000 / 60
                let hours =  minutes / 60
                let clock = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                self.clockList.append(clock)
            }
        }
    }
}

extension String {
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}
