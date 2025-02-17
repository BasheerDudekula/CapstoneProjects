//
//  DashboardView.swift
//  BookSlot
//
//  Created by admin on 15/02/25.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var user: User
    
    @State private var showAddAvailabilityView = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Tech Tracks")) {
                        ForEach(user.techTracks as? [String] ?? [], id: \.self) { track in
                            Text(track)
                        }
                    }
                    
                    Section(header: Text("Availability Slots")) {
                        if let slots = user.availabilitySlots as? Set<InterviewAvailabilty> {
                            ForEach(Array(slots), id: \.id) { slot in
                                VStack(alignment: .leading) {
                                    Text("\(slot.date ?? Date(), formatter: dateFormatter)")
                                    Text("\(slot.startTime ?? Date(), formatter: timeFormatter) - \(slot.endTime ?? Date(), formatter: timeFormatter)")
                                }
                            }
                            .onDelete(perform: deleteAvailability)
                        }
                    }
                }
            }
            .navigationBarTitle("Dashboard", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddAvailabilityView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddAvailabilityView) {
                InterviewAvailabilityView(user: user)
            }
        }
    }
    
    private func deleteAvailability(at offsets: IndexSet) {
        if let slots = user.availabilitySlots as? Set<InterviewAvailabilty> {
            let slotsArray = Array(slots)
            for index in offsets {
                let slot = slotsArray[index]
                viewContext.delete(slot)
            }
            
            do {
                try viewContext.save()
            } catch {
                print("Error deleting availability: \(error)")
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
}
