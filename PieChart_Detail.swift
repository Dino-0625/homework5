//
//  PieChart_Detail.swift
//  homework5
//
//  Created by User09 on 2020/11/22.
//

import SwiftUI
func teststr(tempss : String) -> Int {
    if tempss == "岌岌可危" {
        return 1
    }
    if tempss == "穩拉" {
        return 0
    }
    if tempss == "期中退選" {
        return 2
    }
    if tempss == "隨便" {
        return 3
    }
    else {
        return 0
    }
}
struct PieChart_Detail: View {
    var img = ["Image1","Image2","Image3","Image4"]
        
    var ff : [Double] = [30,40,50]
    var subjects : SubjectData
    var index : Int = 1
    var texts = ["ㄏㄧㄚˋ ㄏㄧㄚˋ ㄏㄧㄚˋ","你快要被當拉","好選擇","喂喂喂～加油好嗎"]
    @State private var show = false
    @State private var rotateDegree: Double = 0
    @State private var trimEnd: CGFloat = 0
    
    var body: some View {
        
        ZStack {
            Color("Color2").edgesIgnoringSafeArea(.all)
            Image("circle").resizable().scaledToFit().frame(width:135,height:135).offset(x: 70, y: -6)
            //
            VStack(alignment: .trailing){
                    let temp = teststr(tempss: subjects.subject[index].state)
                VStack{
                    if show {
                        
                        Text("期中成績：\(subjects.subject[index].score)").font(.system(size: 30)).foregroundColor(.blue).transition(.slide)
                        Text("花費時間：\(subjects.subject[index].time)").font(.system(size: 30)).foregroundColor(.red).transition(.slide)
                        if subjects.subject[index].score < 60{
                        Text("期末需要成績：\(60-subjects.subject[index].score)").font(.system(size: 30)).foregroundColor(.green).transition(.slide)
                        }
                        else{
                            Text("超過６０分 可以了...").font(.system(size: 30)).foregroundColor(.green).transition(.slide)
                            
                        }
                    }
                }
                .animation(.easeInOut(duration: 5))
                .onAppear {
                self.show = true
                }
                
                VStack {
                   
                    
                    Circle()
                         .trim(from: 0, to: trimEnd)
                         .stroke(Color.blue, style: StrokeStyle(lineWidth: 10,
                        lineCap: .round))
                         .frame(width: 100, height: 100)
                         .animation(.linear(duration: 2))
                         .onAppear {
                            trimEnd = subjects.subject[index].val / 100
                     }
                }
                    
                    
                VStack{
                    Image(img[temp])
                        .rotationEffect(.degrees(rotateDegree))
                        .animation(Animation.linear(duration: 2)
                        )
                    Text(texts[temp]).font(.system(size: 15)).bold().foregroundColor(.blue).offset(x:-40)
                }
                .onAppear {
                    rotateDegree = 360
                }.offset(x:30,y:30)
            }.navigationTitle("進度")
        }
                    
    }
}

struct PieChart_Detail_Previews: PreviewProvider {
    static var previews: some View {
        PieChart_Detail(subjects : SubjectData(),index : 0 )
        
    }
}

