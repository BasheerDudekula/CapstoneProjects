//
//  TechTrackView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct TechTrackView: View {
    @FetchRequest(
        entity: TechTrack.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TechTrack.name, ascending: true)]
    ) var techTracks: FetchedResults<TechTrack>

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var isAuthenticated: Bool

    @State private var newTechTrackName = ""
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {

                List {
                    ForEach(techTracks, id: \.self) { techTrack in
                        NavigationLink(destination: SlotListView(techTrack: techTrack)) {
                            Text(techTrack.name ?? "Unknown Tech Track")
                        }
                        
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteTechTrack(techTrack)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }

                TextField("Enter New Tech Track", text: $newTechTrackName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if showError {
                    Text("Tech Track name cannot be empty!")
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }

                Button("Add Tech Track") {
                    addTechTrack()
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Spacer()

                Button("Logout") {
                    isAuthenticated = false
                }
                .buttonStyle(.bordered)
                .padding()
            }
            .navigationTitle("Tech Track Dashboard")
        }
    }

    // Add new Tech Track
    private func addTechTrack() {
        if newTechTrackName.isEmpty {
            showError = true
        } else {
            let newTechTrack = TechTrack(context: viewContext)
            newTechTrack.name = newTechTrackName
            saveContext()
            newTechTrackName = ""
            showError = false
        }
    }

    // Delete Tech Track
    private func deleteTechTrack(_ techTrack: TechTrack) {
        viewContext.delete(techTrack)
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving Core Data: \(error)")
        }
    }
}

