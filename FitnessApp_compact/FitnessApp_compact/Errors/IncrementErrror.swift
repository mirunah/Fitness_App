//
//  IncrementErrror.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 11.06.2023.
//

import Foundation

enum IncrementError: LocalizedError {  //this is our custom error
case auth(description: String)
case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let.default(description):
            return description ?? "Something went wrong" //if it's null say this
        }
    }

}
