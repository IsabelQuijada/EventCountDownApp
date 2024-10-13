//
//  EventFormView.swift
//  Event Countdown
//
//  Created by Isabel Quijada on 06.10.24.
//

import SwiftUI

enum FormMode: Equatable {
    case add
    case edit(Event)
}

struct EventForm: View {
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var textColor: Color = .black
    @State private var showAlert = false

    var mode: FormMode
    var onSave: (Event) -> Void
    
    var eventTitle: String {
        if case .edit(let event) = mode {
            return event.title
        }
        return ""
    }

    var body: some View {
        Form {
            Section(header: Text("Event Details")) {
                TextField("Event Title", text: $title)
                
                DatePicker("Event Date", selection: $date, displayedComponents: .date)
                
                ColorPicker("Text Color", selection: $textColor)
            }
        }
        .onAppear {
            setupFormForEditing()
        }
        .navigationTitle(mode == .add ? "Add Event" : "Edit \(eventTitle)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    if title.isEmpty {
                        showAlert = true
                    } else {
                        saveEvent()
                    }
                }
                .disabled(title.isEmpty)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Title"), message: Text("Please enter a title for the event."), dismissButton: .default(Text("OK")))
        }
    }
    

    private func setupFormForEditing() {
        if case .edit(let event) = mode {
            title = event.title
            date = event.date
            textColor = event.textColor
        }
    }


    private func saveEvent() {
        let newEvent = Event(id: UUID(), title: title, date: date, textColor: textColor)
        onSave(newEvent)
    }
}

#Preview {
    EventForm(mode: .add, onSave: { _ in })
}
