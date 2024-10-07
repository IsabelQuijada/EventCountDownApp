//
//  EventRow.swift
//  Event Countdown
//
//  Created by Isabel Quijada on 06.10.24.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    @StateObject private var timer = TimerManager()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                    .foregroundColor(event.textColor)
                
                Text(relativeDate(for: event.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
        .onAppear {
            timer.start()
        }
        .onDisappear {
            timer.stop()
        }
    }
    
    private func relativeDate(for date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

class TimerManager: ObservableObject {
    @Published var currentDate = Date()
    
    private var timer: Timer?
    
    func start() {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { _ in
            self.currentDate = Date()
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    EventRow(event: .init(id: UUID(), title: "Event Title", date: .init(timeIntervalSince1970: 16760000), textColor: .red))
}
