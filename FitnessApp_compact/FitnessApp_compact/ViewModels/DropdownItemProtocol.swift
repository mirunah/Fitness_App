//
//  DropdownItemProtocol.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 04.06.2023.
//

import SwiftUI

protocol DropdownItemProtocol {
    var options: [DropdownOption] { get }
    var headerTitle: String { get }
    var dropdownTitle: String { get } //derived from selected options
    var isSelected: Bool { get set }
    var selectedOption: DropdownOption { get set }
}

protocol DropdownOptionProtocol {
    var toDropdownOption: DropdownOption { get } //it will be a getter used in CreateChallengeViewMode
}

struct DropdownOption {
    //here we see if the option is either a string or an int or smth else
    enum DropdowmnOptionType {
        case text(String)
        case number(Int)
    }
    let type: DropdowmnOptionType
    let formatted: String
}
