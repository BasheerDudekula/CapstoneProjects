//
//  InterviewAvailabilityView.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//

import SwiftUI

struct InterviewAvailabilityView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var user: User
    @State private var date = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Availability Details")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                }
            }
            .navigationBarTitle("Add Availability", displayMode: .inline)
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    addAvailability()
                    dismiss()
                }
            )
        }
    }
    
    private func addAvailability() {
        let newAvailability = InterviewAvailabilty(context: viewContext)
        newAvailability.id = UUID()
        newAvailability.date = date
        newAvailability.startTime = startTime
        newAvailability.endTime = endTime
        newAvailability.interviewer = user
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving availability: \(error)")
        }
    }
}

