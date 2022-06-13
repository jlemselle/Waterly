//
//  Stats.swift
//  Waterly
//
//  Created by James Emselle on 1/7/21.
//

import SwiftUI

struct Stats: View {
    let dayInSeconds = 86400;
    
    @FetchRequest(
        entity: Water.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Water.timestamp, ascending: true)
        ]
    ) var history: FetchedResults<Water>
    
    func convertToIntervals(dates: [Date]) -> [TimeInterval] {
        var prevDate: Date? = nil
        var timeIntervals: [TimeInterval] = []
        for date in dates.sorted() {
            if let since = prevDate {
                timeIntervals.append(date.timeIntervalSince(since))
            }
            
            prevDate = date
        }
        return timeIntervals
    }
    
    func stat(_ description: LocalizedStringKey, _ value: Double) -> some View {
        return HStack {
            Text(description)
            Text(String(format: "%.2f", value))
            Text("days")
        }
    }
    
    var body: some View {
        let timeIntervals: [TimeInterval] = convertToIntervals(dates: history.map({ $0.timestamp! }))
        
        VStack {
            Text("Time between waters")
                .font(.title)
            if (timeIntervals.isEmpty) {
                Text("Please log at least 2 waters for statistics")
                    .multilineTextAlignment(.center)
            } else {
                stat("Average", timeIntervals.reduce(0, {$0 + $1}) / Double(timeIntervals.count) / Double(dayInSeconds))
                stat("Shortest", timeIntervals.min()! / Double(dayInSeconds))
                stat("Longest", timeIntervals.max()! / Double(dayInSeconds))
            }
        }
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats()
    }
}
