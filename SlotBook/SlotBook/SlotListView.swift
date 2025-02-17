//
//  SlotListView.swift
//  SlotBook
//
//  Created by admin on 16/02/25.
//

import SwiftUI

struct SlotListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Slot.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Slot.date, ascending: true)])
    private var slots: FetchedResults<Slot>

    @State private var showAddSlotView = false
    @State private var slotToEdit: Slot?

    var techTrack: TechTrack

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(slots.filter { $0.techTrack == techTrack }) { slot in
                        NavigationLink(destination: EditSlotView(slot: slot)) {
                            VStack(alignment: .leading) {
                                Text(slot.date ?? Date(), formatter: dateFormatter)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteSlot(slot)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Slots for \(techTrack.name ?? "Unknown Track")")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddSlotView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSlotView) {
                AddSlotView(techTrack: techTrack)
            }
        }
    }

    private func deleteSlot(_ slot: Slot) {
        viewContext.delete(slot)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting slot: \(error)")
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
