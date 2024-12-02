//
//  ContentView.swift
//  Project1
//
//  Created by Aswathimol S(UST,IN) on 14/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            ProgressView(value:  3, total: 10)
        
        
            HStack{
                VStack(alignment: .leading){
                    Text("Second Elapsed").font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing ){
                    Text("Second Remaining")
                    Label("600", systemImage: "hourglass.tophalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("10 minutes")
            Circle()
                .strokeBorder(lineWidth: 21)
            HStack{
                Text("Speaker 1 or 3")
                Spacer()
                Button(action: {}){
                    Image(systemName: "forward.fill")
                }
            }
          .accessibilityLabel("Next speaker")
        }
        .padding()
    }
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
