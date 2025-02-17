//
//  RegistrationView.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct RegistrationView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var techTracks = ""
    
    var onRegistrationSuccess: (User) -> Void // Closure to pass the registered user
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
                
                Section(header: Text("Tech Tracks")) {
                    TextField("Enter Tech Tracks (comma separated)", text: $techTracks)
                }
            }
            .navigationBarTitle("Register", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    if let user = registerUser() {
                        onRegistrationSuccess(user) // Pass the registered user to ContentView
                        dismiss()
                    }
                }
                .disabled(name.isEmpty || email.isEmpty || password.isEmpty || techTracks.isEmpty)
            )
        }
    }
    
    private func registerUser() -> User? {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.name = name
        newUser.email = email
        newUser.password = password
        newUser.techTracks = techTracks.components(separatedBy: ",") as NSObject
        do {
            try viewContext.save()
            return newUser // Return the created user
        } catch {
            print("Error saving user: \(error)")
            return nil
        }
    }
}

