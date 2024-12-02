//
//  ThemeView.swift
//  Project2
//
//  Created by Aswathimol S(UST,IN) on 19/09/23.
//

import Foundation
import SwiftUI

struct ThemeView: View {
    let theme: Theme
    
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .foregroundColor(theme.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .teal)
    }
}
