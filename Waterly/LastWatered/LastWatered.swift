//
//  LastWatered.swift
//  Waterly
//
//  Created by James Emselle on 27/6/21.
//

import SwiftUI

struct LastWatered: View {
    @State var lastWatered: Date? = UserDefaults.standard.object(forKey: "LastWatered") as! Date?
    @Binding var history: [Date]
    
    var body: some View {
        VStack {
            Text("Last watered the plants on")
                .font(.title)
            VStack {
                if lastWatered != nil {
                    Text(lastWatered ?? Date(), style: .date)
                    Text("at").font(.subheadline)
                    Text(lastWatered ?? Date(), style: .time)
                } else {
                    Text("never")
                }
            }.font(.largeTitle)
            .padding(.bottom)
            Button(action: {
                let newDate = Date()
                lastWatered = newDate
                UserDefaults.standard.set(newDate, forKey: "LastWatered")
                
                history.append(newDate)
                UserDefaults.standard.set(history, forKey: "History")
            }, label: {
                HStack {
                    Text("Watered")
                    Image(systemName: "drop.fill")
                }
            })
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
            .foregroundColor(.white)
            .font(.title)
        }
    }
    
    static func parseDate(from: Int) -> Date? {
        if from == 0 {
            return nil
        } else {
            return Date(timeIntervalSince1970: TimeInterval(from))
        }
    }
}

struct LastWatered_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LastWatered(history: .constant([Date()]))
            //LastWatered()
            //    .environment(\.managedObjectContext, PersistenceController.emptyPreview.container.viewContext)
        }
        .environment(\.sizeCategory, .extraExtraLarge)
        .environment(\.locale, Locale(identifier: "fr"))
        .previewDevice("iPhone 12 mini")
    }
}
