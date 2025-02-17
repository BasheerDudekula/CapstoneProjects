//
//  RegisterView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var registrationSuccess = false

    var body: some View {
        VStack {
            Text("Register")
                .font(.largeTitle)
                .padding()

            TextField("Username", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Register") {
                registerUser()
            }
            .buttonStyle(.borderedProminent)
            .padding()

            if registrationSuccess {
                Text("Registration successful!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    private func registerUser() {
        let newUser = User(context: viewContext)
        newUser.name = name
        newUser.email = email
        newUser.password = password

        do {
            try viewContext.save()
            registrationSuccess = true
        } catch {
            print("Failed to register user: \(error)")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
