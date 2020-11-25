//
//  BarChart.swift
//  homework5
//
//  Created by User08 on 2020/11/23.
//

import SwiftUI

struct BarChart: View {
    @State private var pickerSelectedItem = 0
    @State private var dataPoints: [[CGFloat]] = [
    [100, 120, 150],
    [150, 100, 120],
    [120, 150, 100],
    [120, 100, 150],
    [130, 50, 100]
    ]
    @ObservedObject var subData = SubjectData()
    var temp = ["score","val","time"]
    
    var body: some View {
        ZStack {
            Color("Color")
                .edgesIgnoringSafeArea(.all)
            //Image("Image3").resizable().scaledToFit()
            //Color(.orange)
            VStack {
                Text("課程評估")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    .foregroundColor(Color(.white))
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("score").tag(0)
                    Text("程度").tag(1)
                    Text("時間").tag(2)
                    
                }.pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 24)
                ScrollView(.horizontal) {
                    HStack(alignment: .bottom,spacing: 8) {
                    
                   
                        ForEach(subData.subject.indices){
                                (index) in
                                if pickerSelectedItem == 0 {
                                BarView(value: CGFloat(subData.subject[index].score), name:subData.subject[index].subName,word_type:0)
                                }
                                if pickerSelectedItem == 1 {
                                BarView(value: CGFloat(subData.subject[index].val), name:subData.subject[index].subName,word_type:1)
                                }
                                if pickerSelectedItem == 2 {
                                BarView(value: CGFloat(subData.subject[index].time), name:subData.subject[index].subName,word_type:2)
                                }
                        }
                    }
                        
                    }.padding(.top, 24)
                    .animation(.default)
                
                
            }
        }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(subData: SubjectData())
    }
}

struct BarView: View {
    var value: CGFloat = 0
    var name: String = ""
    var word_type: Int
    var word = ["分數","被當機率"]
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .bottom) {
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(Color(.random()))
                Capsule().frame(width: 30, height: value)
                    .foregroundColor(Color(.random()))
                /*Capsule().frame(width: 30, height: value)
                    .foregroundColor(Color(.white))
                Capsule().frame(width: 20, height: value)
                    .foregroundColor(Color(.white))
                Capsule().frame(width: 20, height: value)
                    .foregroundColor(Color(.white))*/
            }
            
            Text(name)
            if word_type == 0 {
            Text("\(value,specifier: "%.f")分")
            }
            if word_type == 1 {
                Text("‘認真程度：\(value,specifier: "%.f")")
            }
            if word_type == 2 {
                Text("花費時間：\(value,specifier: "%.f")")
            }
        }
    }
}
/*struct BarView_Previews: PreviewProvider {
static var previews: some View {
BarView()
  }
}*/
