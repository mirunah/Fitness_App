//
//  ChallengeService.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 07.06.2023.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError>
    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], IncrementError>
    func delete(_ challengeId: String) -> AnyPublisher<Void, IncrementError>
    func updateChallenge(_ challengeId: String, activities: [Activity]) -> AnyPublisher<Void, IncrementError>
}

final class ChallengeService: ChallengeServiceProtocol {
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge) { error in
                    if let error = error {
                        promise(.failure(.default(description: error.localizedDescription)))
                    } else {
                        promise(.success(()))
                    }
                }
                } catch {
                    promise(.failure(.default()))
                }
                }.eraseToAnyPublisher()
    }
    func observeChallenges(userId: UserId) -> AnyPublisher<[Challenge], IncrementError> { //here is our listener
        let query = db.collection("challenges").whereField("userId", isEqualTo: userId).order(by: "startDate", descending: true)
        return Publishers.QuerySnapshotPublisher(query: query)
            .flatMap { snapshot -> AnyPublisher<[Challenge], IncrementError> in
                do {
                    let challenges = try snapshot.documents.compactMap {
                        try $0.data(as: Challenge.self)
                    }
                    return Just(challenges)
                        .setFailureType(to: IncrementError.self)
                        .eraseToAnyPublisher()
                } catch {
                    return Fail(error: .default(description: "Parsingerror"))
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func delete(_ challengeId: String) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            self.db.collection("challenges").document(challengeId).delete { error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func updateChallenge(_ challengeId: String, activities: [Activity]) -> AnyPublisher<Void, IncrementError> {
        return Future<Void, IncrementError> { promise in
            self.db.collection("challenges").document(challengeId).updateData(
                ["activities": activities.map {
                    return ["date": $0.date, "isComplete": $0.isComplete] as [String : Any]
                }
                ]
            )
            { error in
                if let error = error {
                    promise(.failure(.default(description: error.localizedDescription)))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
