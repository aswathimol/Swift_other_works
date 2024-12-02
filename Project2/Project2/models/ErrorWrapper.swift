//
//  ErrorWrapper.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 21/09/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    
    let id: UUID
    let error: Error
    let guidance: String
    
     init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
    
   
    
}
