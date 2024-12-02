//
//  DetailedEditView.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 18/09/23.
//

import Foundation
import SwiftUI

struct DetailEditView: View {
//    @State private var scrum =  DailyScrum.emptyScrum
    @Binding var scrum: DailyScrum
    @State private var newAttendeename = ""
    var body: some View {
        Form{
            Section(header: Text("Meeting info")){
                TextField("Title", text: $scrum.title)
                HStack{
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1){
                        Text("Length")
                    }
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                    
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                    
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeename)
                    Button(action: {
                        withAnimation{
                            let attendee = DailyScrum.Attendee(name: newAttendeename)
                            scrum.attendees.append(attendee)
                            newAttendeename = ""
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeename.isEmpty)
                }
            }
        }
    }
}
    
    
struct DetailEditView_Previews: PreviewProvider{
        static var previews: some View {
            DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }

