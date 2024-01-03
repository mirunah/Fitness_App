//
//  CreateChallengeViewModel.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 04.06.2023.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject {
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    
    @Published var error: IncrementError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
        case .createChallenge:
            isLoading = true
            currentUserId().flatMap { userId -> AnyPublisher<Void, IncrementError> in
                return self.createChallenge(userId: userId)
            }
              .sink { completion in
                  self.isLoading = false
                switch completion {
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("finished")
                }
            } receiveValue: { _ in
                print("success")
            }.store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, IncrementError> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else {
            return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
        }
        
        let startDate = Calendar.current.startOfDay(for: Date())
        
        let challenge = Challenge(
            exercise: exercise,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: startDate,
            activities: (0..<length).compactMap { dayNum in
                if let dateForDayNum = Calendar.current.date(byAdding: .day, value: dayNum, to: startDate) {
                    return .init(date: dateForDayNum, isComplete: false)
                } else {
                    return nil
                }
            }
        )
        
        return challengeService.create(challenge).eraseToAnyPublisher()
        
    }
    
    
    private func currentUserId() -> AnyPublisher<String, IncrementError> {
        print("getting user id")
        return userService.currentUserPublisher().flatMap { user -> AnyPublisher<UserId, IncrementError> in
//        return Fail(error: .auth(description: "some firebase auth error")).eraseToAnyPublisher()
            if let userId = user?.uid {
                print("user is logged in...")
                return Just(userId)
                    .setFailureType(to: IncrementError.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is being logged in anonymously...")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
            //pana aici trebuia comentat
        }.eraseToAnyPublisher()
    }

    }



extension CreateChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue //it will be driven by raw val from cases
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        private let type: ChallengePartType
        
        init(type: ChallengePartType) { //we set an initializer
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.toDropdownOption } //this will give us back the initialized version of DropdownOption from line 47
            case.startAmount:
                self.options = StartOption.allCases.map { $0.toDropdownOption }
            case.increase:
                self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
            case.length:
                self.options = LengthOption.allCases.map { $0.toDropdownOption }
            }
            self.type = type
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable { //here we define the options
            case exercise = "Excercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        } //we need an enum for each specific case for defining a challenge
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .text(rawValue),
                    formatted: rawValue.capitalized
                )
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue)" //string of a raw value
                )
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "+\(rawValue)" //string of a raw value with increase
                )
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(
                    type: .number(rawValue),
                    formatted: "\(rawValue) days"
                )
            }
        }
        
    }
}


extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
