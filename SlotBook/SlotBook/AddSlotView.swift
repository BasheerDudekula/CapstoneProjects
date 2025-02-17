//
//  AddSlotView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct AddSlotView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var slotDate = Date()
    var techTrack: TechTrack

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Slot Details")) {
                    DatePicker("Slot Date", selection: $slotDate, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
            }
            .navigationBarTitle("Add New Slot", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                dismiss()
            }, trailing: Button("Save") {
                addSlot()
                dismiss()
            })
        }
    }

    private func addSlot() {
        let newSlot = Slot(context: viewContext)
        newSlot.date = slotDate
        newSlot.techTrack = techTrack

        do {
            try viewContext.save()
        } catch {
            print("Error saving slot: \(error)")
        }
    }
}
