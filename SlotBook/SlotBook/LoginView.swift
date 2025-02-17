//
//  LoginView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: User.entity(), sortDescriptors: []) private var users: FetchedResults<User>

    @State private var email = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var showError = false

    var body: some View {
        if isAuthenticated {
            TechTrackView(isAuthenticated: $isAuthenticated)
        } else {
            NavigationView {
                VStack {
                    Text("Login Screen")
                        .font(.largeTitle)
                        .padding()

                    TextField("email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    if showError {
                        Text("Invalid username or password!")
                            .foregroundColor(.red)
                    }

                    Button("Login") {
                        authenticateUser(username: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()

                    NavigationLink("Register", destination: RegisterView())
                        .padding()
                }
            }
        }
    }

    private func authenticateUser(username: String, password: String) {
        if users.first(where: { $0.email == email && $0.password == password }) != nil {
            // Successful login
            isAuthenticated = true
            showError = false // Clear error if login is successful
        } else {
            // Handle invalid login here
            showError = true // Show error if login fails
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
