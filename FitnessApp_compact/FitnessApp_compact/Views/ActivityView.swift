//
//  ActivityView.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 17.06.2023.
//

import SwiftUI
import UIKit

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No need for implementation here
    }
}
