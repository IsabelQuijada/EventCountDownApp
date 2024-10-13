//
//  EventCountdownTests.swift
//  EventCountdownTests
//
//  Created by Isabel Quijada on 13.10.24.
//

import XCTest
@testable import EventCountdown

class EventCountdownTests: XCTestCase {

    func testAddingEvent() throws {
        var events: [Event] = []
        
        let newEvent = Event(id: UUID(), title: "Test Event", date: Date(), textColor: .red)
        
        events.append(newEvent)
        
        XCTAssertEqual(events.count, 1, "Event List should contain 1 event")
        XCTAssertEqual(events.first?.title, "Test Event", "The events title should be: 'Test Event'")
        XCTAssertEqual(events.first?.textColor, .red, "Text color should be red")
    }
    
    func testEditingEvent() throws {
        var events: [Event] = [
            Event(id: UUID(), title: "Original Event", date: Date(), textColor: .blue)
        ]
        
        XCTAssertEqual(events.first?.title, "Original Event")
        XCTAssertEqual(events.first?.textColor, .blue)
        
        if let index = events.firstIndex(where: { $0.title == "Original Event" }) {
            events[index].title = "Updated Event"
            events[index].textColor = .red
            events[index].date = Date()
        }
        
        XCTAssertEqual(events.first?.title, "Updated Event", "The title of the event shoudl have been updated")
        XCTAssertEqual(events.first?.textColor, .red, "Text color should be modified to red")
        XCTAssertEqual(events.first?.textColor, .red, "Date should be updated")
    }
    
    func testDeletionEvent() throws {
        var events: [Event] = [
            Event(id: UUID(), title: "Learn Swift", date: Date(), textColor: .blue),
            Event(id: UUID(), title: "Christmas", date: Date(), textColor: .green),
            Event(id: UUID(), title: "Birthday Party", date: Date(), textColor: .red),
            Event(id: UUID(), title: "Grocery Shopping", date: Date(), textColor: .orange)
        ]
        
        events.remove(at: 3)
        
        XCTAssertEqual(events.count, 3, "Events List should contain 3 events")
        
    }
}
