//
//  TDButton.swift
//  TodoList
//
//  Created by Barkat Ali Kamran on 2025-02-11.
//

import SwiftUI

struct TDButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            // Action
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

#Preview {
    TDButton(title: "value", background: .pink) {
        // Action
    }
}
