//
//  CardView.swift
//  Dummy_Project
//
//  Created by Aswathimol S(UST,IN) on 21/09/23.
//

import Foundation
import SwiftUI

struct CardView: View {
    var body: some View {
    
        VStack {
            HStack{
                Text("Design")
            }
            HStack{
                //Text("Hai")
                Label("3" , systemImage: "person.3")
            }
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
