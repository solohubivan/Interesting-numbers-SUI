//
//  View+HideKeyboardOnTap.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 11.07.2025.
//

import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        self.gesture(
            TapGesture().onEnded {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        )
    }
}
