//
//  TextFieldCustomRoundedStyle.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 15.06.2023.
//

import SwiftUI

struct TextFieldCustomRoundedStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.primary)
            .padding()
            .cornerRadius(16)
            .overlay(
            RoundedRectangle(
            cornerRadius: 16
            ).stroke(
                Color.primary
            )
            )
            .padding(.horizontal, 15)
    }
}
