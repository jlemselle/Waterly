//
//  HistoryItem.swift
//  Waterly
//
//  Created by James Emselle on 30/6/21.
//

import SwiftUI

struct HistoryItem: View {
    var date: Date
    
    var body: some View {
        HStack {
            Text(date, style: .date)
            Text("at")
            Text(date, style: .time)
            Spacer()
            Image(systemName: "drop")
        }
        .padding()
    }
}

struct HistoryItem_Previews: PreviewProvider {
    static var previews: some View {
        HistoryItem(date: Date())
    }
}
