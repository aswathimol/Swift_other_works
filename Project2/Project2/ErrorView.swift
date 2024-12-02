//
//  ErrorView.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 21/09/23.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("An error occured")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Dismiss"){
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired,
                       guidance: "you can ignore error")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
