//
//  SlotBookApp.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

@main
struct SlotBookApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
