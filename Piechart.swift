//
//  Piechart.swift
//  homework5
//
//  Created by User09 on 2020/11/20.
//

import SwiftUI

/*classshow(name: "程式語言", pic:"L"),
classshow(name:"資料庫" , pic:"D"),
classshow(name: "計算機系統分析", pic:"C"),
classshow(name: "數值分析", pic:"M"),
classshow(name: "資訊安全", pic:"I"),
classshow(name: "電腦圖學", pic:"G"),
classshow(name: "巨量資料", pic:"M"),
classshow(name: "軟體工程", pic:"S"),
classshow(name:"作業系統" , pic:"OS")]*/

struct colorset {
    var red : Double
    var green : Double
    var blue : Double
}
struct PieChart: Shape {
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        Path { (path) in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            path.move(to: center)
            path.addArc(center: center, radius: rect.midX,
                        startAngle: startAngle, endAngle: endAngle, clockwise: false)
        }
        
    }
}

let col = [colorset(red: 0.1, green: 0.2, blue: 0.3),
           colorset(red: 0.2, green: 0.3, blue: 0.4),
           colorset(red: 0.3, green: 0.4, blue: 0.5),
           colorset(red: 0.4, green: 0.5, blue: 0.6),
           colorset(red: 0.5, green: 0.6, blue: 0.7),
           colorset(red: 0.6, green: 0.7, blue: 0.8),
           colorset(red: 0.7, green: 0.8, blue: 0.9),
           colorset(red: 0.8, green: 0.9, blue: 0.1),
           colorset(red: 0.9, green: 0.1, blue: 0.2),
]
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var col:CGFloat = 0
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
struct Piechart: View {
    var percentages: [Double]
    var indexoutside : Int
    var littleChart : Bool = false
    var angles: [Angle]
    var total : Double
    
    
    
    init(indexoutside: Int,percentages: [Double],total: Double) {
        self.indexoutside = indexoutside
        self.total = total
        if percentages.count == 1 {
            self.littleChart = true
        }
        else {
            self.littleChart = false
        }
        self.percentages = percentages
        angles = [Angle]()
        var startDegree: Double = 0
        
        /*for pp in percentages {
            self.total += pp
        }*/
        for percentage in percentages {
            angles.append(.degrees(startDegree))
            startDegree += 360 * percentage / self.total
        }
        angles.append(.degrees(startDegree))
    }
    var body: some View {
        ZStack{
           
            ForEach(angles.indices){
                (index) in
                if !littleChart {
                    if index == angles.count - 1 {
                        PieChart(startAngle:angles[index],endAngle: .zero).fill(Color.black)
                    }
                    else {
                        PieChart(startAngle: angles[index], endAngle: angles[index+1]).fill(Color(red: col[index].red, green: col[index].green, blue: col[index].blue))
                        
                    }
                /*if littleChart {
                    Text("littleChart")
                }*/
                }
                 
                 
                else if littleChart {
                    PieChart(startAngle: .degrees(0), endAngle: .degrees(percentages[0])/total * 360).fill(Color.purple)
                    PieChart(startAngle: .degrees(percentages[0])/total * 360,endAngle: .zero).fill(Color.gray)
                }
            }
            
        }
    }
}

struct Piechart_Previews: PreviewProvider {
    static var previews: some View {
        Piechart(indexoutside: 0,percentages: [25,10,45,10],total: 0)
    }
}
