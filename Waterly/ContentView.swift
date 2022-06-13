//
//  ContentView.swift
//  Waterly
//
//  Created by James Emselle on 26/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .lastWatered
    
    enum Tab {
        case plants
        case lastWatered
        case waterHistory
        case stats
    }
    
    var body: some View {
        TabView(selection: $selection) {
            LastWatered()
                .tabItem {
                    Label("Home", systemImage: "drop")
                }
                .tag(Tab.lastWatered)
            
//            PlantEditor()
//                .tabItem {
//                    Label("Plants", systemImage: "leaf")
//                }
//                .tag(Tab.plants)
            
            HistoryList()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
                .tag(Tab.waterHistory)
            
            Stats()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }
                .tag(Tab.stats)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
