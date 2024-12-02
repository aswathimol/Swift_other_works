//
//  Reminder.swift
//  Today
//
//  Created by Aswathimol S(UST,IN) on 25/09/23.
//

import Foundation

struct Reminder {
    var title: String
    var dueDate: Date
    var notes: String? = nil
    var isComplete:Bool = false
}

#if DEBUG
extension Reminder {
    static var sampleData = [
        Reminder( title: "Submit reimbursement report", dueDate: Date().addingTimeInterval(800.0),
                  notes: "Don't forget about taxi receipts"),
        Reminder(
                   title: "Code review", dueDate: Date().addingTimeInterval(14000.0),
                   notes: "Check tech specs in shared folder", isComplete: true),
               Reminder(
                   title: "Pick up new contacts", dueDate: Date().addingTimeInterval(24000.0),
                   notes: "Optometrist closes at 6:00PM"),
               Reminder(
                   title: "Add notes to retrospective", dueDate: Date().addingTimeInterval(3200.0),
                   notes: "Collaborate with project manager", isComplete: true),
               Reminder(
                   title: "Interview new project manager candidate",
                   dueDate: Date().addingTimeInterval(60000.0), notes: "Review portfolio"),
               Reminder(
                   title: "Mock up onboarding experience", dueDate: Date().addingTimeInterval(72000.0),
                   notes: "Think different")
    ]
}
#endif
