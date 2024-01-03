//
//  SettingsItemViewModel.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 15.06.2023.
//

import Foundation

extension SettingsViewModel {
    struct SettingsItemViewModel {
        let title: String
        let iconName: String
        let type: SettingsItemType
    }
    
    enum SettingsItemType {
        case account
        case mode
        case privacy
        case logout
    }
}
