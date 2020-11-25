//
//  ContentView.swift
//  homework5
//
//  Created by User09 on 2020/11/20.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var subjectsData = SubjectData()
    //@StateObject var subjectsData = SubjectData()
    @State private var showEditor = false
    
    //    subjectsData = [Subject(subName: "啦啦啦", score: 60, state: 4, week: 3),Subject(subName: "顆顆", score: 80, state: 2, week: 5)]
    var body: some View {
        
        
        NavigationView {
            
            ZStack {
                Color(.green).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                List {
                    
                    NavigationLink(destination:TimeOnCourse(subjectsDatachange: subjectsData)){
                        Text("圓餅圖")
                    }
                    
                    ForEach(subjectsData.subject.indices,id: \.self){
                        (index) in
                        NavigationLink(destination: SubjectEditor(subjectsData:subjectsData,editsubjectIndex:index)){
                            SubjectView(subject:subjectsData.subject[index])
                        }
                        //SubjectView(subject:subject)
                        
                    }.onDelete{
                        (indexSet) in subjectsData.subject.remove(atOffsets: indexSet)
                    }.onMove { (indexSet, index) in
                        self.subjectsData.subject.move(fromOffsets: indexSet,
                                        toOffset: index)
                    }
                }.navigationBarTitle("科目列表").toolbar(content:{ToolbarItem(placement:.navigationBarTrailing){
                    Button(action:{showEditor=true},label:{Image(systemName:"plus.circle.fill")})
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                }
                
                ).sheet(isPresented:$showEditor){
                    NavigationView{
                        SubjectEditor(subjectsData:subjectsData)
                    }
            }
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(subjectsData: SubjectData())
    }
}
