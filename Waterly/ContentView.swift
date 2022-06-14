//
//  ContentView.swift
//  Waterly
//
//  Created by James Emselle on 26/6/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    enum Tab {
        case plants
        case lastWatered
        case waterHistory
        case stats
    }
    
    var body: some View {
        TabView() {
            LastWatered()
                .tabItem {
                    Label("Home", systemImage: "drop")
                }
            
//            PlantEditor()
//                .tabItem {
//                    Label("Plants", systemImage: "leaf")
//                }
//                .tag(Tab.plants)
            
            HistoryList()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
            
            Stats()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
