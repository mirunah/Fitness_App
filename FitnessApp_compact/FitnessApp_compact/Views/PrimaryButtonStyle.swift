//
//  PrimaryButtonStyle.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 20.05.2023.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillColor: Color = .darkPrimaryButton
    
    func makeBody(configuration: Configuration) -> some View {
        PrimaryButton(configuration: configuration, fillColor: fillColor)
    }
    
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color 
        
        var body: some View {
            configuration.label
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 8)
                .fill(fillColor))
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Create a challenge")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
