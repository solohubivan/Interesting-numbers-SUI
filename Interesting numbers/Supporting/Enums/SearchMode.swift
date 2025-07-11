//
//  SearchMode.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 11.07.2025.
//

enum SearchMode: Int, CaseIterable, Identifiable {
    case userNumber
    case randomNumber
    case numberInRange
    case multipleNumbers

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .userNumber: return "User Number"
        case .randomNumber: return "Random Number"
        case .numberInRange: return "Number in a range"
        case .multipleNumbers: return "Multiple numbers"
        }
    }
}
