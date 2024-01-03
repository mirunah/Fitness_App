//
//  ProgressCircleViewModel.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 16.06.2023.
//

import Foundation

struct ProgressCircleViewModel {
    let title: String
    let message: String
    let percentageComplete: Double
    var shouldShowTitle: Bool {
        percentageComplete <= 1
    }
}
