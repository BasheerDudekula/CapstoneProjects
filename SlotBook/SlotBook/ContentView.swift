//
//  ContentView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
