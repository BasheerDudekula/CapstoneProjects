//
//  BookSlotApp.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//

import SwiftUI

@main
struct BookSlotApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,persistenceController.container.viewContext)
        }
    }
}
