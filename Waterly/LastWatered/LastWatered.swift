//
//  LastWatered.swift
//  Waterly
//
//  Created by James Emselle on 27/6/21.
//

import SwiftUI
import CoreData

struct LastWatered: View {
    @State var watering: Bool = false
    @State var newDate: Date = Date()
    @State var image: Image? = nil
    @State var uiImage: UIImage? = nil
    @State var comment: String = ""
    @State var setReminder: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let reminder: Reminder = Reminder()
    
    @FetchRequest(
        entity: Water.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Water.timestamp, ascending: true)
        ]
    ) var history: FetchedResults<Water>
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                if let timestamp = history.last?.timestamp {
                    Text("You watered your plants on")
                        .multilineTextAlignment(.center)
                        .font(.title)
                    Text(timestamp, style: .date)
                    Text("at").font(.subheadline)
                    Text(timestamp, style: .time)
                } else {
                    Text("You haven't watered your plants yet")
                        .multilineTextAlignment(.center)
                        .font(.title)
                }
            }.font(.largeTitle)
            .padding(.bottom)
            WaterButton() {
                self.watering.toggle()
            }
        }
        .navigationTitle("Home")
        .sheet(isPresented: $watering) {
            VStack {
                Text("When did you water?")
                    .font(.title)
                Editor(date: $newDate, saving: {
                    watered(at: newDate)
                    image = nil
                    comment = ""
                    newDate = Date()
                    self.watering.toggle()
                }, cancel: {self.watering.toggle()}, image: $image, uiImage: $uiImage, comment: $comment, setReminder: $setReminder).padding()
            }
        }
    }
    
    func watered(at: Date) {
        let event = Water(context: managedObjectContext)
        event.timestamp = at
        event.image = uiImage?.jpegData(compressionQuality: 1)
        event.comment = comment
        do {
            try managedObjectContext.save()
        } catch {
            // handle the Core Data error
        }
        
        if (setReminder) {
            var dateComponent = DateComponents()
            dateComponent.minute = 3
            if let futureDate = Calendar.current.date(byAdding: dateComponent, to: at) {
                if futureDate > Date.now {
                    reminder.setReminder(at: futureDate)
                }
            }
        }
    }
}

struct LastWatered_Previews: PreviewProvider {
    static var previews: some View {
        LastWatered()
    }
}
