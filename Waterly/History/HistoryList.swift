//
//  HistoryList.swift
//  Waterly
//
//  Created by James Emselle on 30/6/21.
//

import SwiftUI

struct HistoryList: View {
    @Binding var history: [Date]
    
    var body: some View {
        NavigationView {
            List {
                Button("Clear History") {
                    history.removeAll()
                    UserDefaults.standard.set(history, forKey: "History")
                }
                ForEach(history, id: \.self) { item in
                    HistoryItem(date: item)
                }
            }
            .navigationTitle("History")
        }
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList(history: .constant([Date()]))
            .environment(\.locale, Locale(identifier: "fr"))
    }
}
