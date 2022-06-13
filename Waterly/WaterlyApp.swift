//
//  WaterlyApp.swift
//  Waterly
//
//  Created by James Emselle on 26/6/21.
//

import SwiftUI

@main
struct WaterlyApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
