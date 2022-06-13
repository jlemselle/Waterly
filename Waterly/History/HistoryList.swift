//
//  HistoryList.swift
//  Waterly
//
//  Created by James Emselle on 30/6/21.
//

import SwiftUI

struct HistoryList: View {
    
    @FetchRequest(
        entity: Water.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Water.timestamp, ascending: true)
        ]
    ) var history: FetchedResults<Water>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var confirmDelete: Bool = false
    
    func getImage(event: FetchedResults<Water>.Element) -> UIImage? {
        if let imageData = event.image {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
    var body: some View {
        List {
            Button("Clear history") {
                confirmDelete.toggle()
            }.alert(isPresented: $confirmDelete) {
                Alert(
                    title: Text("Wipe all history"),
                    message: Text("Are you sure you want to wipe your history? This cannot be undone."),
                    primaryButton: .destructive(Text("Yes"), action: {
                        withAnimation {
                            history.forEach(managedObjectContext.delete)
                            do {
                                try managedObjectContext.save()
                            } catch {
                                // handle the Core Data error
                            }
                        }
                    }),
                    secondaryButton: .cancel(Text("No"))
                )
            }
            ForEach(history, id: \.self) { item in
                HistoryItem(timestamp: item.timestamp!, comment: item.comment ?? "", image: getImage(event: item))
            }.onDelete { (indexSet) in
                withAnimation {
                    indexSet.map({ history[$0] })
                        .forEach(managedObjectContext.delete)
                    do {
                        try managedObjectContext.save()
                    } catch {
                        // handle the Core Data error
                    }
                }
            }
        }
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList()
            .environment(\.locale, Locale(identifier: "fr"))
    }
}
