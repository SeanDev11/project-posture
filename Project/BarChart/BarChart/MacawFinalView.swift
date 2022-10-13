//
//  MacawFinalView.swift
//  BarChart
//
//  Created by Sean Devine on 14.10.19.
//  Copyright © 2019 Sean Devine. All rights reserved.
//

import Foundation
import Macaw

class MacawFinalView: MacawView {
    
    static let lastFiveShows = createDummyData()
    static let maxValue: Double = 320
    static let maxValueLineHeight: Double = 160
    static let lineWidth: Double = 275
    
    static let dataDivisor = Double(maxValueLineHeight / maxValue)
    static let adjustedData: [Double] = lastFiveShows.map({ Double($0.viewCount) * dataDivisor})
    static var animations: [Animation] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.node = MacawFinalView.createChart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: MacawFinalView.createChart(), coder: aDecoder)
        
        backgroundColor = .clear
    }
    
    
    private static func createChart() -> Group {
        
        var items: [Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())
        
        return Group(contents: items, place: .identity)
    }
    
    
    private static func addYAxisItems() -> [Node] {
        let maxLines = 6
        let lineInterval = Double(maxValue / Double(maxLines))
        let yAxisHeight: Double = 180
        let yLineSpacing: Double = maxValueLineHeight / Double(maxLines)
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * yLineSpacing)
//
           let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.gray.with(a: 0.10))
           let valueText = Text(text: "\(Int(Double(i) * lineInterval))", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.gray
 
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        
       let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.1))
//        
      newNodes.append(yAxis)
        
        return newNodes
    }
    
    
    private static func addXAxisItems() -> [Node] {
        let chartBaseY: Double = 180
        var newNodes: [Node] = []
        
        for i in 1...adjustedData.count {
            
            let x = Double(i) * 50
            let valueText = Text(text: lastFiveShows[i - 1].number, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.white
            
            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.gray.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    
    private static func createBars() -> Group {
        let fill = LinearGradient(degree: 90, from: Color(val: 0x99f5ff).with(a: 0.95), to: Color(val: 0x99f5ff).with(a: 0.29))
        let items = adjustedData.map { _ in Group() }
        
        animations = items.enumerated().map { (i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
               
                let height = adjustedData[i] * t
                let rect = Rect(x: Double(i) * 50 + 25, y: 180 - height, w: 30, h: height)

                let totalMinutesText = Text(text: "\(Int(Double((lastFiveShows[i].viewCount)) * t))", place: .move(dx: Double(i) * 50 + 31.25, dy: 180 - height - 22))
                totalMinutesText.font = Font(name: "Helvetica", size: 16)
                totalMinutesText.fill = Color.gray
                
                return [rect.fill(with: fill), totalMinutesText]
            }
        }
        
        return items.group()
    }
    

    static func playAnimations() {
        animations.combine().play()
    }
    

    private static func createDummyData() -> [SwiftNews] {
        
        let one = SwiftNews(number: "1", viewCount: 0)
        let two = SwiftNews(number: "2", viewCount: 0)
        let three = SwiftNews(number: "3", viewCount: 0)
        let four = SwiftNews(number: "4", viewCount: 300)
        let five = SwiftNews(number: "5", viewCount: 80)
        
        return [one, two, three, four, five]
    }
    
    
}
