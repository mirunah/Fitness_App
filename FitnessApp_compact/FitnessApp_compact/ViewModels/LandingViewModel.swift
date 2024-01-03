//
//  LandingViewModel.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 15.06.2023.
//

import Foundation

final class LandingViewModel: ObservableObject {
    @Published var loginSignupPushed = false
    @Published var createPushed = false
    
    let title = "Fitness App"
    let createButtonTitle = "Create a challenge"
    let createButtonImageName = "plus.circle"
    let alreadyButtonTitle = "I already have an account"
    let backgroundImageName = "fit-girl"
}
