//
//  EventRow.swift
//  Event Countdown
//
//  Created by Isabel Quijada on 06.10.24.
//

import SwiftUI

struct EventRow: View {
    let event: Event

    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.headline)
                .foregroundColor(event.textColor)
            
            Text(relativeDate(for: event.date))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }

    private func relativeDate(for date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

    #Preview {
        EventRow(event: .init(id: UUID(), title: "Event Title", date: .init(timeIntervalSince1970: 16760000), textColor: .red))
    }
