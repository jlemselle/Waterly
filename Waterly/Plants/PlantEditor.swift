//
//  PlantEditor.swift
//  Waterly
//
//  Created by James Emselle on 4/7/21.
//

import SwiftUI

enum Season: String, CaseIterable, Identifiable {
    case summer = "Summer"
    case autumn = "Autumn"
    case winter = "Winter"
    case spring = "Spring"
    
    var id: String { self.rawValue }
}

struct PlantEditor: View {
    @State var name: String = ""
    @State var waterFrequency: Int = 0
    @State var lastPicked: Date = Date()
    @State var season: Season = Season.summer
    var body: some View {
        Form {
            
            Section(header: Text("Plant Details")) {
                TextField("Plant Name", text: $name)
                
                Picker("Season", selection: $season) {
                    ForEach(Season.allCases) {
                        season in
                        Text(season.rawValue).tag(season)
                    }
                }
            }
                
            Section(header: Text("Maintenance")) {
                Picker("Water frequency", selection: $waterFrequency) {
                    ForEach(1..<5) {
                        x in
                        Text("Every \(x) day(s)")
                            .tag(x)
                    }
                }
                
                DatePicker("Last Watered", selection: $lastPicked)
                
                DatePicker("Last Picked", selection: $lastPicked)
            }
        }
    }
}

struct PlantEditor_Previews: PreviewProvider {
    static var previews: some View {
        PlantEditor()
    }
}
