//
//  UserRequestManager.swift
//  Interesting numbers
//
//  Created by Ivan Solohub on 14.07.2025.
//

import Foundation
import NumbersCore
import Observation

@Observable
final class UserRequestManager {
    
    var resultNumber: String = ""
    var resultFact: String = ""
    var showResultView: Bool = false

    private let apiBuilder = APIBuilder()
    private let apiManager = NumbersApiDataManager()

    // MARK: - Methods for External Use
    func handleUserNumber(_ input: String) {
        let cleaned = input.trimmingCharacters(in: .whitespaces)
        guard !cleaned.isEmpty else { return }

        let cleanedNumber = apiBuilder.orderingRequestString(from: cleaned)
        processRequest(requestedNumber: cleanedNumber, type: .trivia(requestedNumber: cleanedNumber))
    }

    func handleRandomNumber() {
        let number = Int.random(in: 0...999)
        processRequest(requestedNumber: "\(number)", type: .trivia(requestedNumber: "\(number)"))
    }

    func handleRange(_ from: String, _ to: String) {
        let fromTrimmed = from.trimmingCharacters(in: .whitespaces)
        let toTrimmed = to.trimmingCharacters(in: .whitespaces)

        guard let fromInt = Int(fromTrimmed), let toInt = Int(toTrimmed) else { return }

        let minVal = min(fromInt, toInt)
        let maxVal = max(fromInt, toInt)

        processRequest(requestedNumber: "\(minVal) - \(maxVal)", type: .range(min: "\(minVal)", max: "\(maxVal)"))
    }

    func handleMultipleNumbers(_ input: String) {
        let cleanedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanedInput.isEmpty else { return }

        let components = cleanedInput
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty && $0.allSatisfy(\.isNumber) }

        guard !components.isEmpty else { return }

        let requestString = components.joined(separator: ",")
        let displayString = components.joined(separator: ", ")

        processRequest(requestedNumber: requestString, displayNumber: displayString, type: .trivia(requestedNumber: requestString))
    }

    // MARK: private methods
    private func processRequest(requestedNumber: String, displayNumber: String? = nil, type: NumberFactType) {
        let urlString = apiBuilder.createLinkForRequest(type: type)

        apiManager.fetchFact(for: urlString) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fact):
                    self.resultNumber = displayNumber ?? requestedNumber
                    self.resultFact = fact.trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
                    self.showResultView = true
                case .failure:
                    break
                }
            }
        }
    }
}
