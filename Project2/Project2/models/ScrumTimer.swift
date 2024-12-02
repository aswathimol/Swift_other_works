//
//  ScrumTimer.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 20/09/23.
//

import Foundation

@MainActor           //keyword that is used to ensure a function or class only runs on the main thread.
final class ScrumTimer: ObservableObject  //hey are used to notify views when there's a change in the data they're observing.
{
    struct Speaker: Identifiable {
        let name: String
        var isCompleted: Bool
        let id = UUID()
    }
    
    @Published var activeSpeaker = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    private(set) var speakers: [Speaker] = []
    private(set) var lengthInMinutes: Int
    ///  when new attendee begin to speak
    
    var speakerChangedAction: (() -> Void)?
    private weak var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var lengthInSeconds: Int { lengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?
    
    
    // initialise a new timer so we have to put time as 0 and empty attendee array. self means the current object
    init(lengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
    
    ///  start the timer , so we have to define a function
    func startScrum(){
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true ) { [weak self] timer in
            self?.update()
            
        }
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    func stopScrum(){
        timer?.invalidate()
        timerStopped = true
    }
    // advance the timer to nxt speaker     //  nonisolated:  used to indicate to the compiler that the code inside the method is not accessing (either reading or writing) any of the mutable state inside the actor
    
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex+1)
            
        }
    }
    private func changeToSpeaker(at index: Int){
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForSpeaker = 0
        guard index < speakers.count
        else{
            return
        }
        speakerIndex = index
        activeSpeaker = speakerText
        
        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = lengthInSeconds - secondsElapsed
        startDate = Date()
        
    }
    
    nonisolated private func update() {
        
        
        Task { @MainActor in               // start task in the main actor
            guard let startDate,                // it will check the valid date and check whether the timer is stopper
                  !timerStopped else { return }
            let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            secondsElapsedForSpeaker = secondsElapsed
            self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
            guard secondsElapsed <= secondsPerSpeaker else {
                return
            }
            secondsRemaining = max(lengthInSeconds - self.secondsElapsed, 0)
            
            
            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangedAction?()
            }
        }
    }
    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lengthInSeconds
        activeSpeaker = speakerText
    }
}
 extension Array<DailyScrum.Attendee> {
        var speakers: [ScrumTimer.Speaker] {
            if isEmpty {
                return [ScrumTimer.Speaker(name: "Speaker 1", isCompleted: false)]
            } else {
                return map { ScrumTimer.Speaker(name: $0.name, isCompleted: false) }
            }
        }
}
    

