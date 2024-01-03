//
//  Challenge.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 07.06.2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Challenge: Codable {
    @DocumentID var id: String?
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
    let activities: [Activity]
}

struct Activity: Codable {
    let date: Date
    let isComplete: Bool
}
