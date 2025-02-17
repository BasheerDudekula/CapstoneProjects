//
//  ContentView.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // State to manage navigation
    @State private var isLoggedIn = false
    @State private var showRegistrationView = false
    @State private var currentUser: User? // Track the logged-in user

    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn, let user = currentUser {
                    // Show DashboardView if logged in
                    DashboardView(user: user)
                } else {
                    // Show LoginView if not logged in
                    LoginView(onLoginSuccess: { user in
                        currentUser = user
                        isLoggedIn = true
                    })
                    .navigationTitle("Login")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Register") {
                                showRegistrationView = true
                            }
                        }
                    }
                    .sheet(isPresented: $showRegistrationView) {
                        RegistrationView(onRegistrationSuccess: { user in
                            currentUser = user
                            isLoggedIn = true
                        })
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
