//
//  MacawBarGraph.swift
//  PPnoStoryboards
//
//  Created by Sean Devine on 15.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import Macaw


class MacawBarGraph: MacawView {
    
    static var lastFiveShows = getLastFiveWeeks()
    
    
    static var maxValue: Double = {
        let maximumGet = Double(WeeklyService.getMaxValue())
        
        var max: Double
        if maximumGet > 9 {
            max = maximumGet + Double(Int(Double(WeeklyService.getMaxValue()) * 0.1))
        } else {
            max = maximumGet + Double(Int(Double(WeeklyService.getMaxValue()) * 0.2))
        }
        
        if max == 0 {
            max = 9
        }
    return max
    }()
    
  
    
    static let maxValueLineHeight: Double = 160
    static let lineWidth: Double = 275
    
    static var dataDivisor = Double(maxValueLineHeight / maxValue)
    static var adjustedData: [Double] = lastFiveShows.map({ Double($0.totalTime) * dataDivisor})
    static var animations: [Animation] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.node = MacawBarGraph.createChart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: MacawBarGraph.createChart(), coder: aDecoder)
        
        backgroundColor = .clear
    }
    
    
    public static func createChart() -> Group {
        
        var items: [Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())
        
        return Group(contents: items, place: .identity)
    }
    
    
    private static func addYAxisItems() -> [Node] {
        let maxLines = 6
        let lineInterval = Int(maxValue / Double(maxLines))
        let yAxisHeight: Double = 170
        let yLineSpacing: Double = 26.6
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * yLineSpacing)
            //
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.gray.with(a: 0.10))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.gray
            
            //            newNodes.append(valueLine)
            //            newNodes.append(valueText)
        }
        
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.1))
        //
        newNodes.append(yAxis)
        
        return newNodes
    }
    
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 170
        var newNodes: [Node] = []
        
        
        for i in 1...adjustedData.count {
            let x = (Double(i) * 50) - 10
            
            let valueText = Text(text: "\(lastFiveShows[i - 1].weekNumber)",align: .mid, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.gray
            
            newNodes.append(valueText)
        }
        
        let weekText = Text(text: "Week:", fill: Color.gray, align: .mid, baseline: .mid, place: .move(dx: 0, dy: chartBaseY + 15))
        newNodes.append(weekText)
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.gray.with(a: 0.15))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    
    private static func createBars() -> Group {
        let fill = LinearGradient(degree: 90, from: Color(val: 0x99f5ff).with(a: 0.95), to: Color(val: 0x99f5ff).with(a: 0.29))
        let items = adjustedData.map { _ in Group() }
        
        animations = items.enumerated().map { (i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
                
                let height = adjustedData[i] * t
                let rect = Rect(x: Double(i) * 50 + 25, y: 170 - height, w: 30, h: height)
                
                let totalMinutesText = Text(text: "\(Int(Double(lastFiveShows[i].totalTime) * t))", place: .move(dx: Double(i) * 50 + 31.25, dy: 170 - height - 22))
                totalMinutesText.font = Font(name: "Helvetica", size: 16)
                totalMinutesText.fill = Color.gray
                
                return [rect.fill(with: fill), totalMinutesText]
            }
        }
        
        return items.group()
    }
    
    static func updateValues() {
//        Weeks
        lastFiveShows = getLastFiveWeeks()
//        maxValue
        let maximumGet = Double(WeeklyService.getMaxValue())
        var max: Double
        if maximumGet > 9 {
            max = maximumGet + Double(Int(Double(WeeklyService.getMaxValue()) * 0.1))
        } else {
            max = maximumGet + Double(Int(Double(WeeklyService.getMaxValue()) * 0.2))
        }
        if max == 0 {
            max = 9
        }
        maxValue = max
//      dataDivisor
        dataDivisor = Double(maxValueLineHeight / maxValue)
//      adjustedData
       adjustedData = lastFiveShows.map({ Double($0.totalTime) * dataDivisor})
        
    }
    
    static func playAnimations() {
        
        
        animations.combine().play()
    }
    
    
    private static func getLastFiveWeeks() -> [WeeklyProgress] {
        var result: [WeeklyProgress] = []
        
        let count = WeeklyService.allWeeklyServices.count
        let theArray = WeeklyService.allWeeklyServices
        
        if WeeklyService.allWeeklyServices.count > 5 {

            for x in stride(from: 5, through: 1, by: -1) {
                
                result.append(theArray[count-x])
            }
            
            
        } else {

            result = theArray
            
        }
        
        return result
        
    }
    
    
    private static func createDummyData() -> [SwiftNews] {
        
        let one = SwiftNews(number: "1", viewCount: 45)
        let two = SwiftNews(number: "2", viewCount: 40)
        let three = SwiftNews(number: "3", viewCount: 55)
        let four = SwiftNews(number: "4", viewCount: 12)
        let five = SwiftNews(number: "5", viewCount: 40)
        
        return [one, two, three, four, five]
    }
    
    
}
