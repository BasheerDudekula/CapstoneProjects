//
//  EditListView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct EditSlotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var slot: Slot
    @State private var slotDate = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Slot Details")) {
                    DatePicker("Slot Date", selection: $slotDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
            }
            .navigationBarTitle("Edit Slot", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Update") {
                slot.date = slotDate
                saveContext()
                dismiss()
            })
            .onAppear {
                slotDate = slot.date ?? Date()
            }
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
