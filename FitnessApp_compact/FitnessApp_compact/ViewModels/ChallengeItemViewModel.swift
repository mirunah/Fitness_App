//
//  ChallengeItemViewModel.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 12.06.2023.
//

import SwiftUI

struct ChallengeItemViewModel: Identifiable {
    private let challenge: Challenge
    
    var id: String {
        challenge.id! //force wrap
    }
    
    var title: String {
        challenge.exercise.capitalized //for  creating day 4/21
    }
    
    var progressCircleViewModel: ProgressCircleViewModel {
        let dayNumber = daysFromStart + 1
        let message = isComplete ? "Done" : "\(dayNumber) of \(challenge.length)"
        return .init(
            title: "Day",
            message: message,
            percentageComplete: Double(dayNumber) / Double(challenge.length)
        )
    }
    
    private var daysFromStart: Int {
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day else {
            return 0
        }
        return abs(daysFromStart)
    }
    
    

    var isComplete: Bool {
        daysFromStart - challenge.length >= 0
    }
    
    var statusText: String {
        guard !isComplete else { return "Done" }
        let dayNumber = daysFromStart + 1  //to be 1 at the beginning
        return "Day \(dayNumber) of \(challenge.length)"
    }
    
    var dailyIncreaseText: String {
       "+\(challenge.increase) daily"
    }
    
    private let onDelete: (String) -> Void
    private let onToggleComplete: (String, [Activity]) -> Void
    
    let todayTitle = "Today"
    
    var todayRepTitle: String {
        let repNumber = challenge.startAmount + (daysFromStart * challenge.increase)
        let exercise: String
        if repNumber == 1 {
            var challengeExercise = challenge.exercise
            challengeExercise.removeLast()
            exercise = challengeExercise
        } else {
            exercise = challenge.exercise
        }
        return isComplete ? "Completed" : "\(repNumber) " + exercise
    }
    
    var shouldShowTodayView: Bool {
        !isComplete
    }
    
    var isDayComplete: Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return challenge.activities.first(where: { $0.date == today })?.isComplete == true
    }
    
    init(
        _ challenge: Challenge,
        onDelete: @escaping (String) -> Void,
        onToggleComplete: @escaping (String, [Activity]) -> Void
    ) {
        self.challenge = challenge
        self.onDelete = onDelete
        self.onToggleComplete = onToggleComplete
    }
    
    func tappedDelete() {
        if let id = challenge.id {
            onDelete(id)
        }
    }
    
    func send(action: Action) {
        guard let id = challenge.id else { return }
        switch action {
        case .delete:
            onDelete(id)
        case .toggleComplete:
            let today = Calendar.current.startOfDay(for: Date())
            let activities = challenge.activities.map { activity -> Activity in
                if today == activity.date {
                    return .init(date: today, isComplete: !activity.isComplete)
                } else {
                    return activity
                }
            }
           onToggleComplete(id, activities)
        }
    }
    
}

extension ChallengeItemViewModel {
    enum Action {
        case delete
        case toggleComplete
    }
}
