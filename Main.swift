//
//  Main.swift
//  homework5
//
//  Created by User08 on 2020/11/23.
//

import SwiftUI
struct Subject: Identifiable, Codable{
    let id = UUID()
    var subName:String
    var score:Int
    var state:String
    var val:CGFloat//程度
    var time:Int
    var pic :String
    var index :Int
    var state_index :Int
    var article :String
    
}
class SubjectData:ObservableObject{
    //@Published var subject = [Subject]()
    @AppStorage("subjects") var subjectData: Data?

    @Published var subject = [Subject]() {
        
        didSet {
            
            let encoder = JSONEncoder()
            
            do {
                
                let data = try encoder.encode(subject)
                
                subjectData = data
                
            } catch {
                
            }
            
        }
        
    }
    
    init() {
        
        if let subjectData = subjectData {
            
            let decoder = JSONDecoder()
            
            if let decodedData = try? decoder.decode([Subject].self,
                                                     
                                                     from: subjectData) {
                
                subject = decodedData
                
            }
            
        }
        
    }
}



struct Main: View {
    @StateObject var subjectsData = SubjectData()
    var body:some View {
            
            TabView{
                ContentView(subjectsData: subjectsData ).tabItem{
                    Image(systemName:"list.bullet")
                }
                BarChart(subData:subjectsData).tabItem{
                    Image(systemName:"chart.pie")
                    
                }
                .navigationBarTitle(Text("Me"),displayMode: .inline).accentColor(.blue)
            }.accentColor(.orange)
        
    }
    
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}


