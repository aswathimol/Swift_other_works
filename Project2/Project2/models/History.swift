//
//  History.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 20/09/23.
//

import Foundation

struct History: Identifiable,Codable{
    
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    
    
    internal init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
    
    
}


