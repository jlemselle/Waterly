//
//  ContentView.swift
//  Waterly
//
//  Created by James Emselle on 26/6/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .lastWatered
    @State var history: [Date] = UserDefaults.standard.object(forKey: "History") as! [Date]? ?? []
    
    enum Tab {
        case lastWatered
        case waterHistory
    }
    
    var body: some View {
        TabView(selection: $selection) {
            LastWatered(history: $history)
                .tabItem {
                    Label("Last Watered", systemImage: "drop")
                }
                .tag(Tab.lastWatered)
            
            HistoryList(history: $history)
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
                .tag(Tab.waterHistory)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
