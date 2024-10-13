//
//  EventsView.swift
//  Event Countdown
//
//  Created by Isabel Quijada on 06.10.24.
//
import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = [
        Event(id: UUID(), title: "Birthday", date: Date().addingTimeInterval(86400), textColor: .blue),
        Event(id: UUID(), title: "Vacation", date: Date().addingTimeInterval(172800), textColor: .green),
        Event(id: UUID(), title: "Christmas", date: Date().addingTimeInterval(700600), textColor: .red),
        Event(id: UUID(), title: "Easter", date: Date().addingTimeInterval(86400), textColor: .blue),
        Event(id: UUID(), title: "Holidays", date: Date().addingTimeInterval(172800), textColor: .green),
        Event(id: UUID(), title: "Family Dinner", date: Date().addingTimeInterval(45600), textColor: .red)
    ]

    @State private var isPresentingForm = false
    @State private var selectedEvent: Event?
    @State private var formMode: FormMode = .add
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(events) { event in
                    NavigationLink(value: event){
                        EventRow(event: event)
                    }
                }
                .onDelete(perform: deleteEvent)
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        formMode = .add
                        isPresentingForm = true
                    }) {
                        Label("Add Event", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingForm) {
                NavigationStack {
                    EventForm(isPresentingForm: $isPresentingForm, mode: formMode) { newEvent in
                        if case .edit(let oldEvent) = formMode {
                            if let index = events.firstIndex(where: { $0.id == oldEvent.id }) {
                                events[index] = newEvent
                            }
                        } else {
                            events.append(newEvent)
                        }
                        events.sort()
                        isPresentingForm = false
                    }
                }
            }
            .navigationDestination(for: Event.self) { event in
                EventForm(isPresentingForm: $isPresentingForm, mode: .edit(event)) { updatedEvent in
                              if let index = events.firstIndex(where: { $0.id == event.id }) {
                                  events[index] = updatedEvent
                                  events.sort()
                              }
                              path.removeLast()
                          }
                      }
                  }
              }
    
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

#Preview {
    EventsView()
}
