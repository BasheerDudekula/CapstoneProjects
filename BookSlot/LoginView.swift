//
//  LoginView.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    var onLoginSuccess: (User) -> Void // Closure to pass the logged-in user
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $email)
                    SecureField("Password", text: $password)
                }
            }
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Login") {
                    if let user = loginUser() {
                        onLoginSuccess(user) // Pass the user to ContentView
                        dismiss()
                    }
                }
                .disabled(email.isEmpty || password.isEmpty)
            )
        }
    }
    
    private func loginUser() -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            return users.first // Return the first matched user
        } catch {
            print("Error logging in: \(error)")
            return nil
        }
    }
}

