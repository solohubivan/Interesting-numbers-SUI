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
        case .userNumber: return AppConstants.SearchModeButtonsTitles.userNumber
        case .randomNumber: return AppConstants.SearchModeButtonsTitles.randomNumber
        case .numberInRange: return AppConstants.SearchModeButtonsTitles.numberInRange
        case .multipleNumbers: return AppConstants.SearchModeButtonsTitles.multipleNumbers
        }
    }
}
