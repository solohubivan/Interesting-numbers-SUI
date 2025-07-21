//
//  MainViewModel.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 21.07.2025.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class MainViewModel {

    // MARK: - UI Texts
    let mainTitleText = "Interesting Numbers"
    let descriptionText = "This App about facts of Numbers\nand Dates"
    let enterHereLabelText = "Enter here"
    let enterRangeLabelText = "Enter range"
    let fromPlaceholderText = "From"
    let toPlaceholderText = "To"
    let displayFactButtonText = "Display Fact"

    // MARK: - Search Mode
    var selectedSearchMode: SearchMode = .userNumber
    
    // MARK: - Request Handling
    func submitRequest(
        inputText: String,
        rangeFrom: String,
        rangeTo: String,
        requestManager: UserRequestManager
    ) {
        switch selectedSearchMode {
        case .userNumber:
            requestManager.handleUserNumber(inputText)
        case .randomNumber:
            requestManager.handleRandomNumber()
        case .numberInRange:
            requestManager.handleRange(rangeFrom, rangeTo)
        case .multipleNumbers:
            requestManager.handleMultipleNumbers(inputText)
        }
    }
}
