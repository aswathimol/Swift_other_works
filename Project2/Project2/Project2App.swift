//
//  Project2App.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 15/09/23.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            // MeetingView()
           
            ScrumsView(scrums: $store.scrums) {
                Task{
                    do {
                        try await store.save(scrums: store.scrums)
                        } catch {
                          errorWrapper = ErrorWrapper(error: error, guidance: "try again")
                     }
                }
            }
                .task {
                    do {
                        try await store.load()
                        
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    store.scrums = DailyScrum.sampleData
                }
        content: {  wrapper in
            ErrorView(errorWrapper: wrapper)
            
        }
            
        }
    }
}
