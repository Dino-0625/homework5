//
//  SubjectView.swift
//  homework5
//
//  Created by User09 on 2020/11/20.
//

import SwiftUI

struct SubjectView: View {
    var subject : Subject
    var col: Double
    init (subject:Subject){
        self.subject = subject
        col = Double(subject.val)/100
    }
    var body: some View {
        HStack{
            ZStack {
                Image("rrr")
                Text(subject.pic).frame(width:30,height:30).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }.frame(width:30,height:30).clipShape(Circle())
            Text(subject.subName).font(.system(size:15))
            Spacer()
            VStack {
                
                Text("狀態："+"\(subject.state)").font(.system(size:10)).foregroundColor(.green)
                Text("期中考：\(subject.score)分").font(.system(size:10)).foregroundColor(.red)
                
            }
            
            
            Spacer()
            Text("\(subject.val,specifier: "%.1f")%").foregroundColor(Color(red: col, green: 0.8, blue: 0.8))
        }
    }
}

struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView(subject:Subject( subName:"程式語言",score:50,state:"無",val:0,time:0,pic:"",index:0,state_index:0,article:"")).previewLayout(.sizeThatFits).accentColor(.blue)
    }
}
