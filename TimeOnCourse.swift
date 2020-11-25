//
//  TimeOnCourse.swift
//  homework5
//
//  Created by User09 on 2020/11/20.
//

import SwiftUI

func dd(temp:SubjectData) -> CGFloat {
    var total : CGFloat = 0
    for i in temp.subject.indices{
        total+=temp.subject[i].val
    }
    
    return total
}
func makArray(temp:SubjectData) -> [Double] {
    var total = [Double]()
    var to : Double = 0 //record total
    for i in 0..<temp.subject.count{
        total.append(Double(temp.subject[i].val))
        to += total[i]
    }
    return total
}
struct TimeOnCourse: View {
    var subjectsDatachange : SubjectData
    var ratio : Float = 0
    var total : Float = 0
    @State private var totals = 0//計算總共付出程度
    @State private var showChart = false
    let col2 = [colorset(red: 0.1, green: 0.2, blue: 0.3),
               colorset(red: 0.2, green: 0.3, blue: 0.4),
               colorset(red: 0.3, green: 0.4, blue: 0.5),
               colorset(red: 0.4, green: 0.5, blue: 0.6),
               colorset(red: 0.5, green: 0.6, blue: 0.7),
               colorset(red: 0.6, green: 0.7, blue: 0.8),
               colorset(red: 0.7, green: 0.8, blue: 0.9),
               colorset(red: 0.8, green: 0.9, blue: 0.1),
               colorset(red: 0.9, green: 0.1, blue: 0.2),
    ]
    var body: some View {
        VStack{
            
            //Piechart(percentages: [10.5,30,50,40,50])
            
            let temp = makArray(temp:subjectsDatachange)
            
            Text("\(temp.count)")
            Piechart(indexoutside: 0,
                     percentages:makArray(temp: subjectsDatachange),
                     total: Double(dd(temp: subjectsDatachange))).frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).shadow(radius: 10).position(x:150,y:70)
            
            List{
                
                ForEach(subjectsDatachange.subject.indices){
                    (index) in
                    HStack {
            
                        if subjectsDatachange.subject[index].val != 0 {
                            Piechart(indexoutside:index,
                                     percentages: [Double(subjectsDatachange.subject[index].val)],
                                     total : Double(dd(temp: subjectsDatachange))).frame(width:30,height:30,alignment: .leading)
                            
                        }
                        else {
                            Image(systemName:"mark").frame(width:30,height:30)
                        }
                        Spacer()
                        ForEach(0 ..<  subjectsDatachange.subject[index].state_index){
                            (item) in
                            Image(systemName:"exclamationmark").foregroundColor(.red)
                        }
                        if subjectsDatachange.subject[index].state_index == 0 {
                            Image("")
                        }
                        
                        Rectangle().frame(width:10,height:10).foregroundColor(Color(red: col[index].red, green: col[index].green, blue: col[index].blue))
                        Text("\(subjectsDatachange.subject[index].subName)").font(.system(size:10))
                        Text("\(subjectsDatachange.subject[index].state)").font(.system(size:10)).foregroundColor(.orange).bold()
                        Button(action:{showChart=true}){
                            Image(systemName:"more")
                        }.sheet(isPresented:$showChart){
                            NavigationView{
                                PieChart_Detail(subjects: subjectsDatachange, index:index)
                                
                            }
                        }
                    }
                    
                }
            }
        }.navigationTitle("科目佔比").font(.system(size: 10))
    }
}

struct TimeOnCourse_Previews: PreviewProvider {
    static var previews: some View {
        TimeOnCourse(subjectsDatachange: SubjectData())
    }
}
