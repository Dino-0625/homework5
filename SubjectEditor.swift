//
//  SubjectEditor.swift
//  homework5
//
//  Created by User09 on 2020/11/20.
//

import SwiftUI
//extension String: Identifiable {
//    public var id: String { self }
//}
struct classshow {
    var name: String
    var pic: String
}

struct SubjectEditor: View {
    var subjectsData : SubjectData
    @Environment(\.presentationMode) var presentationMode
    @State private var time = 0
    @State private var score : Int = 0
    @State private var state = 0
    @State private var week = 0
    @State private var selectclasses = ""
    @State private var pic = ""
    @State private var index = 0
    @State private var states_index = 0
    @State private var article = ""
    @State private var val : CGFloat = 0
    var editsubjectIndex: Int?
    var states = ["穩拉","岌岌可危","期中退選","隨便"]
    var classes = [
        classshow(name: "程式語言", pic:"L"),
        classshow(name:"資料庫" , pic:"D"),
        classshow(name: "計算機系統分析", pic:"C"),
        classshow(name: "數值分析", pic:"M"),
        classshow(name: "資訊安全", pic:"I"),
        classshow(name: "電腦圖學", pic:"G"),
        classshow(name: "巨量資料", pic:"M"),
        classshow(name: "軟體工程", pic:"S"),
        classshow(name:"作業系統" , pic:"OS")]
    //@State var gg : String = ""
    var body: some View {
       
        VStack {
            Form {
                    
                HStack {
                    Text("付出程度")
                    Slider(value: $val, in: 1...100, minimumValueLabel:  Image(systemName: "0.circle"), maximumValueLabel:  Image(systemName: "99.circle")){
                        Text("")
                    }.clipped()
                }
                HStack {
                    Text("花費時間")
                    TextField("每週幾分鐘",value: $time ,formatter: NumberFormatter())
                }
                Picker(selection: $states_index, label: Text("狀態選擇")) {
                    ForEach(states.indices) { (index) in
                        Text("\(states[index])").font(.system(size: 40))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
//                    TextField("狀態",value: $state ,formatter: NumberFormatter())
                HStack {
                    Text("期中考分數：").foregroundColor(.blue)
                    TextField("分數:\(score)",value: $score ,formatter: NumberFormatter()).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Text("\(score)")
                    //PieChart
                Text("選擇的課程:"+classes[index].name)
                    Picker(selection: $index, label: Text("選擇課程:")){
                        ForEach(classes.indices) { (index) in
                            
                            Text(classes[index].name)
                                }
                    }.pickerStyle(WheelPickerStyle())
                    
                }
                .toolbar(content:{
                    ToolbarItem{
                        Button("Save"){
                            let subject = Subject(
                                subName: classes[index].name, score: self.score,
                                state: states[states_index],
                                val: val,time:time,
                                pic: classes[index].pic,
                                index : index,
                                state_index: states_index,
                                article:article)//index is for choose course & pic
                            if let editsubjectIndex = editsubjectIndex{
                                subjectsData.subject[editsubjectIndex] = subject
                            }
                            else{
                                subjectsData.subject.insert(subject,at:0)
                            }
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }).onAppear(perform:{
                    if let editsubjectIndex = editsubjectIndex{
                        let editsub =  subjectsData.subject[editsubjectIndex]
                        index = editsub.index
                        time = editsub.time
                        score = editsub.score
                        states_index = editsub.state_index
                        article = editsub.article
                        val = editsub.val
                    }
                })
            .navigationBarTitle(editsubjectIndex == nil ? "新增科目" : "修改科目")
            TextField("備註：",text:$article)
            
        }
        
    }
}

struct SubjectEditor_Previews: PreviewProvider {
    static var previews: some View {
        SubjectEditor(subjectsData:SubjectData())
    }
}
